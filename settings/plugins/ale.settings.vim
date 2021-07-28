let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_hover_cursor = 0

let g:ale_linters = {
    \ 'cs': [ 'OmniSharp' ],
\ }

" Rust

" 'rust': [ 'analyzer', 'rls' ]
let g:ale_rust_rls_toolchain = 'stable'
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

let g:ale_rust_rls_config = {
    \ 'rust': {
        \ 'clippy_preference': 'on'
    \ }
\ }

" Keybinds

nmap <silent> <C-A-n> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
