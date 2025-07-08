
return {
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

    require('plugins.visuals.theme'),
    require('plugins.visuals.tools')
}
