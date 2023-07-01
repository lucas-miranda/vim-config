if vim.fn.has('win32') then
    vim.g.vim_root_folder = vim.fn.expand('~/AppData/Local/nvim')
    vim.g.python3_host_prog = vim.fn.expand('C:/Program Files/Python37/python')
    vim.g.python_host_prog = vim.g.python3_host_prog
else
    vim.g.vim_root_folder = vim.fn.expand('~/.config/nvim')
end

-------------------------
-- bootstrap lazy.nvim

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-------------------------

-- lazy.nvim requires mapleader to be set before it's loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opts = require('config.lazy')
require('lazy').setup('plugins', opts)

require('config.options')
require('config.keymaps')
require('config.autocmds')
