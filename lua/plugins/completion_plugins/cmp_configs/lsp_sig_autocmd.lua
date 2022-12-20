local api = vim.api
local helper = require('lsp_signature.helper')
local lsp_signature = require('lsp_signature')

local sig_cfg = {
  bind = true,
  hint_enable = true,
  hint_prefix = '',
  floating_window = false,
  transparency = 100,
  hint_scheme = 'String',
  doc_lines=0,
  extra_trigger_chars = { '(', ',', ')' },
  fix_pos = false,
  hi_parameter = "LspSignatureActiveParameter",
  handler_opts = {
    border = "none", -- double, single, shadow, none
  },
  floating_window_off_x = 2, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position.
}

local ns = api.nvim_create_namespace('testing_ns')

local show_hint = function (hint)
  local r = vim.api.nvim_win_get_cursor(0)
  local line = r[1] - 1 -- line number of current line, 0 based
  local vt = { '' .. sig_cfg.hint_prefix .. hint, sig_cfg.hint_scheme }
  return vim.api.nvim_buf_set_extmark(0, ns, line, 0, {
    virt_text = { vt },
    virt_text_pos = "eol",
    hl_mode = "combine",
    -- hl_group = sig_cfg.hint_scheme
  })
end
local register_autocmd = function ()
  local signature_table = { hint_prefix = '', hint = ''}
  local current_hint = nil
  local current_extmark = nil
  vim.api.nvim_create_autocmd({"TextChangedI", "TextChangedP", "InsertCharPre"}, {
    callback = function ()
      vim.schedule(function ()
        signature_table = lsp_signature.status_line(300)
        local hint = signature_table.label

        if hint == nil or hint == "" then
          vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
          return
        end
        print(vim.inspect(signature_table))

        local extmark_exists = function ()
          if not current_extmark then return false end
          return #api.nvim_buf_get_extmark_by_id(0, ns, current_extmark, {}) > 0
        end

        if current_hint ~= hint or not extmark_exists() then
          vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
          current_hint = hint
          current_extmark = show_hint(current_hint)
        end
      end)
    end
  })
  vim.api.nvim_create_autocmd({"InsertLeave"}, {
    callback = function ()
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
    end
  })
end

return { register_autocmd = register_autocmd }

