local keymap = vim.keymap
local leap = require('leap')
local api = vim.api

local ns = vim.api.nvim_create_namespace('leap_custom')
local prio = 65535

leap.setup({
  highlight_unlabeled_phase_one_targets = false,
})

local hex_to_rgb = function(hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)
  assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))
  local red, green, blue = string.match(hex_str, pat)
  return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

local blend = function(fg, bg, alpha)
  fg = hex_to_rgb(fg)
  bg = hex_to_rgb(bg)
  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end
  return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

local hl_char_one = '#FFFFFF'
local hl_char_two = blend(hl_char_one, '#565c64', .5)
vim.api.nvim_set_hl(0, 'LeapHighlightChar1', {fg = '#FFFFFF', bold = true})
vim.api.nvim_set_hl(0, 'LeapHighlightChar2', {fg = hl_char_two, bold = true})

local extmarks = {}
local state = { prev_input = nil }

local function custom_motion(kwargs)
  require('leap').opts.safe_labels = {}
  local function get_input()
    vim.cmd('echo ""')
    local hl = require('leap.highlight')
    if vim.v.count == 0 and not (kwargs.unlabeled and vim.fn.mode(1):match('o')) then
      hl['apply-backdrop'](hl, kwargs.cc.backward)
    end
    hl['highlight-cursor'](hl)
    vim.cmd('redraw')
    local ch = require('leap.util')['get-input-by-keymap']({str = ">"})
    hl['cleanup'](hl, { vim.fn.getwininfo(vim.fn.win_getid())[1] })
    if not ch then
      return
    end
    -- Repeat with the previous input?
    local repeat_key = require('leap.opts').special_keys.repeat_search
    if ch == api.nvim_replace_termcodes(repeat_key, true, true, true) then
      if state.prev_input then
        ch = state.prev_input
      else
        require('leap.util').echo('no previous search')
        return
      end
    else
      state.prev_input = ch
    end
    return ch
  end

  local function get_pattern(input, max)
    local chars = require('leap.opts').eq_class_of[input]
    if chars then
      chars = vim.tbl_map(function (ch)
        if ch == '\n' then
          return '\\n'
        elseif ch == '\\' then
          return '\\\\'
        else return ch end
      end, chars or {})
      input = '\\(' .. table.concat(chars, '\\|') .. '\\)'  -- "\(a\|b\|c\)"
    end
    return '\\V' .. (kwargs.multiline == false and '\\%.l' or '') .. input
  end

  local function get_targets(pattern, max)
    local search = require('leap.search')
    local bounds = search['get-horizontal-bounds']()
    local get_char_at = require('leap.util')['get-char-at']
    local targets = {}
    for pos in search['get-match-positions'](
        pattern, bounds, { ['backward?'] = kwargs.cc.backward }
    ) do
      local char1 = get_char_at(pos, {})
      local char2 = get_char_at({pos[1], pos[2]+1}, {})
      table.insert(targets, { pos = {pos[1], pos[2]+1 }, chars={ char1, char2 } })
    end
    return targets
  end

  -- local get_targets = require('leap.search')['get-targets']
  local input = get_input()
  local pattern = get_pattern(input)
  local targets = get_targets(pattern, {})
  for _, target in ipairs(targets) do
    local extmark_pos = tostring(target.pos[1]) .. ':' .. tostring(target.pos[2])
    extmarks[extmark_pos] = {
      vim.api.nvim_buf_set_extmark(0, ns, target.pos[1]-1, target.pos[2]-2, {
        hl_group = 'LeapHighlightChar1',
        end_col = target.pos[2]-1,
        strict = false,
        priority = prio,
      }),
      vim.api.nvim_buf_set_extmark(0, ns, target.pos[1]-1, target.pos[2]-1, {
        hl_group = 'LeapHighlightChar2',
        end_col = target.pos[2],
        strict = false,
        priority = prio,
      })
    }
  end
  local input2 = get_input()
  if input2 then
    input = input .. input2
  else
    return {}
  end
  pattern = get_pattern(input)
  local new_targets = get_targets(pattern, {})

  for i, target in ipairs(new_targets) do
    extmarks[tostring(target.pos[1]) .. ':' .. tostring(target.pos[2]-1)] = nil
    new_targets[i].pos = { target.pos[1], target.pos[2]-1 }
  end

  for _, id in pairs(extmarks) do
    vim.api.nvim_buf_del_extmark(0, ns, id[1])
    vim.api.nvim_buf_del_extmark(0, ns, id[2])
  end
  return new_targets
end

local create_mappings = function ()
  local modes = { 'n', 'x', 'o' }
  local opts = { noremap = true, silent = true }
  local mappings = {
    ['s'] = { backward = false },
    ['S'] = { backward = true },
  }
  for mapping, opt in pairs(mappings) do
    keymap.set(modes, mapping, function ()
      require('leap').leap({
        targets = custom_motion({ cc =  opt }),
        offset = 0
      })
    end, opts)
  end
end

create_mappings()

vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

vim.api.nvim_set_hl(0, 'LeapMatch', {
  fg = 'white',
  bold = true,
  nocombine = true,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'LeapLeave',
  callback = function ()
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  end
})
-- local hl = {
--   LeapMatch = {fg = "#7123f9", bg = "#7123f9"},
--   LeapLabelSecondary = {fg = "#7123f9", bg = "#7123f9"},
--   LeapLabelPrimary = {fg = "#7123f9", bg = "#7123f9"},
-- }
-- for k,v in pairs(hl) do vim.api.nvim_set_hl(0, k, v) end
-- require('leap').init_highlight(true)



-- leap.add_default_mappings()

-- local util = require("leap.util")
-- local inc = util["inc"]
-- local dec = util["dec"]

-- local cleanup = require('leap.highlight').cleanup

-- require('leap.highlight').cleanup = function (self, affected_windows)
--   print('User can make callback with extmark info here')
--   cleanup(self, affected_windows)
-- end
--
-- local leap_user_ns = api.nvim_create_namespace("leap_user_ns")
--
-- local user_extmarks = {}
--
-- local cleanup_copy = loadfile('leap.highlight')
--
-- print(cleanup_copy)
-- local cleanup_callback = function (bufnr, ns, id)
--   local beacon_extmark = vim.api.nvim_buf_get_extmark_by_id(bufnr, ns, id);
--   local row, col = unpack(beacon_extmark)
--   local user_extmark_id = vim.api.nvim_buf_get_extmark_by_id(bufnr, ns, id);
--   vim.api.nvim_buf_del_extmark(bufnr, leap_user_ns id)
--
--   vim.api.nvim_buf_set_extmark(0, ns, target.pos[1]-1, target.pos[2]-2, {
--     hl_group = 'LeapHighlightChar1',
--     end_col = target.pos[2]-1,
--     strict = false,
--     priority = prio,
--   }),
--   vim.api.nvim_buf_set_extmark()
-- end

