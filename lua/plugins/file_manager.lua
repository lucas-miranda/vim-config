return {
    --'rafaqz/ranger.vim'                -- Interface to Ranger file manager
    {
        'lstwn/broot.vim',
        lazy = false,
        keys = {
            { '<leader>jj', '<cmd>BrootWorkingDir<cr>', desc = 'Open broot at working dir.' },
            { '<leader>jJ', '<cmd>BrootWorkingDir tab split<cr>', desc = 'Open broot at working dir on a new tab.' },
            { '<leader>jc', '<cmd>BrootCurrentDir<cr>', desc = 'Open broot at current dir.' },
            { '<leader>jC', '<cmd>BrootCurrentDir tab split<cr>', desc = 'Open broot at current dir on a new tab.' },
        },
        init = function()
            vim.g.broot_default_conf_path = vim.fn.expand('~/.config/broot/conf.hjson')
            vim.g.broot_replace_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
    },
}
