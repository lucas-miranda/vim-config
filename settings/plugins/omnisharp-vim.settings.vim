" Key Bindings
" -------------"

" Config
" -------------"

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_timeout = 5
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_highlight_types = 0
let g:OmniSharp_start_server = 1
"let g:OmniSharp_translate_cygwin_wsl = 0
let g:OmniSharp_typeLookupInPreview = 1
let g:omnicomplete_fetch_full_documentation = 0
"let g:OmniSharp_loglevel = 'debug'

"let g:OmniSharp_server_path = expand('~/.omnisharp/omnisharp.http-win-x64/OmniSharp.exe')
"let g:OmniSharp_server_path = expand('~/.omnisharp/omnisharp-win-x64/OmniSharp.exe')

if has('unix')
    let g:OmniSharp_server_use_mono = 1
endif
