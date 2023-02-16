local M = {}
local mason_dir = vim.fn.stdpath('data') .. '/mason/bin/'

M.config_table = function (attach, capabilities)
  return {
    cmd = { mason_dir .. 'bash-language-server', 'start' },
    attach = attach,
    capabilities = capabilities,
  }
end

return M
