local nvim_lsp = require('lspconfig')

nvim_lsp.haxe_language_server.setup({
    cmd = {"node", "/home/luke/.vscode/extensions/nadako.vshaxe-2.31.0/bin/server.js"}
})
