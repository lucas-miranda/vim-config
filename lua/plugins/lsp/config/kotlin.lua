local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.kotlin_language_server.setup {
    capabilities = capabilities,
    cmd = {
        "sh",
        "/usr/share/kotlin/kotlin-language-server/bin/kotlin-language-server",
    },
    cmd_env = {
        JAVA_HOME = "/usr/lib/jvm/java-20-openjdk",
    },
}
