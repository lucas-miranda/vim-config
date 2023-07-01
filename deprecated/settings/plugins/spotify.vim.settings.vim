" Key Bindings
" -------------"

nnoremap <Leader><Leader>Si :call spotify#requests#start()<CR>
nnoremap <Leader><Leader>Sd :call spotify#requests#stop()<CR>
nnoremap <Leader><Leader>Ss :call CheckSpotifyStatus()<CR>
nnoremap <Leader><Leader>Sz :exec 'echo spotify#player#display()'<CR>

" Config
" -------------"

"let g:spotify_verbose = 1
let g:spotify_auto_start_requests = 1
"let g:spotify_oauth_token = secret#spotify_oauth_token()

function! CheckSpotifyStatus()
    let l:is_running = spotify#requests#is_running()
    echo l:is_running ? 'Spotify requests are running.' : 'Spotify requests are stopped.'
endfunction

" start spotify requests
call spotify#requests#start()

"nnoremap <F5> :call spotify#providers#load(1)<CR>
