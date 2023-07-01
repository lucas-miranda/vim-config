if exists('g:loaded_lsp_config')
  finish
endif
let g:loaded_lsp_config = 1

function! lsp_config#load()
    " Code navigation shortcuts
    nnoremap <buffer> <silent> <Leader>k <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> <silent> <Leader>d <cmd>lua vim.diagnostic.open_float()<CR>
    nnoremap <buffer> <silent> <Leader>f <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> <silent> Fr <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <buffer> <silent> Fi <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <buffer> <silent> K <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <buffer> <silent> FD <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <buffer> <silent> F0 <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <buffer> <silent> FW <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <buffer> <silent> Fd <cmd>lua vim.lsp.buf.declaration()<CR>

    " Code actions
    nnoremap <buffer> <silent> ga <cmd>lua vim.lsp.buf.code_action()<CR>

    " Goto previous/next diagnostic warning/error
    nnoremap <buffer> <silent> <C-A-n> <cmd>lua vim.diagnostic.goto_prev()<CR>
    nnoremap <buffer> <silent> <C-n> <cmd>lua vim.diagnostic.goto_next()<CR>
endfunction
