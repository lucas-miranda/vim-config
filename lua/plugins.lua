
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

    -- Visuals
    --'lucas-miranda/spotify.vim'        -- Retrieve info from Spotify to be displayed somewhere
    'sheerun/vim-polyglot',  	        -- Helps others plugins with language specifics support
    'itchyny/lightline.vim', 	        -- Bottom powerline
    'ryanoasis/vim-devicons',	        -- Tons of icons
    {
        'RRethy/vim-hexokinase',
        build = {
            'make hexokinase'
        },
        init = function()
            if vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols == nil then
                vim.g.WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
                    cs = '',
                }
            end
        end,
    },
    'onsails/lspkind-nvim',

    -- Color Theme Tools
    {
        'lifepillar/vim-colortemplate',
        init = function()
            vim.g.colortemplate_toolbar = 0
            vim.g.colortemplate_no_mappings = 1
        end,
    },

    -- Themes

    -- * Dark
    --'joshdick/onedark.vim',
    --'ayu-theme/ayu-vim',
    --'rafalbromirski/vim-aurora',
    --'bluz71/vim-moonfly-colors',
    --'srcery-colors/srcery-vim',
    --'aonemd/kuroi.vim',
    --'folke/tokyonight.nvim',


    --[[
    {
        'lucas-miranda/vim-purple-martin',
        dev = true,
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme purple_martin)
        end,
    },
    ]]

    {
        'nvimdev/zephyr-nvim',
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.cmd.colorscheme('zephyr')
        end
    }

    -- * Light
    --'NLKNguyen/papercolor-theme',
    --'sainnhe/forest-night',
}
