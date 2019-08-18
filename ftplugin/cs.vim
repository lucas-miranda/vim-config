if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'cs'

"nnoremap <Leader>f :YcmCompleter GoTo<CR>
"nnoremap <Leader>ki :YcmCompleter GetType<CR>
"nnoremap <Leader>Fi :YcmCompleter GoToReferences<CR>
"nnoremap <Leader>ks :YcmCompleter GetDoc<CR>
"nnoremap <Ctrl>. :YcmCompleter FixIt<CR>
"nnoremap <Leader>c :YcmCompleter RefactorRename
"nnoremap <Leader>R :YcmCompleter RestartServer<CR>
"nnoremap <Leader>ki :YcmCompleter GoToReferences<CR>

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

" Navigate up and down by method/property/field
"nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
"nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

" Find all code errors/warnings for the current solution and populate the quickfix window
"nnoremap <buffer> <Leader>se :OmniSharpGlobalCodeCheck<CR>

"syntax keyword csUserIdentifier constant name 

"highlight default link csUserIdentifier Identifier
"highlight default link csUserInterface Include
"highlight default link csUserMethod Function
"highlight default link csUserType Type

highlight default link csUserType Type


"call prop_type_add('csUserType', { 'highlight': 'Structure' })
