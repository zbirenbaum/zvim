local util = require('vim.lsp.util')
local api = vim.api
local trigger_chars = { '(',',', ')' }

-- you literally just need to fix the fucking offset logic
-- so god damn annoying

local M = {
  existing_mark = nil,
  label_cache = {},
  active_index = nil,
  ns = vim.api.nvim_create_namespace('signature_help'),
}

-- you know theres probably a way to just pass this to fucking treesitter
local format_parameters = function (prefix, parameters, suffix)
  local vt_map = {}

  local get_parameters_for_active = function (active_index)
    local vt_target = {}
    for i, param in ipairs(parameters) do
      local hl = i == active_index and '@parameter' or '@comment'
      table.insert(vt_target, {param, hl})
      if i ~= #parameters then
        table.insert(vt_target, {', ', '@punctuation'})
      end
    end
    return vt_target
  end

  for active_index=1, #parameters do
    vt_map[active_index] = vim.tbl_deep_extend('force', {}, prefix)

    for _, tuple in ipairs(get_parameters_for_active(active_index)) do
      table.insert(vt_map[active_index], tuple)
    end

    for _, tuple in ipairs(suffix) do
      table.insert(vt_map[active_index], tuple)
    end
  end
  return vt_map
end

local format = function (label)
  local get_prefix = function ()
    local prefix = {}
    local space_pos = label:find('%s')
    local type_string = label:sub(1, space_pos-1)
    table.insert(prefix, {type_string, '@keyword.' .. type_string})
    table.insert(prefix, {': ', '@punctuation' })
    local name_end = label:find('%(')-1
    local name = label:sub(space_pos+1, name_end)
    table.insert(prefix, {name, '@' .. type_string})
    table.insert(prefix, {'(', '@punctuation'})
    return prefix
  end
  local get_suffix = function ()
    local suffix = {}
    table.insert(suffix, {')', '@punctuation'})
    return suffix
  end
  local prefix = get_prefix()
  local suffix = get_suffix()
  local param_string = label:match("%((.-)%)")
  local parameters = vim.fn.split(param_string, ', ')
  local vt_by_active = format_parameters(prefix, parameters, suffix)
  return vt_by_active
end

M.pre_text = ''

M.generate_vtext_for_label = function (label)
  if vim.fn.mode() ~= 'i' then
    vim.api.nvim_buf_clear_namespace(0, M.ns, 0, -1)
    M.existing_mark = nil
    return
  end

  vim.api.nvim_clear_autocmds({
    group = 'signatureHelp',
  })
  local active_parameter = M.active_index
  local active_index = active_parameter
  local vt = M.label_cache[label]['vtext_map'][active_index]
  if not vt then return end
  local pos = M.label_cache[label]['pos']
  -- print(vim.inspect(pos))

  M.existing_mark = vim.api.nvim_buf_set_extmark(0, M.ns, pos['line'], 0, {
    virt_text = vt,
    virt_text_pos = 'eol',
    hl_mode = 'combine',
    priority = 1000,
  })
  -- vim.api.nvim_create_autocmd({'InsertCharPre'}, {
  --   group = 'signatureHelp',
  --   callback = function ()
  --     print(vim.api.nvim_win_get_cursor(0)[1])
  --     print(pos['line'])
  --     local char = api.nvim_get_vvar('char')
  --     if char == ',' then
  --       M.active_index = M.active_index + 1
  --       M.generate_vtext_for_label(label)
  --     end
  --     if vim.api.nvim_win_get_cursor(0)[1] ~= pos.line then
  --       M.existing_mark = nil
  --       vim.api.nvim_buf_clear_namespace(0, M.ns, 0, -1)
  --       M.create_trigger()
  --       return
  --     end
  --   end
  -- })
end


M.handle_sig_help = function (_, result, ctx)
  if not result or not ctx or not ctx.params then
    return
  end

  if M.existing_mark then
    vim.api.nvim_buf_clear_namespace(0, M.ns, 0, -1)
    M.existing_mark = nil
  end

  local signature = result.signatures[1]
  local label = signature.label

  if not M.label_cache[label] then
    M.label_cache[label] = {
      pos = ctx.params.position,
      vtext_map = format(label),
      signature = signature,
    }
  end

  M.active_index = signature.activeParameter+1
  M.generate_vtext_for_label(label)
end

M.signature_group = vim.api.nvim_create_augroup('signatureHelp', {
  clear = true,
})

M.trigger = function (bufnr)
  local win = vim.api.nvim_get_current_win()
  if not vim.api.nvim_win_get_buf(win) == bufnr then return end
  local pos_params = util.make_position_params(win, 'utf-8')
  vim.lsp.buf_request(bufnr, 'textDocument/signatureHelp', pos_params)
end

M.create_trigger = function ()
  vim.api.nvim_create_autocmd({'InsertCharPre'}, {
    -- group = 'signatureHelp',
    callback = function (params)
      if vim.fn.mode() ~= 'i' then return end
      local bufnr = params['buf'] or vim.api.nvim_get_current_buf()
      -- local char = api.nvim_get_vvar('char')
      -- if vim.tbl_contains(trigger_chars, char) then
      --   M.trigger(bufnr)
      -- end
      M.trigger(bufnr)
    end,
  })
  vim.api.nvim_create_autocmd({'InsertLeave', 'CursorMovedI'}, {
    callback = function ()
      vim.api.nvim_buf_clear_namespace(0, M.ns, 0, -1)
      M.existing_mark = nil
    end,
  })
  vim.api.nvim_create_autocmd({'ModeChanged'}, {
    callback = function ()
      if vim.fn.mode() ~= 'i' then
        vim.api.nvim_buf_clear_namespace(0, M.ns, 0, -1)
        M.existing_mark = nil
      end
    end,
  })
end

vim.lsp.handlers['textDocument/signatureHelp'] = M.handle_sig_help

return M
