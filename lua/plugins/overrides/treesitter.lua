-- require "nvim-treesitter.parsers".get_parser_configs().Solidity = {
--   install_info = {
--     url = "https://github.com/JoranHonig/tree-sitter-solidity",
--     files = {"src/parser.c"},
--     requires_generate_from_grammar = true,
--   },
--   filetype = 'solidity'
-- }
local start = function()
  require("nvim-treesitter")
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "c",
      "cpp",
      "lua",
      "rust",
      "go",
      "python",
      "javascript",
      "typescript",
      "bash",
      "gomod",
      "cuda",
      "cmake",
      "comment",
      "json",
      "regex",
      "yaml",
    },
    indent = {
      enable = false,
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
  })
end
vim.schedule(start)
