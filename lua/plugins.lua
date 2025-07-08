
return {
    -- Popup
    {
        'nvim-lua/popup.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    -- General
    'tpope/vim-sensible',    	        -- A standard vimrc configuration

    -- Snippet
    'hrsh7th/vim-vsnip',

    -- Utilities
    {
        'Shougo/echodoc.vim',
        init = function()
            vim.g['echodoc#enable_at_startup'] = 1
            vim.g['echodoc#type'] = 'floating'
            --set cmdheight=2
            --let g:echodoc#type = 'signature'

            --let g:echodoc#events = ['CompleteDone', 'CursorMoved', 'CompleteChanged', 'CursorHold', 'CursorHoldI']

            vim.cmd([[highlight link EchoDocFloat Pmenu]])
        end,
    },

    -- Root file handling
    {
        'lambdalisue/suda.vim',
        lazy = true,
        init = function()
            vim.g['suda_smart_edit'] = 1
        end,
    },

    -- Sessions
    'tpope/vim-obsession',
}
