let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
\   'smart_case': v:true
\ })

inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB>  pumvisible() ? "\<C-P>" : "\<S-TAB>"
