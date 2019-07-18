let g:vim_root_folder = '~/AppData/Local/nvim'
let g:python3_host_prog = expand('~/AppData/Local/Programs/Python/Python37-32/python')
let g:python_host_prog = g:python3_host_prog

" Plugins Manager
call plug#begin(g:vim_root_folder . '/plugins-database')

" General
Plug 'tpope/vim-sensible'    	" a standard vimrc configuration
Plug 'scrooloose/nerdtree'   	" file tree viewer
" Plug 'kassio/neoterm'			" terminal inside vim
Plug 'ycm-core/YouCompleteMe'   " autocomplete as you type
                                " langs installed: rust and C#
Plug 'prabirshrestha/async.vim'

" Git
Plug 'tpope/vim-fugitive'		" Git integration

" HTTP
" Plug 'mattn/webapi-vim'         " handle http requests

" Fuzzyfinder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntax Checker
" Plug 'vim-syntastic/syntastic'

" Compile
Plug 'neomake/neomake'

" Language Specifics
Plug 'rust-lang/rust.vim'
Plug 'OrangeT/vim-csharp'

" Visuals
Plug '~/AppData/Local/nvim/plugins-database/spotify.vim'
Plug 'sheerun/vim-polyglot'  	" helps others plugins with language specifics support
Plug 'itchyny/lightline.vim' 	" bottom powerline
Plug 'ryanoasis/vim-devicons'	" tons of icons

" Themes
" Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'

call plug#end()

" ------------- "
" Vim Settings

"set guifont=FuraCode\ NF:h12 " neovim uses 'GuiFont' at ginit.vim to set font

syntax on
colorscheme onedark
set termguicolors

set noshowmode " lightline plugin already handles mode
set showcmd

set number
set showmatch
set cursorline

set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set copyindent
set nowrap
set smarttab
set expandtab

set backspace=indent,eol,start

set hlsearch
set incsearch

set nobackup
set noswapfile

set history=1000
set undolevels=1000
set title
set fileformat=unix
set fileformats=unix,dos

set splitbelow
set splitright

set timeoutlen=10000 " help to type some very long commands

" ------------- "
" Key Remaps

let mapleader = " "

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" set split to the maximum width and height possible
nnoremap <C-W><C-E> :res<CR> :vertical res<CR> 

" Terminal
tnoremap <Esc> <C-\><C-n>

" YouCompleteMe
nnoremap <Leader>g :YcmCompleter GoTo<CR>
nnoremap <Leader>i :YcmCompleter GetType<CR>

" NERDTree
map <C-n>n :NERDTreeToggle<CR>
map <C-n>z :NERDTreeFocus<CR>

" Spotify.vim
nnoremap <Leader><Leader>Si :call spotify#requests#start()<CR>
nnoremap <Leader><Leader>Sd :call spotify#requests#stop()<CR>
nnoremap <Leader><Leader>Ss :call CheckSpotifyStatus()<CR>
nnoremap <Leader><Leader>Sz :exec 'echo spotify#player#display()'<CR>

" Lightline
nnoremap <Leader><Leader>Lr :call LightlineReload()<CR>

" Others
nnoremap <C-Q><C-V> :call Edit(g:vim_root_folder . '/init.vim')<CR>
nnoremap <C-Q><C-G> :call Edit(g:vim_root_folder . '/ginit.vim')<CR>
nnoremap <Leader>N :noh<CR>
nnoremap <Leader>r :w <CR> :so %<CR>
nnoremap <Leader>M :messages<CR>

" ------------- "
" Plugins Configurations

" Lightline
" ------------- "

let g:lightline = {
	\ 'active': {
	\	'left': [
	\		[ 'mode' ],
	\		[ 'readonly', 'filename', 'codeanalysis' ],
	\		[ 'gitbranch' ],
	\		[ 'lineinfo', 'ctrlpmark' ]
	\ 	],
	\	'right': [
	\		[ 'percent' ],
	\		[ 'filetype' ],
	\		[ 'spotify', 'time', 'fileencoding', 'fileformat' ]
	\	]
	\ },
	\ 'component_function': {
    \   'filename': 'LightlineFilename',
	\	'fileformat': 'LightlineFileformat',
	\	'filetype': 'LightlineFiletype',
	\	'fileencoding': 'LightlineFileencoding',
	\	'mode': 'LightlineMode',
	\ 	'gitbranch': 'LightlineFugitive',
	\	'ctrlpmark': 'CrtlPMark',
	\	'time': 'LightlineCurrentTime',
	\	'spotify': 'spotify#player#display',
	\	'codeanalysis': 'LightlineCodeAnalysis'
	\ },
	\ 'component_expand': {
	\ },
	\ 'component_type': {
	\ },
    \ 'component': {
	\   'lineinfo': ' %3l:%-2v',
    \ },
    \ 'separator': {
	\   'left': '',
    \   'right': ''
    \ },
    \ 'subseparator': {
	\   'left': '',
    \   'right': '' 
    \ }
\ }

function! LightlineCodeAnalysis()
    let l:error_count = youcompleteme#GetErrorCount()
    let l:warn_count = youcompleteme#GetWarningCount()

    return g:ycm_error_symbol . ' ' . l:error_count . '  ' . g:ycm_warning_symbol . ' ' . l:warn_count
endfunction

let s:clock_full_display = 0

function! LightlineCurrentTime()
    if winwidth(0) <= 70
        return ''
    endif

    let clock_text = ''

    if s:clock_full_display
        let clock_text = ' %H:%M | %A, %d de %B de %Y' 
    else
        let clock_text = ' %H:%M | %a %d/%b'
    endif

    return strftime(clock_text)
endfunction

function! LightlineModified()
    if &ft =~ 'help'
        return ''
    elseif &modified
        return '+'
    elseif &modifiable
        return ''
    endif

    return '-'
endfunction

function! LightlineReadonly()
    if &ft !~? 'help' && &readonly 
        return 'RO'
    endif

    return ''
endfunction

function! LightlineFilename()
    let l:fname = expand('%:t')

    if l:fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item')
        return g:lightline.ctrlp_item
    elseif l:fname == '__Tagbar__'
        return g:lightline.fname
    elseif l:fname =~ '__Gundo\|NERD_tree' 
        return ''
    elseif &ft == 'vimfiler'
        return vimfiler&get_status_string()
    elseif &ft == 'unite'
        return unite#get_status_string()
    elseif &ft == 'vimshell'
        return vimshell#get_status_string()
    endif

    let l:display_fname = ''

    let l:readonly = LightlineReadonly()
    if l:readonly != ''
        let l:display_fname .= l:readonly . ' '
    endif

    if l:fname != ''
        let l:display_fname .= l:fname
    else
        let l:display_fname .= '[No Name]'
    endif

    let l:modified = LightlineModified()
    if l:modified != ''
        let l:display_fname .= ' ' . l:modified
    endif

    return l:display_fname
endfunction

function! LightlineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ''
            let branch = fugitive#head()

            if branch !=# ''
                return mark . ' ' . branch
            endif
        endif
    catch
    endtry

    return ''
endfunction

function! LightlineFileformat()
    if winwidth(0) > 70 
        return &fileformat . ' ' . WebDevIconsGetFileFormatSymbol()
    endif

    return ''
endfunction

function! LightlineFiletype()
    if winwidth(0) > 70
        if strlen(&filetype)
            return &filetype . ' ' . WebDevIconsGetFileTypeSymbol()
        else
            return 'no ft'
        endif
    endif

    return ''
endfunction

function! LightlineFileencoding()
    if winwidth(0) > 70
        if &fenc !=# ''
            return &fenc
        else
            return &enc
        endif
    endif

    return ''
endfunction

function! LightlineMode()
    let l:fname = expand('%:t')

    if l:fname == '__Tagbar__'
        return 'Tagbar'
    elseif l:fname == 'ControlP'
        return 'CtrlP'
    elseif l:fname == '__Gundo__'
        return 'Gundo'
    elseif l:fname == '__Gundo_Preview__'
        return 'Gundo Preview'
    elseif l:fname =~ 'NERD_tree'
        return 'NERDTree'
    elseif &ft == 'unite'
        return 'Unite'
    elseif &ft == 'vimfiler'
        return 'VimFiler'
    elseif &ft == 'vimshell'
        return 'VimShell'
    elseif winwidth(0) > 60 
        return lightline#mode()
    endif

    return ''
endfunction

function! CtrlPMark()
    if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
              \ , g:lightline.ctrlp_next], 0)
    endif

    return ''
endfunction

let g:ctrlp_status_func = {
    \ 'main': 'CtrlPStatusFunc_1',
    \ 'prog': 'CtrlPStatusFunc_2',
\ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

" Syntastic can call a post-check hook, let's update lightline there
" For more information: :help syntastic-loclist-callback
function! SyntasticCheckHook(errors)
    call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

function! LightlineReload()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction

" Syntastic
" ------------- "

"
" augroup AutoSyntastic
" 	autocmd!
" 	autocmd BufWritePost *.rs,*.toml call s:syntastic()
" augroup END

" function! s:syntastic()
"	SyntasticCheck
"	call lightline#update()
"endfunction

" Racer
" ------------- "

" set hidden
" let g:racer_cmd = '~/.cargo/bin/racer.exe'
" let g:racer_experimental_completer = 1
" au FileType rust nmap gd <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
" au FileType rust nmap <leader>gd <Plug>(rust-doc)

" YouCompleteMe
" ------------- "

let g:ycm_rust_src_path = '~/.rustup/toolchains/stable-x86_64-pc-windows-msvc/lib/rustlib/src/rust/src'
let g:ycm_error_symbol = ''
let g:ycm_warning_symbol = ''

" Neomake
" ------------- "

call neomake#configure#automake('w')

" NERDTree
" ------------- "

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Open automatically when neovim is opened without a file
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" FZF
" ------------- "

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' 
\ }

" Spotify.vim

let g:spotify_verbose = 0
let g:spotify_auto_start_requests = 1
let g:spotify_oauth_token = secret#spotify_oauth_token()

function! CheckSpotifyStatus()
    let l:is_running = spotify#requests#is_running()
    echo l:is_running ? 'Spotify requests are running.' : 'Spotify requests are stopped.'
endfunction

" start spotify requests
call spotify#requests#start()

"------------- "
" Other Configurations

function! Edit(filepath)
	execute 'e ' . fnameescape(a:filepath)
endfunction

function! WrapBuf(range)
    execute a:range . 'bufdo! set wrap' 
endfunction

