local parsers =  {
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
  }
}
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
    }
  })
end

start()
