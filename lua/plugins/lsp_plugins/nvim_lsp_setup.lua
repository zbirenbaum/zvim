local M = {}

local capability_settings = {
  completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = {
      valueSet = { 1 }
    },
    resolveSupport = {
      properties = { "documentation", "detail", "additionalTextEdits" }
    },
  },
}

M.setup_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local completionItem = capabilities.textDocument.completion.completionItem
  completionItem = vim.tbl_deep_extend("force", completionItem, capability_settings.completionItem)
  return capabilities
end

M.config_handlers = function()
  local config_diagnostics = function()
    require("plugins.lsp_plugins.custom_handlers") --config_diagnostics
    local function lspSymbol(name, icon)
      local hl = "DiagnosticSign" .. name
      vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
    end
    lspSymbol("Error", "")
    lspSymbol("Info", "")
    lspSymbol("Hint", "")
    lspSymbol("Warn", "")
    -- suppress error messages from lang servers
    vim.notify = function(msg, log_level)
      if msg:match("exit code") then
        return
      end
      if log_level == vim.log.levels.ERROR then
        vim.api.nvim_err_writeln(msg)
      else
        vim.api.nvim_echo({ { msg } }, true, {})
      end
    end
  end
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {})
  config_diagnostics()
end

M.attach = function()
  local function attach(client, bufnr)
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end
    require('plugins.completion_plugins.cmp_configs.lspsignature_cmp').setup(bufnr)
    client.server_capabilities.semanticTokensProvider = nil
    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
    require("utils.mappings").lsp()
  end
  return attach
end

return M
