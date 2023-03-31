local util = require 'lspconfig.util'

local mason = vim.fn.stdpath("data") .. "/mason/" .. "bin/"
local bin_name = mason .. "graphql-lsp"

local cmd = { bin_name, 'server', '-m', 'stream' }

return {
  config_table = function (attach, capabilities)
    return {
      cmd = cmd,
      filetypes = { 'graphql', 'typescriptreact', 'javascriptreact' },
      root_dir = util.root_pattern('.git', '.graphqlrc*', '.graphql.config.*', 'graphql.config.*'),
      attach = attach,
      capabilities = capabilities,
    }
  end
}
