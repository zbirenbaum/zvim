local ffi, C
local a = vim.api

local ufo = require('ufo')

local init = function ()
  ffi = require("plugins.custom_plugin_configs.statuscol.ffidef")
  C = ffi.C
  -- a.nvim_create_autocmd({'InsertCharPre'}, {
  --   callback = function(args)
  --     print(vim.inspect(C))
  --   end,
  --   once = false,
  -- })
end

return {
  init=init,
}
