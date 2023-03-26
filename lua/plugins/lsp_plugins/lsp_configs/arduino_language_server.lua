local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

local config_table = function(attach, capabilities)
  local fqbn = 'arduino:avr:uno'
  attach = function (client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
    attach(client, bufnr)
  end
  return {

    attach = attach,
    capabilities = capabilities,
    cmd = {
      'arduino-language-server',
      '-cli-config', '/home/zach/.arduino15/arduino-cli.yaml',
      '-fqbn', fqbn,
      '-clangd', '/home/zach/.local/share/nvim/mason/bin/clangd'
    },
    root_dir = util.root_pattern('arduino-cli.yaml', '.git'),
  }
end

return {
  config_table = config_table,
}

