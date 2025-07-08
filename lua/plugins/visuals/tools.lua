
return {
    -- Color Theme Tools
    {
        'lifepillar/vim-colortemplate',
        init = function()
            vim.g.colortemplate_toolbar = 0
            vim.g.colortemplate_no_mappings = 1
        end,
    },
}
