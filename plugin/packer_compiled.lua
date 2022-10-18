-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/zach/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/zach/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/zach/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/zach/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/zach/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n`\0\0\3\0\5\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0B\0\1\1K\0\1\0\fcomment\19utils.mappings\nsetup\fComment\frequire\0" },
    keys = { { "", "gcc" }, { "", "<leader>/" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    after = { "cmp_luasnip" },
    config = { "\27LJ\2\nè\1\0\0\5\0\a\0\n6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0015\3\5\0005\4\4\0=\4\6\3B\1\2\1K\0\1\0\rdefaults\1\0\0\1\0\2\17updateevents\29TextChanged,TextChangedI\fhistory\2\15set_config\vconfig\fluasnip\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["better-escape.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0$plugins.overrides.better_escape\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/better-escape.nvim",
    url = "https://github.com/max397574/better-escape.nvim"
  },
  ["cmp-buffer"] = {
    after = { "cmp-path" },
    after_files = { "/home/zach/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["cmp-nvim-lsp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after = { "cmp-buffer" },
    after_files = { "/home/zach/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["cmp-nvim-lua"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    after = { "cmp-nvim-lsp" },
    after_files = { "/home/zach/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      cmp_luasnip = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/home/zach/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["cmp-buffer"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    after = { "cmp-nvim-lua" },
    after_files = { "/home/zach/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      LuaSnip = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["copilot-cmp"] = {
    config = { "\27LJ\2\nT\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\23clear_after_cursor\2\nsetup\16copilot_cmp\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/copilot-cmp",
    url = "https://github.com/zbirenbaum/copilot-cmp"
  },
  ["copilot.lua"] = {
    after = { "copilot-cmp" },
    config = { "\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'plugins.completion_plugins.copilot\frequire-\1\0\4\0\3\0\0066\0\0\0009\0\1\0003\2\2\0)\3d\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["feline.nvim"] = {
    after = { "indent-blankline.nvim" },
    config = { "\27LJ\2\nL\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0001plugins.overrides.statusline_builder.builder\frequire-\1\0\4\0\3\0\0066\0\0\0009\0\1\0003\2\2\0)\3\25\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0" },
    loaded = true,
    only_config = true,
    path = "/home/zach/.local/share/nvim/site/pack/packer/start/feline.nvim",
    url = "https://github.com/feline-nvim/feline.nvim"
  },
  ["flit.nvim"] = {
    config = { "\27LJ\2\nU\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14multiline\2\18labeled_modes\anv\nsetup\tflit\frequire\0" },
    keys = { { "", "f" }, { "", "F" }, { "", "t" }, { "", "T" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/flit.nvim",
    url = "https://github.com/ggandor/flit.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31plugins.overrides.gitsigns\frequire)\1\0\3\0\3\0\0056\0\0\0009\0\1\0003\2\2\0B\0\2\1K\0\1\0\0\rschedule\bvim\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/zach/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nN\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0003plugins.custom_plugin_configs.indent_blankline\frequire-\1\0\4\0\3\0\0066\0\0\0009\0\1\0003\2\2\0)\3\n\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["leap.nvim"] = {
    config = { "\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'plugins.custom_plugin_configs.leap\frequire\0" },
    keys = { { "", "x" }, { "", "s" }, { "", "X" }, { "", "S" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\2\nW\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0<plugins.completion_plugins.cmp_configs.lspsignature_cmp\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/zach/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lua-dev.nvim"] = {
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["matchparen.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15matchparen\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/matchparen.nvim",
    url = "https://github.com/monkoose/matchparen.nvim"
  },
  neodim = {
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vneodim\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/neodim",
    url = "https://github.com/zbirenbaum/neodim"
  },
  neorg = {
    config = { "\27LJ\2\nC\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0(plugins.custom_plugin_configs.neorg\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/neorg",
    url = "https://github.com/nvim-neorg/neorg"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\nD\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0)plugins.completion_plugins.autopairs\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-base16.lua"] = {
    config = { "\27LJ\2\n?\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\fonedark\tinit\vcolors\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-base16.lua",
    url = "https://github.com/zbirenbaum/nvim-base16.lua"
  },
  ["nvim-cmp"] = {
    after = { "nvim-autopairs", "nvim-surround", "copilot-cmp" },
    config = { "\27LJ\2\nJ\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0/plugins.completion_plugins.cmp_configs.cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-virtual-text" },
    config = { "\27LJ\2\nD\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\26plugins.dap.dap_setup\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "\27LJ\2\nC\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\26nvim-dap-virtual-text\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-dap-vscode-js"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-dap-vscode-js",
    url = "https://github.com/mxsdev/nvim-dap-vscode-js"
  },
  ["nvim-jqx"] = {
    commands = { "JqxList", "JqxQuery" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-jqx",
    url = "https://github.com/gennaro-tedesco/nvim-jqx"
  },
  ["nvim-lspconfig"] = {
    after = { "copilot.lua", "nvim-luadev", "lua-dev.nvim", "lsp_signature.nvim" },
    config = { "\27LJ\2\nV\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bcmp\14setup_lsp!plugins.lsp_plugins.lsp_init\frequire)\1\0\3\0\3\0\0056\0\0\0009\0\1\0003\2\2\0B\0\2\1K\0\1\0\0\rschedule\bvim\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-luadev"] = {
    commands = { "Luadev", "Luadev-run", "Luadev-RunWord", "Luadev-Complete" },
    config = { "\27LJ\2\n&\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\vluadev\frequire)\1\0\3\0\3\0\0056\0\0\0009\0\1\0003\2\2\0B\0\2\1K\0\1\0\0\rschedule\bvim\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-luadev",
    url = "https://github.com/bfredl/nvim-luadev"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-lspconfig", "neorg", "matchparen.nvim" },
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins.overrides.treesitter\frequireb\1\0\5\0\6\0\0153\0\0\0006\1\1\0009\1\2\0019\1\3\1\a\1\4\0X\1\3Ä\18\1\0\0B\1\1\1X\1\5Ä6\1\1\0009\1\5\1\18\3\0\0)\4\n\0B\1\3\1K\0\1\0\rdefer_fn\tnorg\rfiletype\abo\bvim\0\0" },
    loaded = true,
    only_config = true,
    path = "/home/zach/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nE\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\28plugins.overrides.icons\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  nvterm = {
    config = { "\27LJ\2\n`\0\0\3\0\5\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0B\0\1\1K\0\1\0\rterminal\19utils.mappings\nsetup\vnvterm\frequire\0" },
    keys = { { "", "<C-l>" }, { "", "<A-h>" }, { "", "<A-v>" }, { "", "<A-i>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/nvterm",
    url = "https://github.com/NvChad/nvterm"
  },
  ["one-small-step-for-vimkind"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/one-small-step-for-vimkind",
    url = "https://github.com/jbyuki/one-small-step-for-vimkind"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/zach/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "Trouble", "TroubleToggle", "TroubleRefresh", "TroubleClose" },
    config = { "\27LJ\2\nE\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0*plugins.custom_plugin_configs.trouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-antlr"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/zach/.local/share/nvim/site/pack/packer/opt/vim-antlr",
    url = "https://github.com/dylon/vim-antlr"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/zach/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^Comment"] = "Comment.nvim",
  ["^dap"] = "nvim-dap-vscode-js",
  ["^dap%-vscode%-js"] = "nvim-dap-vscode-js",
  ["^leap"] = "leap.nvim",
  ["^luasnip"] = "LuaSnip",
  ["^nvim%-web%-devicons"] = "nvim-web-devicons",
  ["^osv"] = "one-small-step-for-vimkind",
  ["^plenary"] = "plenary.nvim",
  ["^trouble"] = "trouble.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: gitsigns.nvim
time([[Setup for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\26packadd gitsigns.nvim\bcmd\bvim\0", "setup", "gitsigns.nvim")
time([[Setup for gitsigns.nvim]], false)
time([[packadd for gitsigns.nvim]], true)
vim.cmd [[packadd gitsigns.nvim]]
time([[packadd for gitsigns.nvim]], false)
-- Setup for: nvim-dap
time([[Setup for nvim-dap]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\ndebug\19utils.mappings\frequire\0", "setup", "nvim-dap")
time([[Setup for nvim-dap]], false)
-- Config for: feline.nvim
time([[Config for feline.nvim]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0001plugins.overrides.statusline_builder.builder\frequire-\1\0\4\0\3\0\0066\0\0\0009\0\1\0003\2\2\0)\3\25\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0", "config", "feline.nvim")
time([[Config for feline.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\31plugins.overrides.gitsigns\frequire)\1\0\3\0\3\0\0056\0\0\0009\0\1\0003\2\2\0B\0\2\1K\0\1\0\0\rschedule\bvim\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins.overrides.treesitter\frequireb\1\0\5\0\6\0\0153\0\0\0006\1\1\0009\1\2\0019\1\3\1\a\1\4\0X\1\3Ä\18\1\0\0B\1\1\1X\1\5Ä6\1\1\0009\1\5\1\18\3\0\0)\4\n\0B\1\3\1K\0\1\0\rdefer_fn\tnorg\rfiletype\abo\bvim\0\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd matchparen.nvim ]]

-- Config for: matchparen.nvim
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15matchparen\frequire\0", "config", "matchparen.nvim")

vim.cmd [[ packadd nvim-lspconfig ]]

-- Config for: nvim-lspconfig
try_loadstring("\27LJ\2\nV\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bcmp\14setup_lsp!plugins.lsp_plugins.lsp_init\frequire)\1\0\3\0\3\0\0056\0\0\0009\0\1\0003\2\2\0B\0\2\1K\0\1\0\0\rschedule\bvim\0", "config", "nvim-lspconfig")

vim.cmd [[ packadd copilot.lua ]]

-- Config for: copilot.lua
try_loadstring("\27LJ\2\nB\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0'plugins.completion_plugins.copilot\frequire-\1\0\4\0\3\0\0066\0\0\0009\0\1\0003\2\2\0)\3d\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0", "config", "copilot.lua")

vim.cmd [[ packadd lsp_signature.nvim ]]

-- Config for: lsp_signature.nvim
try_loadstring("\27LJ\2\nW\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0<plugins.completion_plugins.cmp_configs.lspsignature_cmp\frequire\0", "config", "lsp_signature.nvim")

vim.cmd [[ packadd packer.nvim ]]
vim.cmd [[ packadd nvim-base16.lua ]]

-- Config for: nvim-base16.lua
try_loadstring("\27LJ\2\n?\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\fonedark\tinit\vcolors\frequire\0", "config", "nvim-base16.lua")

vim.cmd [[ packadd indent-blankline.nvim ]]

-- Config for: indent-blankline.nvim
try_loadstring("\27LJ\2\nN\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0003plugins.custom_plugin_configs.indent_blankline\frequire-\1\0\4\0\3\0\0066\0\0\0009\0\1\0003\2\2\0)\3\n\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0", "config", "indent-blankline.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleRefresh lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleRefresh", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleClose lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleClose", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file JqxList lua require("packer.load")({'nvim-jqx'}, { cmd = "JqxList", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file JqxQuery lua require("packer.load")({'nvim-jqx'}, { cmd = "JqxQuery", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Luadev lua require("packer.load")({'nvim-luadev'}, { cmd = "Luadev", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[au CmdUndefined Luadev-run ++once lua require"packer.load"({'nvim-luadev'}, {}, _G.packer_plugins)]])
pcall(vim.cmd, [[au CmdUndefined Luadev-RunWord ++once lua require"packer.load"({'nvim-luadev'}, {}, _G.packer_plugins)]])
pcall(vim.cmd, [[au CmdUndefined Luadev-Complete ++once lua require"packer.load"({'nvim-luadev'}, {}, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <A-v> <cmd>lua require("packer.load")({'nvterm'}, { keys = "<lt>A-v>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gcc <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "gcc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> S <cmd>lua require("packer.load")({'leap.nvim'}, { keys = "S", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> t <cmd>lua require("packer.load")({'flit.nvim'}, { keys = "t", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> s <cmd>lua require("packer.load")({'leap.nvim'}, { keys = "s", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-l> <cmd>lua require("packer.load")({'nvterm'}, { keys = "<lt>C-l>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <A-i> <cmd>lua require("packer.load")({'nvterm'}, { keys = "<lt>A-i>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>/ <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "<lt>leader>/", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <A-h> <cmd>lua require("packer.load")({'nvterm'}, { keys = "<lt>A-h>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> T <cmd>lua require("packer.load")({'flit.nvim'}, { keys = "T", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> X <cmd>lua require("packer.load")({'leap.nvim'}, { keys = "X", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> f <cmd>lua require("packer.load")({'flit.nvim'}, { keys = "f", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> F <cmd>lua require("packer.load")({'flit.nvim'}, { keys = "F", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> x <cmd>lua require("packer.load")({'leap.nvim'}, { keys = "x", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType norg ++once lua require("packer.load")({'neorg'}, { ft = "norg" }, _G.packer_plugins)]]
vim.cmd [[au FileType antlr4 ++once lua require("packer.load")({'vim-antlr'}, { ft = "antlr4" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-luadev', 'lua-dev.nvim'}, { ft = "lua" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au LspAttach * ++once lua require("packer.load")({'neodim'}, { event = "LspAttach *" }, _G.packer_plugins)]]
vim.cmd [[au InsertCharPre * ++once lua require("packer.load")({'better-escape.nvim'}, { event = "InsertCharPre *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au CursorHold * ++once lua require("packer.load")({'nvim-cmp'}, { event = "CursorHold *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/zach/.local/share/nvim/site/pack/packer/opt/vim-antlr/ftdetect/antlr.vim]], true)
vim.cmd [[source /home/zach/.local/share/nvim/site/pack/packer/opt/vim-antlr/ftdetect/antlr.vim]]
time([[Sourcing ftdetect script at: /home/zach/.local/share/nvim/site/pack/packer/opt/vim-antlr/ftdetect/antlr.vim]], false)
time([[Sourcing ftdetect script at: /home/zach/.local/share/nvim/site/pack/packer/opt/neorg/ftdetect/norg.vim]], true)
vim.cmd [[source /home/zach/.local/share/nvim/site/pack/packer/opt/neorg/ftdetect/norg.vim]]
time([[Sourcing ftdetect script at: /home/zach/.local/share/nvim/site/pack/packer/opt/neorg/ftdetect/norg.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
