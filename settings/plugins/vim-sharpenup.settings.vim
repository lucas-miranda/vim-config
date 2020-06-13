" https://github.com/nickspoons/vim-sharpenup
let g:sharpenup_create_mappings = 0
let g:sharpenup_statusline_opts = {
    \ 'TextLoading': 'O# %s: Loading...',
    \ 'TextReady': 'O# %s',
    \ 'TextDead': 'O# %s: Not Running',
    \ 'Highlight': 0,
    \ 'HiLoading': 'SharpenUpLoading',
    \ 'HiReady': 'SharpenUpReady',
    \ 'HiDead': 'SharpenUpDead'
\ }

augroup lightline_integration
    autocmd!
    autocmd User OmniSharpStarted,OmniSharpReady,OmniSharpStopped call lightline#update()
augroup END
