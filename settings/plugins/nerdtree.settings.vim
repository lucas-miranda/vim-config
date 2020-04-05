" Key Bindings
" -------------"

map <C-n>n :NERDTreeToggle<CR>
map <C-n><C-n> :NERDTreeToggle<CR>
map <C-n>z :NERDTreeFocus<CR>

" Config
" -------------"

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Open automatically when neovim is opened without a file
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
