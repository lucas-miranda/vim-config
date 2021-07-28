" Key Bindings
" -------------"

nmap <silent> <Leader>g :call fzf#run(fzf#wrap({'sink': 'e!'}))<CR>
nmap <silent> <Leader><Leader>g :call fzf#run(fzf#wrap({'sink': 'tabedit'}))<CR>
nmap <silent> <Leader>t :Ag<CR>
nmap <silent> <Leader>b :Buffers<CR>
nmap <silent> <Leader>F :Filetypes<CR>

" Config
" -------------"

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' 
\ }

let g:fzf_layout = { 'window': '-tabnew' }

let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] 
\ }
