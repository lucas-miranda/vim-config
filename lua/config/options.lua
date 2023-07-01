vim.g.mapleader = " "
vim.g.maplocalleader = " "

local o = vim.opt

vim.cmd([[
syntax on
syntax enable
]])

o.termguicolors = true

o.compatible = false
o.showmode = false
o.showcmd = true

o.showmatch = true
o.cursorline = true
o.hlsearch = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.autoindent = true
o.copyindent = true
o.smarttab = true
o.expandtab = true
o.backspace = { "indent", "eol", "start" }
o.hidden = true

o.ignorecase = true
o.smartcase = true
o.incsearch = false

o.backup = false
o.writebackup = false
o.swapfile = false

o.history = 1000
o.undolevels = 1000
o.title = true
o.fileformat = "unix"
o.fileformats = { "unix", "dos" }

o.splitbelow = true
o.splitright = true

o.autowriteall = true
o.timeoutlen = 10000

o.foldmethod = "syntax"
o.foldlevel = 20

vim.cmd([[
filetype plugin indent on
filetype plugin on
]])

o.ssop:remove { "options", "folds" }

o.completeopt = "longest,menuone"

o.previewheight = 10
o.cmdheight = 1

o.updatetime = 300

--o.splitkeep = "screen"
o.shortmess:append { c = true }

o.signcolumn = "yes"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Unix
---------------

--[[
if vim.fn.has("nvim") then
    os.setenv("NVIM_TUI_ENABLE_TRUE_COLOR", 1)

    if vim.fn.has("unix") then
        os.setenv("NVIM_TUI_ENABLE_CURSOR_SHAPE", 0)
    end
end
]]
