local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.enable('csharp_ls')

vim.lsp.config('csharp_ls', {
    cmd = { "/home/luke/.dotnet/tools/csharp-ls" },
})

--[[
local cmd_omnisharp_mono = {
    "mono",
    "--assembly-loader=strict",
    "/home/luke/.omnisharp/mono/OmniSharp.exe",
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
    "/home/luke/.omnisharp/net/OmniSharp",
    "--languageserver",
    "--hostPID",
    tostring(vim.fn.getpid())
}

nvim_lsp.omnisharp.setup {
    capabilities = capabilities,
    cmd = { "dotnet", "/home/luke/.omnisharp/net/OmniSharp.dll" },
    --cmd = cmd_omnisharp_net6,
    --cmd = cmd_omnisharp,

    --[[
    handlers = {
      ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
      ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
      ["textDocument/references"] = require('omnisharp_extended').references_handler,
      ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
    },
    settings = {
      FormattingOptions = {
        -- Enables support for reading code style, naming convention and analyzer
        -- settings from .editorconfig.
        EnableEditorConfigSupport = true,
        -- Specifies whether 'using' directives should be grouped and sorted during
        -- document formatting.
        OrganizeImports = nil,
      },
      MsBuild = {
        -- If true, MSBuild project system will only load projects for files that
        -- were opened in the editor. This setting is useful for big C# codebases
        -- and allows for faster initialization of code navigation features only
        -- for projects that are relevant to code that is being edited. With this
        -- setting enabled OmniSharp may load fewer projects and may thus display
        -- incomplete reference lists for symbols.
        LoadProjectsOnDemand = nil,
      },
      RoslynExtensionsOptions = {
        -- Enables support for roslyn analyzers, code fixes and rulesets.
        EnableAnalyzersSupport = nil,
        -- Enables support for showing unimported types and unimported extension
        -- methods in completion lists. When committed, the appropriate using
        -- directive will be added at the top of the current file. This option can
        -- have a negative impact on initial completion responsiveness,
        -- particularly for the first few completion sessions after opening a
        -- solution.
        EnableImportCompletion = nil,
        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        -- true
        AnalyzeOpenDocumentsOnly = nil,
      },
      Sdk = {
        -- Specifies whether to include preview versions of the .NET SDK when
        -- determining which version to use for project loading.
        IncludePrereleases = true,
      },
    },
}
]]
