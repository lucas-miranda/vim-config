if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'rust'

let $RUST_BACKTRACE = 1

"let g:LanguageClient_loggingLevel = 'INFO'
"et g:LanguageClient_virtualTextPrefix = ''
"et g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log')
"et g:LanguageClient_serverStderr = expand('~/.local/share/nvim/LanguageServer.log')

"nnoremap <Leader>f <Plug>(coc-declaration)
"nnoremap <Leader>K <Plug>(coc-definition)

"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"nnoremap <silent> <Leader>f :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
