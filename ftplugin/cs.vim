finish 

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
    nnoremap <buffer> <Leader>r :OmniSharpRename<CR>

    nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    nnoremap <buffer> <Leader>f :OmniSharpGotoDefinition<CR>
    nnoremap <buffer> <Leader>Fi :OmniSharpFindImplementations<CR>
    nnoremap <buffer> <Leader>Fs :OmniSharpFindSymbol<CR>
    nnoremap <buffer> <Leader>Fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    "nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    "nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    nnoremap <buffer> <Leader>ki :OmniSharpTypeLookup<CR>
    "nnoremap <buffer> <Leader>ki :OmniSharpPreviewDefinition<CR>
    nnoremap <buffer> <Leader>kd :OmniSharpDocumentation<CR>
    nnoremap <buffer> <Leader>kh :OmniSharpSignatureHelp<CR>
    inoremap <buffer> <C-h>:OmniSharpSignatureHelp<CR>

    nnoremap <buffer> <Leader>R :OmniSharpRestartServer<CR>
    nnoremap <buffer> <Leader><Leader>R :OmniSharpRestartAllServers<CR>

    " Navigate up and down by method/property/field
    "nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    "nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    "nnoremap <buffer> <Leader>se :OmniSharpGlobalCodeCheck<CR>
endif
