set completeopt+=noinsert,noselect

let g:completion_chain_complete_list = [
    \ {'complete_items': ['lsp', 'buffer', 'snippet']},
    \ {'mode': '<c-p>'},
    \ {'mode': '<c-n>'}
\]

let g:completion_enable_auto_signature = 1

autocmd BufEnter * lua require('completion').on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

imap <silent> <C-Space> <Plug>(completion_trigger)
