
return {
    -- A personal wiki
    {
        'vimwiki/vimwiki',
        init = function()
            vim.g.vimwiki_list = {
                {
                    path = '~/reference-wiki/',
                    syntax = 'default',
                    ext = '.wiki',
                }
            }
        end,
    }
}
