
set completefunc=LanguageClient#complete

let g:LanguageClient_hideVirtualTextsOnInsert = 1
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_hoverPreview = "Always"
let g:LanguageClient_preferredMarkupKind = ['markdown', 'plaintext']

"\   'command': ['rustup', 'run', 'stable', 'rls'],
let g:LanguageClient_serverCommands = {
    \ 'rust': {
    \   'name': 'rust-analyzer',
    \   'command': ['rustup', 'run', 'stable', 'rust-analyzer'],
    \   'initializationOptions': {
    \   }
    \ }
\ }

let g:LanguageClient_diagnosticsDisplay = {
    \ 1: {
    \   "name": "Error",
    \   "texthl": "LanguageClientError",
    \   "signText": "✖",
    \   "signTexthl": "LanguageClientErrorSign",
    \   "virtualTexthl": "Error",
    \ },
    \ 2: {
    \   "name": "Warning",
    \   "texthl": "LanguageClientWarning",
    \   "signText": "",
    \   "signTexthl": "LanguageClientWarningSign",
    \   "virtualTexthl": "Todo",
    \ },
    \ 3: {
    \   "name": "Information",
    \   "texthl": "LanguageClientInfo",
    \   "signText": "ℹ",
    \   "signTexthl": "LanguageClientInfoSign",
    \   "virtualTexthl": "Todo",
    \ },
    \ 4: {
    \   "name": "Hint",
    \   "texthl": "LanguageClientInfo",
    \   "signText": "➤",
    \   "signTexthl": "LanguageClientInfoSign",
    \   "virtualTexthl": "Todo",
    \ }
\ }

function! Mappings()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nmap <buffer> <F5> <Plug>(lcn-menu)

        nmap <buffer> <silent> K <Plug>(lcn-hover)
        nmap <buffer> <silent> <Leader>f <Plug>(lcn-definition)
        nmap <buffer> <silent> <Leader>Fr <Plug>(lcn-references)
        nmap <buffer> <silent> <Leader>Fi <Plug>(lcn-implementation)
        nmap <buffer> <silent> <Leader>Fs <Plug>(lcn-symbols)
        nmap <buffer> <silent> <Leader>he <Plug>(lcn-explain-error)

        nmap <buffer> <silent> <F2> <Plug>(lcn-rename)

        "nmap <buffer> <silent> <C-A-n> <Plug>(lcn-diagnostics-prev)
        "nmap <buffer> <silent> <C-n> <Plug>(lcn-diagnostics-next)
    endif
endfunction

autocmd FileType * call Mappings()
