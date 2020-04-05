" Key Bindings
" -------------"

nnoremap <Leader><Leader>Oss :OmniSharpStartServer<CR>
nnoremap <Leader><Leader>Osp :OmniSharpStopServer<CR>

" Config
" -------------"

let g:OmniSharp_server_stdio = 0
let g:OmniSharp_timeout = 5
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_start_server = 0
let g:OmniSharp_translate_cygwin_wsl = 0
let g:OmniSharp_typeLookupInPreview = 1
"let g:OmniSharp_loglevel = 'debug'

"let g:OmniSharp_server_path = expand('~/.omnisharp/omnisharp.http-win-x64/OmniSharp.exe')
"let g:OmniSharp_server_path = expand('~/.omnisharp/omnisharp-win-x64/OmniSharp.exe')

let g:OmniSharp_highlight_groups = {
    \ 'csUserIdentifier': [
    \   'constant name', 'enum member name', 'field name', 'identifier',
    \   'local name', 'parameter name', 'property name', 'static symbol'
    \ ],
    \ 'csUserInterface': [ 'interface name' ],
    \ 'csUserMethod': [ 'extension method name', 'method name' ],
    \ 'csUserType': [ 'class name', 'enum name', 'namespace name', 'struct name' ]
\ }
