local get_config = require('plugins.dap.dap_configs.vscode_js')

local M = {}

M.config = function()
  local adapters = { "python", "lua", "ccpp", "vscode_js"} --list your adapters here
  for _, adapter in ipairs(adapters) do
    require("plugins.dap.dap_configs." .. adapter)
  end

  require("dap-vscode-js").setup({
    debugger_path = vim.fn.expand('$HOME') .. '/Progfiles/microsoft/vscode-js-debug',
    adapters = {
      'pwa-node',
      'pwa-chrome',
      'pwa-msedge',
      'node-terminal',
      'pwa-extensionHost'
    },
  })

  for _, language in ipairs({ "typescript", "javascript" }) do
    local opt = get_config({ 'launch', 'test', 'attach' })
    require("dap").configurations[language] = opt
  end
end

return M

--if you do not want to use dapui, specific widget windows can be loaded via lua instead like so
-- vim.api.nvim_set_keymap("n", "<Leader>s", '<Cmd>lua require"plugins.dap_configs.widget_config".load_scope_in_sidebar()<CR>', {
--    silent = true,
--    noremap = true,
-- })
-- where plugins.dap_configs.widget_config contains:
-- M = {}
-- local widgets = require('dap.ui.widgets')
--
-- M.load_scope_in_sidebar = function ()
--   local my_sidebar = widgets.sidebar(widgets.scopes)
--   my_sidebar.toggle()
-- end
--
-- return M
