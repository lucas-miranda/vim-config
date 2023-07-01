return {
    require('plugins.lsp.config'),
    {
        'nvim-lua/lsp_extensions.nvim',
    },
    {
        'ray-x/lsp_signature.nvim',
        opts = {
            hint_prefix = "🦝 "
        },
    },
}
