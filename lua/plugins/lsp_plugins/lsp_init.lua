local default_lsp_config = function(attach, capabilities)
  local default_config = {
    on_attach = attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
  return default_config
end

local setup_func = function(completion_engine, config_table)
  if completion_engine == "coq" then
    local coq = require("coq")
    return coq.lsp_ensure_capabilities(config_table)
  else
    return config_table
  end
end

local M = {}

M.setup_lsp = function(completion_engine)
  local lsp_setup = require("plugins.lsp_plugins.nvim_lsp_setup")
  lsp_setup.config_handlers()
  local attach = lsp_setup.attach()
  local capabilities = lsp_setup.setup_capabilities()
  if not completion_engine then
    completion_engine = {}
  end
  local lspconfig = require("lspconfig")
  local default_servers = { "gopls" }
  local custom_servers = {
    -- "denols",
    -- "vscode_solidity",
    -- "solidity_ls",
    "hardhat_vscode",
    "eslint",
    "lua_ls",
    "pylance",
    "clangd",
    "rust_analyzer",
    "html",
  }
  local has_plugin, typescript = pcall(require, 'typescript')
  if has_plugin then
    require('typescript').setup({
      server = { -- pass options to lspconfig's setup method
        on_attach = attach,
        -- capabilities = capabilities,
      },
    })
  end
  -- table.insert(custom_servers, package_installed('vue') and 'volar' or 'tsserver')
  local default_config = default_lsp_config(attach, capabilities)

  for _, lsp in ipairs(custom_servers) do
    local config_table = require("plugins.lsp_plugins.lsp_configs." .. lsp).config_table(attach, capabilities)
      or default_lsp_config
    lspconfig[lsp].setup(setup_func(completion_engine, config_table))
  end
  for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup(setup_func(completion_engine, default_config))
  end
end

return M
