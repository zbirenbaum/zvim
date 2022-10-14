local M = {}

M.ui = {
  hl_override = "plugins.overrides.hl_override",
  italic_comments = true,
  transparency = true,
  theme = "onedark",
}

M.plugins = {
  options = {
    statusline = { hide_disable = true },
  },
  install = "plugins_table",
  default_plugin_config_replace = {
    better_escape = "plugins.overrides.better_escape",
    feline = function()
      require("plugins.overrides.statusline_builder.builder")
    end,
    --      nvim_treesitter = "plugins.overrides.treesitter",
    indent_blankline = function()
      require("plugins.custom_plugin_configs.indent_blankline")
    end,
  },
  status = require("status"),
  remove = require("default_plugins"),
  override = {["wbthomason/packer.nvim"] = require("plugins.packer_init" )},
}

M.plugins.user = require(M.plugins.install)

M.mappings = {
  plugins = {},
  terminal = {
    esc_termmode = {nil},
    spawn_horizontal = {nil},
    spawn_vertical= {nil},
    new_horizontal = {nil},
    new_vertical = {nil},
  }
}

return M
