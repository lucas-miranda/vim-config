local nvim_lsp = require('lspconfig')

nvim_lsp.eslint.setup({
  --[[on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  ]]
})


-- TODO  use ts_ls instead
nvim_lsp.tsserver.setup({
})
