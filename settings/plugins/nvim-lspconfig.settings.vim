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
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- * Csharp
--[[
nvim_lsp.csharp_ls.setup {
}
]]

local cmd_omnisharp_mono = {
    "mono",
    "--assembly-loader=strict",
    "/home/luke/.omnisharp/omnisharp-mono/OmniSharp.exe",
    --"--languageserver",
    --"--hostPID",
    --tostring(vim.fn.getpid())
}

local cmd_omnisharp = {
    "/home/luke/.omnisharp/omni/run",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid())
}

local cmd_omnisharp_net6 = {
    --"/home/luke/.omnisharp/omnisharp-net6/run",
    "/home/luke/.omnisharp/omnisharp-net6/OmniSharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid())
}

nvim_lsp.omnisharp.setup {
    capabilities = capabilities,
    --cmd = { "dotnet", "/home/luke/.omnisharp/omnisharp-net6/OmniSharp.dll" },
    --cmd = cmd_omnisharp,
    cmd = cmd_omnisharp_mono,

    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler
    },

    on_new_config = function(new_config, new_root_dir)
        -- skip it if root dir is already registered
        for i, j in pairs(new_config.cmd) do
            if j == new_root_dir then
                return
            end
        end

        -- append new root dir

        table.insert(new_config.cmd, '-z') -- https://github.com/OmniSharp/omnisharp-vscode/pull/4300
        vim.list_extend(new_config.cmd, { '-s', new_root_dir })
        vim.list_extend(new_config.cmd, { '--hostPID', tostring(vim.fn.getpid()) })

        table.insert(new_config.cmd, 'DotNet:enablePackageRestore=false')
        vim.list_extend(new_config.cmd, { '--encoding', 'utf-8' })
        table.insert(new_config.cmd, '--languageserver')

        if new_config.enable_editorconfig_support then
            table.insert(new_config.cmd, 'FormattingOptions:EnableEditorConfigSupport=true')
        end

        if new_config.organize_imports_on_format then
            table.insert(new_config.cmd, 'FormattingOptions:OrganizeImports=true')
        end

        if new_config.enable_ms_build_load_projects_on_demand then
            table.insert(new_config.cmd, 'MsBuild:LoadProjectsOnDemand=true')
        end

        if new_config.enable_roslyn_analyzers then
            table.insert(new_config.cmd, 'RoslynExtensionsOptions:EnableAnalyzersSupport=true')
        end

        if new_config.enable_import_completion then
            table.insert(new_config.cmd, 'RoslynExtensionsOptions:EnableImportCompletion=true')
        end

        if new_config.sdk_include_prereleases then
            table.insert(new_config.cmd, 'Sdk:IncludePrereleases=true')
        end

        if new_config.analyze_open_documents_only then
            table.insert(new_config.cmd, 'RoslynExtensionsOptions:AnalyzeOpenDocumentsOnly=true')
        end
    end,

    on_attach = function(client, bufnr)
        if client.name == "omnisharp" then
            client.server_capabilities.semanticTokensProvider = {
                full = vim.empty_dict(),
                legend = {
                    tokenModifiers = { "static_symbol" },
                    tokenTypes = {
                        "comment",
                        "excluded_code",
                        "identifier",
                        "keyword",
                        "keyword_control",
                        "number",
                        "operator",
                        "operator_overloaded",
                        "preprocessor_keyword",
                        "string",
                        "whitespace",
                        "text",
                        "static_symbol",
                        "preprocessor_text",
                        "punctuation",
                        "string_verbatim",
                        "string_escape_character",
                        "class_name",
                        "delegate_name",
                        "enum_name",
                        "interface_name",
                        "module_name",
                        "struct_name",
                        "type_parameter_name",
                        "field_name",
                        "enum_member_name",
                        "constant_name",
                        "local_name",
                        "parameter_name",
                        "method_name",
                        "extension_method_name",
                        "property_name",
                        "event_name",
                        "namespace_name",
                        "label_name",
                        "xml_doc_comment_attribute_name",
                        "xml_doc_comment_attribute_quotes",
                        "xml_doc_comment_attribute_value",
                        "xml_doc_comment_cdata_section",
                        "xml_doc_comment_comment",
                        "xml_doc_comment_delimiter",
                        "xml_doc_comment_entity_reference",
                        "xml_doc_comment_name",
                        "xml_doc_comment_processing_instruction",
                        "xml_doc_comment_text",
                        "xml_literal_attribute_name",
                        "xml_literal_attribute_quotes",
                        "xml_literal_attribute_value",
                        "xml_literal_cdata_section",
                        "xml_literal_comment",
                        "xml_literal_delimiter",
                        "xml_literal_embedded_expression",
                        "xml_literal_entity_reference",
                        "xml_literal_name",
                        "xml_literal_processing_instruction",
                        "xml_literal_text",
                        "regex_comment",
                        "regex_character_class",
                        "regex_anchor",
                        "regex_quantifier",
                        "regex_grouping",
                        "regex_alternation",
                        "regex_text",
                        "regex_self_escaped_character",
                        "regex_other_escape",
                    },
                },
                range = true,
            }
        end
    end,

    -- Enables support for reading code style, naming convention and analyzer
    -- settings from .editorconfig.
    enable_editorconfig_support = false,

    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    enable_ms_build_load_projects_on_demand = false,

    -- Enables support for roslyn analyzers, code fixes and rulesets.
    enable_roslyn_analyzers = false,

    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    organize_imports_on_format = false,

    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    enable_import_completion = false,

    -- Specifies whether to include preview versions of the .NET SDK when
    -- determining which version to use for project loading.
    sdk_include_prereleases = false,

    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    analyze_open_documents_only = false,
}

-- * Rust

require('rust-tools').setup {
    tools = { -- rust-tools options
        -- how to execute terminal commands
        -- options right now: termopen / quickfix
        executor = require("rust-tools.executors").termopen,

        -- callback to execute once rust-analyzer is done initializing the workspace
        -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
        on_initialized = nil,

        -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
        reload_workspace_from_cargo_toml = true,

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {
            -- automatically set inlay hints (type hints)
            -- default: true
            auto = true,

            -- Only show inlay hints for the current line
            only_current_line = false,

            -- whether to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "=> ",

            -- whether to align to the length of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = "Comment",
        },

        -- options same as lsp hover / vim.lsp.util.open_floating_preview()
        hover_actions = {
            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
            },

            -- Maximal width of the hover window. Nil means no max.
            max_width = nil,

            -- Maximal height of the hover window. Nil means no max.
            max_height = nil,

            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = false,
        },

        -- settings for showing the crate graph based on graphviz and the dot
        -- command
        crate_graph = {
            -- Backend used for displaying the graph
            -- see: https://graphviz.org/docs/outputs/
            -- default: x11
            backend = "x11",
            -- where to store the output, nil for no output stored (relative
            -- path from pwd)
            -- default: nil
            output = nil,
            -- true for all crates.io and external crates, false only the local
            -- crates
            -- default: true
            full = true,

            -- List of backends found on: https://graphviz.org/docs/outputs/
            -- Is used for input validation and autocompletion
            -- Last updated: 2021-08-26
            enabled_graphviz_backends = {
                "bmp",
                "cgimage",
                "canon",
                "dot",
                "gv",
                "xdot",
                "xdot1.2",
                "xdot1.4",
                "eps",
                "exr",
                "fig",
                "gd",
                "gd2",
                "gif",
                "gtk",
                "ico",
                "cmap",
                "ismap",
                "imap",
                "cmapx",
                "imap_np",
                "cmapx_np",
                "jpg",
                "jpeg",
                "jpe",
                "jp2",
                "json",
                "json0",
                "dot_json",
                "xdot_json",
                "pdf",
                "pic",
                "pct",
                "pict",
                "plain",
                "plain-ext",
                "png",
                "pov",
                "ps",
                "ps2",
                "psd",
                "sgi",
                "svg",
                "svgz",
                "tga",
                "tiff",
                "tif",
                "tk",
                "vml",
                "vmlz",
                "wbmp",
                "webp",
                "xlib",
                "x11",
            },
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- standalone file support
        -- setting it to false may improve startup time
        standalone = true,

        capabilities = capabilities,

        cmd = {
            "rust-analyzer"
        },
        on_attach = function(client, bufnr)
            --require("compe").setup({ enabled = true }, bufnr)
            require("rust-tools").inlay_hints.set()
        end,
        procMacro = {
            enable = true
        }
    }, -- rust-analyzer options

    -- debugging stuff
    dap = {
        adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
        },
    },
}

--[[
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
]]

-- * Haskell
nvim_lsp.hls.setup {}

-- diagnostics
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


