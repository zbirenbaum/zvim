local M = {}
local util = require 'lspconfig.util'
local bin_name = 'hardhat-vscode'
if vim.fn.has 'win32' == 1 then bin_name = bin_name .. '.cmd' end

require("lspconfig.configs").hardhat_vscode = {
  default_config = {
    name = "hardhat-vscode",
    autostart = true,
    single_file_support = true,
    cmd = { bin_name, '--stdio' },
    filetypes = { "solidity" },
    root_dir = function(fname)
      local markers = { 'hardhat.config.*' }
      return util.root_pattern(unpack(markers))(fname)
      or util.find_git_ancestor(fname)
      or util.path.dirname(fname)
    end,
  }
}


M.config_table = function (attach, capabilities)
  return {
    on_attach = attach,
    capabilities = capabilities,
    cmd = { bin_name, '--stdio' },
    filetypes = { 'solidity' },
    root_dir = function(fname)
      local markers = { 'hardhat.config.*' }
      return util.root_pattern(unpack(markers))(fname)
      or util.find_git_ancestor(fname)
      or util.path.dirname(fname)
    end,
  }
end

return M
