
" Key Bindings
" -------------"
map <leader>jj   :BrootWorkingDir<cr>
map <leader>jJ   :BrootWorkingDir tab split<cr>
map <leader>jc   :BrootCurrentDir<cr>
map <leader>jC  :BrootCurrentDir tab split<cr>

" Config
" -------------"

let g:broot_default_conf_path = expand('~/.config/broot/conf.hjson')
let g:broot_replace_netrw = 1
let g:loaded_netrwPlugin = 1
