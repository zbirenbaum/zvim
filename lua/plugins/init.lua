local plugins = {
  -- core
  ["lewis6991/impatient.nvim"] = {},
  ["wbthomason/packer.nvim"] = {},

  ["ggandor/lightspeed.nvim"] = {
    disable = true,
    keys = {'f', 's', 'F', 'S'},
    config = function ()
      require('plugins.custom_plugin_configs.lightspeed')
    end
  },
  ['phaazon/hop.nvim'] = {
    disable = true,
    config = function()
      require('plugins.custom_plugin_configs.hop')
    end,
  },
  ["ggandor/flit.nvim"] = {
    -- disable = false,
    keys = { 'f', 'F', 't', 'T' },
    config = function()
      require('flit').setup({
        multiline = true,
        labeled_modes = "nv"
      })
    end,
  },
  ["ggandor/leap.nvim"] = {
    -- disable = false,
    keys = {'x', 's', 'X', 'S'},
    -- module = 'leap',
    config = function()
      require("plugins.custom_plugin_configs.leap")
    end,
    requires = {
      'tpope/vim-repeat',
    },
  },
  -- LSP and Completion
  ["jose-elias-alvarez/typescript.nvim"] = {
    module = 'typescript',
  },
  ["neovim/nvim-lspconfig"] = {
    after = "nvim-treesitter",
    config = function()
      vim.schedule(function()
        require("plugins.lsp_plugins.lsp_init").setup_lsp('cmp')
      end)
    end,
  },
  ["L3MON4D3/LuaSnip"] = {
    module = "luasnip",
    config = function()
      local luasnip = require("luasnip")
      luasnip.config.set_config({
        defaults = {
          history = true,
          updateevents = "TextChanged,TextChangedI",
        },
      })
    end,
  },
  ["zbirenbaum/copilot.lua"] = {
    after = "nvim-lspconfig",
    config = function()
      vim.defer_fn(function()
        require('plugins.completion_plugins.copilot');
      end, 100)
    end,
  },
  ["zbirenbaum/copilot-cmp"] = {
    after = { "copilot.lua", "nvim-cmp" },
    config = function ()
      require("copilot_cmp").setup({
        clear_after_cursor=true,
      })
    end
  },
  ["dylon/vim-antlr"] = { ft = "antlr4", },
  ["zbirenbaum/neodim"] = {
    event = {"LspAttach"},
    config = function ()
      require("neodim").setup()
    end
  },
  ["hrsh7th/cmp-nvim-lsp"] = { after = 'nvim-cmp' },
  -- ["hrsh7th/cmp-buffer"] = { after = 'nvim-cmp' },
  ["hrsh7th/cmp-path"] = { after = 'nvim-cmp' },
  ["saadparwaiz1/cmp_luasnip"] = { after = 'nvim-cmp' },
  ["hrsh7th/cmp-nvim-lua"] = { after = 'nvim-cmp' },
  ["hrsh7th/nvim-cmp"] = {
    event = { "InsertEnter", "CursorHold" },
    config = function()
      require("plugins.completion_plugins.cmp_configs.cmp")
    end,
    requires = { "onsails/lspkind-nvim" },
  },
  ["ray-x/lsp_signature.nvim"] = {
    module = "lsp_signature",
    config = function()
      require("plugins.completion_plugins.cmp_configs.lspsignature_cmp")
    end,
  },
  ["folke/lua-dev.nvim"] = {
    ft = "lua",
    after = "nvim-lspconfig",
  },
  ["bfredl/nvim-luadev"] = {
    ft = "lua",
    cmd = { "Luadev", "Luadev-run", "Luadev-RunWord", "Luadev-Complete" },
    after = "nvim-lspconfig",
    config = function()
      vim.schedule(function()
        require("luadev")
      end)
    end,
  },
  ["folke/trouble.nvim"] = {
    cmd = {"Trouble", "TroubleToggle", "TroubleRefresh", "TroubleClose"},
    module = 'trouble',
    config = function()
      require("plugins.custom_plugin_configs.trouble")
    end,
  },
  -- completion stuff
  ["kylechui/nvim-surround"] = {
    after = "nvim-cmp",
    config = function ()
      require("nvim-surround").setup()
    end,
  },
  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = function()
      require("plugins.completion_plugins.autopairs")
    end,
  },

  -- misc utils
  ["NvChad/nvterm"] = {
    keys = {'<C-l>', '<A-h>', '<A-v>', '<A-i>'},
    config = function ()
      require('nvterm').setup()
      require('utils.mappings').terminal()
    end
  },
  ["max397574/better-escape.nvim"] = {
    event = "InsertCharPre",
    config = function()
      require("plugins.overrides.better_escape")
    end,
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    config = function()
      local setup = function() require("plugins.overrides.treesitter") end
      if vim.bo.filetype == 'norg' then setup() else vim.defer_fn(setup, 10) end
    end,
    requires = {'nvim-treesitter/playground'},
  },
  ["numToStr/Comment.nvim"] = {
    module = "Comment",
    keys = { "gcc", "<leader>/" },
    config = function()
      require("Comment").setup()
      require("utils.mappings").comment()
    end,
  },
  ["nvim-neorg/neorg"] = {
    ft = "norg",
    after = "nvim-treesitter",
    config = function()
      require("plugins.custom_plugin_configs.neorg")
    end,
  },
  ["nvim-lua/plenary.nvim"] = {
    module = "plenary",
    "nvim-lua/plenary.nvim"
  },

  -- ui
  ["kyazdani42/nvim-web-devicons"] = {
    opt = true,
    module='nvim-web-devicons',
    config = function()
      require("plugins.overrides.icons").setup()
    end,
  },
  ["lukas-reineke/indent-blankline.nvim"] = {
    after = { "feline.nvim" },
    config = function()
      vim.defer_fn(function()
        require("plugins.custom_plugin_configs.indent_blankline")
      end, 10)
    end,
  },
  ["feline-nvim/feline.nvim"] = {
    config = function()
      vim.defer_fn(function()
        require("plugins.overrides.statusline_builder.builder")
      end, 25)
    end,
  },
  ["gennaro-tedesco/nvim-jqx"] = {
    cmd = {"JqxList", "JqxQuery"},
  },
  ["lewis6991/gitsigns.nvim"] = {
    config = function()
      require("plugins.overrides.gitsigns")
    end,
  },
  ["monkoose/matchparen.nvim"] = {
    after = "nvim-treesitter",
    config = function()
      require("matchparen").setup()
    end,
  },
  ["zbirenbaum/nvim-base16.lua"] = {
    after = "packer.nvim",
    config = function()
      require("colors").init('onedark')
    end,
  },

  -- dap
  ["mfussenegger/nvim-dap"] = {
    module = "dap",
    keys = {
      "<Leader>b",
      "<C-o>",
      "<C-O>",
      "<C-n>",
      "<Leader>r",
      "<Leader>c",
    },
    config = function ()
      require("plugins.dap.dap_setup").config()
      require("utils.mappings").debug()
    end,
  },
  ["jbyuki/one-small-step-for-vimkind"] = {
    module = "osv"
  },
  ["mxsdev/nvim-dap-vscode-js"] = {
    module = {'dap', 'dap-vscode-js'}
  },
  -- ["theHamsta/nvim-dap-virtual-text"] = {
  --   after = "nvim-dap",
  --   config = function()
  --     require("nvim-dap-virtual-text").setup()
  --   end,
  -- },
}

require('packer').startup(function(use)
  for name, config in pairs(plugins) do
    config[1] = name
    use(config)
  end
end)
