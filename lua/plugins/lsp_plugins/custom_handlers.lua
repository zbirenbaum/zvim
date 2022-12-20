vim.diagnostic.config({
  virtual_text = {
    prefix = "",
  },
  signs = {
    filter = function (diagnostic)
      if not diagnostic.user_data then diagnostic.user_data = {} end
      return diagnostic
    end,
  },
  underline = false,
  update_in_insert = false, -- update diagnostics insert mode
})

-- require('plugins.lsp_plugins.handler_overrides.signature_help').create_trigger()

local test = function (test1, test2, test3)
end
