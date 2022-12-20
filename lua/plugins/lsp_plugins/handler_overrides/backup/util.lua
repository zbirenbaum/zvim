-- @params text: string, pos: cursor pos, signature: function signature from lsp
local get_active_parameter = function ()
end

local line_before_cursor = function (pos)
  return vim.api.nvim_buf_get_text(0, pos[1]-1, 0, pos[1]-1, pos[2], {})
end

local get_instances = function (text, char)
  return vim.fn.split(text, char)
end

-- takes table of chars and gets last instance of char in text recursively
local get_last_instance_in = function (text, char)
  local instances = get_instances(text, char)
  return instances[#instances]
end

local calc_active_param = function (text)
  if not text then return end
  local is_closed=  get_last_instance_in(text, ')')
  local target_fn = get_last_instance_in(text, "(")
  local active = #get_instances(target_fn, ",")
  return active
end

local test = function ()
  local pos = vim.api.nvim_win_get_cursor(0)
  local text = line_before_cursor(pos)
  print(calc_active_param(text))
end

test()
