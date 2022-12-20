local repl = {
  name = "repl",
  bufnr = nil,
  winid = nil,
  augroup = vim.api.nvim_create_augroup('repl', { clear = true }),
  session = nil,
}

function repl:hide() vim.api.nvim_win_hide(self.winid) end
function repl:exit() vim.api.nvim_win_close(self.winid, true) end
function repl:clear()
  vim.api.nvim_buf_set_option(self.bufnr, 'buftype', 'nofile')
  vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, {})
  vim.api.nvim_buf_set_option(self.bufnr, 'buftype', 'prompt')
  self:init_prompt()
  vim.cmd('startinsert')
end

function repl:help()
  self:display({
    "Available commands:",
    ".exit: Exit the repl",
    ".hide: Hide the repl",
    ".clear: Clear the repl"
  })
end

function repl:execute_command (cmd)
  local map = {
    ['.exit'] = function () self:exit() end,
    ['.hide'] = function () self:hide() end,
    ['.clear'] = function () self:clear() end,
    ['.help'] = function () self:help() end
  }
  if map[cmd] then
    map[cmd]()
  else
    self:display("Unknown command: " .. cmd)
    self:help()
  end
end

local function get_display_lines(text)
  local lines = vim.split(text, "\n", { plain = true, trimempty = true })

  if #lines == 1 then
    return lines
  end

  local extra_indent = math.min(unpack(vim.tbl_map(function(line)
    return #(string.match(line, "^%s*") or "")
  end, lines)))

  if extra_indent > 0 then
    for i, line in ipairs(lines) do lines[i] = line:sub(1, extra_indent) end
  end

  return lines
end

function repl:display(value)
  local lines = get_display_lines(value)
  for _, line in ipairs(lines) do
    vim.api.nvim_buf_call(self.bufnr, function ()
      vim.fn.append(vim.fn.line("$")-1, line)
    end)
  end
end

function repl:init_prompt()
  local evaluate_handler = function (err, resp)
    if err then return self:display(err) end
    self:display(resp.result)
  end

  vim.fn.prompt_setprompt(self.bufnr, "repl> ")
  vim.fn.prompt_setcallback(self.bufnr, function(input)
    if input:sub(1, 1) == "." then
      self:execute_command(input)
    elseif self.session then
      self.session:evaluate(input, evaluate_handler)
    else
      self:ensure_session()
      if not self.session then
        self:display("No session available")
      end
      self.session:evaluate(input, evaluate_handler)
    end
  end)
end

function repl:ensure_bufnr()
  self.bufnr = vim.api.nvim_create_buf(false, true)
  for name, value in pairs({
    bufhidden = "hide",
    buflisted = false,
    buftype = "nofile",
    swapfile = false,
    undolevels = 0,
  }) do
    vim.api.nvim_buf_set_option(self.bufnr, name, value)
  end

  vim.api.nvim_create_autocmd("BufEnter", {
    group = self.augroup,
    buffer = self.bufnr,
    callback = function()
      vim.api.nvim_buf_set_option(self.bufnr, 'buftype', 'prompt')
      self:init_prompt()
    end,
    once = false,
  })

  vim.api.nvim_create_autocmd("QuitPre", {
    group = self.augroup,
    buffer = self.bufnr,
    callback = function()
      vim.api.nvim_buf_set_option(self.bufnr, 'buftype', 'nofile')
      vim.api.nvim_buf_set_option(self.bufnr, 'modified', false)
    end,
    once = true,
  })
end

function repl:ensure_winid()
  if self.winid and vim.api.nvim_win_is_valid(self.winid) then return end
  if not self.bufnr then return end
  local height = math.floor(vim.api.nvim_win_get_height(0) * 0.4)

  self.winid = vim.api.nvim_win_call(0, function()
    vim.cmd("silent noswapfile " .. tostring(height) .. "split")
    return vim.api.nvim_get_current_win()
  end)

  vim.api.nvim_win_set_buf(self.winid, self.bufnr)

  for name, value in pairs({
    fcs = "eob: ",
    list = false,
    number = false,
    numberwidth = 1,
    relativenumber = false,
    signcolumn = "no",
  }) do
    vim.api.nvim_win_set_option(self.winid, name, value)
  end

  vim.api.nvim_create_autocmd("WinClosed", {
    group = self.augroup,
    pattern = tostring(self.winid),
    callback = function()
      if vim.api.nvim_buf_is_valid(self.bufnr) then
        vim.api.nvim_buf_set_option(self.bufnr, 'buftype', 'nofile')
      end
      vim.api.nvim_clear_autocmds({ group = self.augroup })
      self.winid = nil
    end,
    once = true,
  })
end

function repl:ensure_session()
  if not self.session then
    local dap_session = require('dap').session()
    if not dap_session then
      print('No active debug session')
      return
    end
    self.session = dap_session
  end
end

function repl:init()
  self:ensure_session()
  self:ensure_bufnr()
  self:ensure_winid()
end

repl:init()
