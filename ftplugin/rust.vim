if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'rust'

nnoremap <Leader>f :YcmCompleter GoTo<CR>
nnoremap <Leader>ki :YcmCompleter GetType<CR>
nnoremap <Leader>Fi :YcmCompleter GoToReferences<CR>
nnoremap <Leader>ks :YcmCompleter GetDoc<CR>
nnoremap <Ctrl>. :YcmCompleter FixIt<CR>
nnoremap <Leader>c :YcmCompleter RefactorRename
nnoremap <Leader>R :YcmCompleter RestartServer<CR>
