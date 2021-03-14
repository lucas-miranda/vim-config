let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

let g:ale_linters = {
    \ 'cs': [ 'OmniSharp' ] 
\ }

nmap <silent> <C-A-n> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
