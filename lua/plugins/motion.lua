return {
    -- Modify lowercase motions
    {
        'chaoren/vim-wordmotion',
        init = function()
            vim.g.wordmotion_uppercase_spaces = {
                '.', '-', '+', '*', '/', '(', ')', '[', ']', '{', '}'
            }
        end,
    },
}
