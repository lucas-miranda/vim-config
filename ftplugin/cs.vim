if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'cs'

if !exists('g:cs_keybinds_scheme')
    exit
endif

if g:cs_keybinds_scheme == 'ycm'
    nnoremap <Leader>f :YcmCompleter GoTo<CR>
    nnoremap <Leader>ki :YcmCompleter GetType<CR>
    nnoremap <Leader>Fi :YcmCompleter GoToReferences<CR>
    nnoremap <Leader>ks :YcmCompleter GetDoc<CR>
    nnoremap <Ctrl>. :YcmCompleter FixIt<CR>
    nnoremap <Leader>c :YcmCompleter RefactorRename
    nnoremap <Leader>R :YcmCompleter RestartServer<CR>
elseif g:cs_keybinds_scheme == 'omni'
    nmap <buffer> <Leader>f :OmniSharpGotoDefinition<CR>
    nmap <buffer> <Leader>Fu :OmniSharpFindUsages<CR>
    nmap <buffer> <Leader>Fs :OmniSharpFindSymbol<CR>
    nmap <buffer> <Leader>Fi :OmniSharpFindImplementations<CR>
    nmap <buffer> <Leader>Fm :OmniSharpFindMembers<CR>

    nmap <buffer> <Leader>pd :OmniSharpPreviewDefinition<CR>
    nmap <buffer> <Leader>pi :OmniSharpPreviewImplementations<CR>

    nmap <buffer> K :OmniSharpTypeLookup<CR>
    nmap <buffer> <Leader>ki :OmniSharpTypeLookup<CR>
    nmap <buffer> <Leader>kd :OmniSharpDocumentation<CR>
    nmap <buffer> <Leader>ru :OmniSharpFixUsings<CR>

    nmap <buffer> <C-\>:OmniSharpSignatureHelp<CR>
    imap <buffer> <C-\>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    nmap <silent> <buffer> [[ :OmniSharpNavigateUp
    nmap <silent> <buffer> ]] :OmniSharpNavigateDown

    nmap <silent> <buffer> <Leader>cc :OmniSharpGlobalCodeCheck
    nmap <buffer> <Leader>rn :OmniSharpRename

    nmap <buffer> <Leader>Osr :OmniSharpRestartAllServers<CR>
    nmap <buffer> <Leader>Oss :OmniSharpStartServer<CR>
    nmap <buffer> <Leader>Osp :OmniSharpStopAllServers<CR>
endif
