return {
    'neovim/nvim-lspconfig',

    config = function(_, opts)
        --local lspconfig = require 'lspconfig'
        --lspconfig.setup(opts)

        -- borders
        vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
        vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

        -- load languages lsp
        local langs = {
            ['csharp']      = { enabled = true },
            ['gdscript']    = { enabled = true },
            ['haskell']     = { enabled = true },
            ['kotlin']      = { enabled = true },
            ['lua']         = { enabled = true },
            ['rust']        = { enabled = true },
            ['haxe']        = { enabled = true },
            ['javascript']  = { enabled = false },
        }

        for lang_name, lang in pairs(langs) do
            if lang.enabled then
                require('plugins.lsp.config.' .. lang_name)
            end
        end

        -- diagnostics
        vim.diagnostic.config({
            underline = true,
            virtual_text = {
                prefix = '■ ',
                format = function(diagnostic)
                    return diagnostic.message
                end,
            },
            signs = true,
            update_in_insert = false,
            severity_sort = true
        })

        require('lsp_signature').setup()

        -- Show diagnostics on cursor hover
        --autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })

        -- Enable type inlay hints
        --autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
            --\ lua require('lsp_extensions').inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
    end,
}
