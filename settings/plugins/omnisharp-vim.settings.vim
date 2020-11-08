" Key Bindings
" -------------"

"augroup omnisharp_keybindings
    "autocmd!

    " Show type information automatically when the cursor stops moving.
    " Note that the type is echoed to the Vim command line, and will overwrite
    " any other messages in this space including e.g. ALE linting messages.
    "autocmd CursorHold *.cs OmniSharpTypeLookup

    " The following commands are contextual, based on the cursor position.
    "autocmd FileType cs nmap <silent> <buffer> f :OmniSharpGotoDefinition
    "autocmd FileType cs nmap <silent> <buffer> <Leader>Fu <Plug>(omnisharp_find_usages)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>Fi <Plug>(omnisharp_find_implementations)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>Fs <Plug>(omnisharp_find_symbol)

    "autocmd FileType cs nmap <silent> <buffer> <Leader>pd <Plug>(omnisharp_preview_definition)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>pi <Plug>(omnisharp_preview_implementations)

    "autocmd FileType cs nmap <silent> <buffer> K <Plug>(omnisharp_type_lookup)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>ki <Plug>(omnisharp_type_lookup)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>kd <Plug>(omnisharp_documentation)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>ru <Plug>(omnisharp_fix_usings)
    "autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
    "autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

    " Navigate up and down by method/property/field
    "autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
    "autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
"
    " Find all code errors/warnings for the current solution and populate the quickfix window
    "autocmd FileType cs nmap <silent> <buffer> <Leader>cc <Plug>(omnisharp_global_code_check)

    " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)
    "autocmd FileType cs xmap <silent> <buffer> <Leader>ca <Plug>(omnisharp_code_actions)

    " Repeat the last code action performed (does not use a selector)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>O. <Plug>(omnisharp_code_action_repeat)
    "autocmd FileType cs xmap <silent> <buffer> <Leader>O. <Plug>(omnisharp_code_action_repeat)

    "autocmd FileType cs nmap <silent> <buffer> <Leader>rf <Plug>(omnisharp_code_format)

    "autocmd FileType cs nmap <silent> <buffer> <Leader>rn <Plug>(omnisharp_rename)

    "autocmd FileType cs nmap <silent> <buffer> <Leader>Osr <Plug>(omnisharp_restart_server)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>Oss <Plug>(omnisharp_start_server)
    "autocmd FileType cs nmap <silent> <buffer> <Leader>Osp <Plug>(omnisharp_stop_server)
"augroup END

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

"let g:OmniSharp_highlight_groups = {
    "\ 'csUserIdentifier': [
    "\   'constant name', 'enum member name', 'field name', 'identifier',
    "\   'local name', 'parameter name', 'property name', 'static symbol'
    "\ ],
    "\ 'csUserInterface': [ 'interface name' ],
    "\ 'csUserMethod': [ 'extension method name', 'method name' ],
    "\ 'csUserType': [ 'class name', 'enum name', 'namespace name', 'struct name' ]
"\ }

"set completepopup=highlight:Pmenu,border:off
