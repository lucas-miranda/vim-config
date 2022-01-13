lua <<EOF
local nvim_lsp = require('lspconfig')
local util = require 'lspconfig/util'

-- borders
vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
    { "🭽", "FloatBorder" },
    { "▔", "FloatBorder" },
    { "🭾", "FloatBorder" },
    { "▕", "FloatBorder" },
    { "🭿", "FloatBorder" },
    { "▁", "FloatBorder" },
    { "🭼", "FloatBorder" },
    { "▏", "FloatBorder" }
}

-- icons
local icons = {
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = "了 ",
    EnumMember = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = " ",
    Interface = "ﰮ ",
    Keyword = " ",
    Method = "ƒ ",
    Module = " ",
    Property = " ",
    Snippet = "﬌ ",
    Struct = " ",
    Text = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
}

local kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(kinds) do
    kinds[i] = icons[kind] or kind
end

-- diagnostics symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- events
local on_attach = function(client, bufnr)
    --require('completion').on_attach(client)
    vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
    vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
end


-- LSPs

-- nvim-cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- * Csharp
nvim_lsp.omnisharp.setup {
    capabilities = capabilities,
    cmd = {
        "mono",
        "--assembly-loader=strict",
        "/home/luke/.omnisharp/omnisharp-mono/OmniSharp.exe",
        "--languageserver",
        "--hostPID",
        tostring(vim.fn.getpid())
    },
    flags = {
        debounce_text_changes = 500,
    },
    on_new_config = function(new_config, new_root_dir)
        if new_root_dir then
            -- skip it if root dir is already registered
            for i, j in pairs(new_config.cmd) do
                if j == new_root_dir then
                    return
                end
            end

            table.insert(new_config.cmd, '-s')
            table.insert(new_config.cmd, new_root_dir)
        end
    end,
    root_dir = function(fname)
        return util.root_pattern '*.sln'(fname) or util.root_pattern '*.csproj'(fname)
    end
    --root_dir = util.root_pattern(".csproj")
}

-- * Rust
require('rust-tools').setup {
    tools = { -- rust-tools options
        -- automatically set inlay hints (type hints)
        -- There is an issue due to which the hints are not applied on the first
        -- opened file. For now, write to the file to trigger a reapplication of
        -- the hints or just run :RustSetInlayHints.
        -- default: true
        autoSetHints = true,

        -- whether to show hover actions inside the hover window
        -- this overrides the default hover handler so something like lspsaga.nvim's hover would be overriden by this
        -- default: true
        hover_with_actions = true,

        -- These apply to the default RustRunnables command
        runnables = {
            -- whether to use telescope for selection menu or not
            -- default: true
            use_telescope = false

            -- rest of the opts are forwarded to telescope
        },

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {
            -- wheter to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "=> ",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7
        },

        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                {"╰", "FloatBorder"}, {"│", "FloatBorder"}
            },

            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = false
        }
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 500,
        },

        -- rust-analyzer options
        cmd = {
            "rust-analyzer"
        },
        on_attach = function(client, bufnr)
            --require("compe").setup({ enabled = true }, bufnr)
            require("rust-tools.inlay_hints").set_inlay_hints()
        end,
        procMacro = {
            enable = true
        }
    }
}

vim.diagnostic.config({
    underline = true,
    virtual_text = {
        prefix = "■ ",
        format = function(diagnostic)
            return diagnostic.message
        end,
    },
    signs = true,
    update_in_insert = false,
    severity_sort = true
})

require("lsp_signature").setup()

EOF

" Show diagnostics on cursor hover
"autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({ focusable = false })

" Enable type inlay hints
"autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
    "\ lua require('lsp_extensions').inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

" Code navigation shortcuts
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> D <cmd>lua vim.diagnostic.open_float()<CR>
nnoremap <silent> f <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> Fr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> Fi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <Leader>k <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> FD <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> F0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> FW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> Fd <cmd>lua vim.lsp.buf.declaration()<CR>

" Code actions
nnoremap <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>

" Goto previous/next diagnostic warning/error
nnoremap <silent> <C-A-n> <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.diagnostic.goto_next()<CR>
