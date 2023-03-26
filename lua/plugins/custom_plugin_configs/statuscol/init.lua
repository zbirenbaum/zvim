vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local builtin = require("plugins.custom_plugin_configs.statuscol.builtin")
-- require('plugins.custom_plugin_configs.statuscol.test').init()
builtin = require("statuscol.builtin")
-- require("plugins.custom_plugin_configs.statuscol.statuscol").setup({
if tonumber(vim.o.foldcolumn) > 0 then
  require("statuscol").setup({
    relculright = true,
    segments = {
      { text = { builtin.foldfunc, "%s" }, click = "v:lua.ScSa" },
      { text = { builtin.lnumfunc, ' ' }, click = "v:lua.ScLa", },
    }
  })
end
