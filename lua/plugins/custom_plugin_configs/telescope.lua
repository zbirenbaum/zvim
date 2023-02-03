require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
      },
      n = {
        ['q'] = require('telescope.actions').close,
      }
    }
  },
  pickers = {
    find_files = { theme = "ivy", },
    live_grep = { theme = "dropdown", },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
})
require('telescope').load_extension('fzy_native')

vim.keymap.set('n', '<leader>ff', function ()
  require('telescope.builtin').find_files({
    layout_strategy = "bottom_pane",
    layout_config = {
      height = .3, -- maximally available lines
      prompt_position = "bottom",
    },
  })
end, {})
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})
