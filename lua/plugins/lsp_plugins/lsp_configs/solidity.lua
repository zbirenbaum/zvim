local M = {}
local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

M.config_table = function (_, _)
  return {
    cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
    filetypes = { 'solidity' },
    root_dir = lspconfig.util.find_git_ancestor,
    single_file_support = true,
  }
end

return M
