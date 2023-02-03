local g = vim.g
local o = vim.o
local opt = vim.opt

-- lang specific settings
g.python_recommended_style = 0
g.rust_recommended_style= 0
g.solidity_recommended_style= 0
-- clipboard support over ssh
if vim.fn.expand('$DISPLAY') ~= "$DISPLAY" then
  g.clipboard = {
    name = "unnamedplus",
    copy = {
      ["+"] = "xclip -i -selection clipboard",
      ["*"] = "xclip -i -selection primary",
    },
    paste = {
      ["+"] = "xclip -o -selection clipboard",
      ["*"] = "xclip -o -selection primary",
    },
    cache_enabled = 0,
  }
end

o.showcmd = false
o.showmode = false
o.lazyredraw = 1
o.shadafile = vim.fn.expand('$HOME') .. "/.local/share/nvim/shada/main.shada"
o.pumheight = 6
o.pumwidth = 12
o.showtabline = 0 -- shown in statusline

opt.laststatus = 3
opt.clipboard = "unnamedplus"
opt.hidden = true
opt.mouse = ""

-- indentation settings
opt.tabstop = 2
opt.softtabstop=-1
opt.smartindent = true
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- misc
opt.smartcase = true
opt.ignorecase = true
opt.timeoutlen = 400
opt.updatetime = 250
opt.cmdheight = 1
opt.list = true
opt.listchars:append("eol:↴")
opt.termguicolors = true
opt.fillchars = { eob = " " }
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false
opt.undofile = true
opt.cul = true
opt.signcolumn = "yes:1"
opt.splitbelow = true
opt.splitright = true
opt.shortmess:append "sI"

-- globals
g.mapleader = " "
g.loaded_matchparen = 1
g.python_host_skip_check = 1
g.python3_host_prog = vim.fn.expand('$HOME') .. "/.virtualenvs/py3nvim/bin/python";
g.python_host_prog = vim.fn.expand('$HOME') .. "/.virtualenvs/py2nvim/bin/python"
g.mouse = "";

-- use lua filedetect
g.transparency = true

-- builtin plugin stuff
g.loaded_2html_plugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_gzip = 1
g.loaded_logipat = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_matchit = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_rrhelper = 1
g.loaded_spellfile_plugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1

