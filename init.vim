let g:vim_root_folder = '~/AppData/Local/nvim'
let g:python3_host_prog = expand('~/AppData/Local/Programs/Python/Python37-32/python')
let g:python_host_prog = g:python3_host_prog

" Plugins Manager
call plug#begin(g:vim_root_folder . '/plugins-database')

" General
Plug 'tpope/vim-sensible'    	" a standard vimrc configuration
Plug 'scrooloose/nerdtree'   	" file tree viewer
" Plug 'kassio/neoterm'			" terminal inside vim
Plug 'ycm-core/YouCompleteMe', { 'do': 'python install.py --cs-completer' }     " autocomplete as you type
Plug 'prabirshrestha/async.vim'
Plug 'chaoren/vim-wordmotion'   " Modify lowercase motions
Plug 'RRethy/vim-illuminate'    " Automatically hightlights matching words under cursor
"Plug 'scrooloose/nerdcommenter' " Toggles comments on several languages

" Org
Plug 'jceb/vim-orgmode'

" Git
Plug 'tpope/vim-fugitive'		" Git integration

" HTTP
" Plug 'mattn/webapi-vim'         " handle http requests

" Fuzzyfinder
"  Note!  Install 'fd' and set FZF_DEFAULT_COMMAND
"  FZF_DEFAULT_COMMNAND="fd --type f --hidden --follow --exclude .git"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'sh install --all' }
Plug 'junegunn/fzf.vim'

" Linters
" Plug 'w0rp/ale'

" Syntax Checker
" Plug 'vim-syntastic/syntastic'

" Compile
Plug 'neomake/neomake'

" Language Specifics
Plug 'rust-lang/rust.vim'
"Plug 'OmniSharp/omnisharp-vim'
Plug 'OrangeT/vim-csharp'

" Visuals
Plug 'TaDaa/vimade'             " Makes inactive buffers fades a bit
Plug 'lucas-miranda/spotify.vim'
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

"set number
set showmatch
set cursorline
set hlsearch!

set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set copyindent
"set nowrap
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

set autowriteall
set timeoutlen=10000 " help to type some very long commands

set foldmethod=syntax
filetype plugin indent on

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

" ------------- "
" Path Variables

let $FZF_DEFAULT_COMMAND = 'fd --type f --no-ignore-vcs --hidden --follow --exclude {.git,.vs} --color=always'
"let $FZF_DEFAULT_OPS = '--ansi'

"------------- "
" Functions

function! Edit(filepath)
	execute 'e ' . fnameescape(a:filepath)
endfunction

function! WrapBuf(range)
    execute a:range . 'bufdo! set wrap' 
endfunction

function! EditTodo(filepath)
	execute 'e ' . fnameescape(a:filepath)
	"execute bufnr('%') . 'bufdo! set wrap'
endfunction

function! LoadPluginSettings(plugin_name)
    let l:full_path = g:vim_root_folder . '/settings/' . a:plugin_name . '.settings.vim'
    execute 'so ' . l:full_path
endfunction

function! FindInFiles(pattern, ...)
    let l:search_folder = expand('%:p:h')
    let l:additional_args = []

    if a:0 > 0
        let l:remaining_args = a:0

        " search_folder => root folder to recursive search
        let l:search_folder = a:1
        let l:remaining_args = l:remaining_args - 1

        if l:remaining_args > 0
            " max_count => max matches count
            add(l:additional_args, '--max-count=' . a:1)
            let l:remaining_args = l:remaining_args - 1
        endif
    endif

    let l:additional_args = join(l:additional_args, ' ')
    let l:grep_cmd = "!grep -rnI --exclude-dir={.git,.vs} " . l:additional_args . "'" . a:pattern . "' " . l:search_folder

    echo execute(l:grep_cmd)
endfunction

" Soft save when leaving a buffer or window loses focus
augroup autoSoftSave
    autocmd!
    autocmd BufLeave * silent! w
    autocmd FocusLost * silent! wa
augroup END

" Language Specifics
augroup langsSpecifics
    autocmd!

    "autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " Follow symbol
    autocmd FileType cs nnoremap <Leader>f :YcmCompleter GoTo<CR>

    " Get type signature
    autocmd FileType cs nnoremap <Leader>ki :YcmCompleter GetType<CR>

    autocmd FileType cs nnoremap <Leader>Fi :YcmCompleter GoToReferences<CR>

    autocmd FileType cs nnoremap <Leader>ks :YcmCompleter GetDoc<CR>

    autocmd FileType cs nnoremap <Ctrl>. :YcmCompleter FixIt<CR>

    autocmd FileType cs nnoremap <Leader>c :YcmCompleter RefactorRename

    autocmd FileType cs nnoremap <Leader>R :YcmCompleter RestartServer<CR>

    "autocmd FileType cs nnoremap <Leader>ki :YcmCompleter GoToReferences<CR>



    " The following commands are contextual, based on the cursor position.
    "autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    "autocmd FileType cs nnoremap <buffer> <Leader>Fi :OmniSharpFindImplementations<CR>
    "autocmd FileType cs nnoremap <buffer> <Leader>Fs :OmniSharpFindSymbol<CR>
    "autocmd FileType cs nnoremap <buffer> <Leader>Fu :GoToRefe<CR>

    " Finds members in the current buffer
    "autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    "autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    "autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    "autocmd FileType cs nnoremap <buffer> <Leader>sd :OmniSharpDocumentation<CR>
    "autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    "autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    "autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    "autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    "autocmd FileType cs nnoremap <buffer> <Leader>se :OmniSharpGlobalCodeCheck<CR>
augroup END


" ------------- "
" Commands

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--numbers --ignore={.git,.vs} --width ' . (winwidth(0) - 10), {'options': '--delimiter : --nth 4..'} , <Bang>0)

" ------------- "
" Key Remaps

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" set split to the maximum width and height possible
nnoremap <C-W><C-E> :res<CR> :vertical res<CR> 

" Terminal
tnoremap <Esc> <C-\><C-n>

" NERDTree
map <C-n>n :NERDTreeToggle<CR>
map <C-n><C-n> :NERDTreeToggle<CR>
map <C-n>z :NERDTreeFocus<CR>

" Spotify.vim
nnoremap <Leader><Leader>Si :call spotify#requests#start()<CR>
nnoremap <Leader><Leader>Sd :call spotify#requests#stop()<CR>
nnoremap <Leader><Leader>Ss :call CheckSpotifyStatus()<CR>
nnoremap <Leader><Leader>Sz :exec 'echo spotify#player#display()'<CR>

" Lightline
nnoremap <Leader><Leader>Lr :call LightlineReload()<CR>

" FZF
nnoremap <Leader>g :FZF<CR>
nnoremap <Leader>t :Ag<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>Rt :Filetypes<CR>

" OmniSharp
"nnoremap <Leader><Leader>Oss :OmniSharpStartServer<CR>
"nnoremap <Leader><Leader>Osp :OmniSharpStopServer<CR>
"nnoremap <Leader>r :OmniSharpRename<CR>
"nnoremap <Leader> :OmniSharpRename<CR>

" Others
nnoremap <C-Q><C-V> :call Edit(g:vim_root_folder . '/init.vim')<CR>
nnoremap <C-Q><C-G> :call Edit(g:vim_root_folder . '/ginit.vim')<CR>
nnoremap <C-Q><C-A> :call EditTodo('~/TODO.org')<CR>
nnoremap <C-Q><C-T> :call EditTodo('TODO.org')<CR>
nnoremap <Leader>N :noh<CR>
nnoremap <Leader>r :w <CR> :so %<CR>
nnoremap <Leader>M :messages<CR>
nnoremap <F3> :set hlsearch!<CR> 

" for scrolling up and down quickly
nnoremap J 7j
nnoremap K 7k
vnoremap J 7j
vnoremap K 7k

" ------------- "
" Plugins Configurations

" Vim DevIcons
" ------------- "

if !exists('g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols')
    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
        \ 'cs': ''
    \ }
endif

" Lightline
" ------------- "

call LoadPluginSettings('lightline')

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

let g:ycm_error_symbol = ''
let g:ycm_warning_symbol = ''
let g:ycm_rust_src_path = '~/.rustup/toolchains/stable-x86_64-pc-windows-msvc/lib/rustlib/src/rust/src'
"let g:ycm_auto_start_csharp_server = 1

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

set rtp+=~/.fzf

" Spotify.vim
" ------------- "

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

" Vim Illuminate
" ------------- "

let g:illuminate_ftblacklist = ['nerdtree']

" NERD Commenter
" ------------- "

let g:NERDSpaceDelims = 1

" OmniSharp
" ------------- "

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_timeout = 5
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_highlight_types = 2
let g:OmniSharp_start_server = 0
"let g:OmniSharp_server_path = expand('~/.omnisharp/omnisharp-roslyn/OmniSharp.exe')
let g:OmniSharp_server_path = expand('~/AppData/Local/nvim/plugins-database/YouCompleteMe/third_party/omnisharp-roslyn/OmniSharp.exe')
"set previewheight=3

let g:OmniSharp_highlight_groups = {
    \ 'csUserIdentifier': [
    \   'constant name', 'enum member name', 'field name', 'identifier',
    \   'local name', 'parameter name', 'property name', 'static symbol'
    \ ],
    \ 'csUserInterface': [ 'interface name' ],
    \ 'csUserMethod': [ 'extension method name', 'method name' ],
    \ 'csUserType': [ 'class name', 'enum name', 'namespace name', 'struct name' ]
\ }

" ALE - Asynchronous Lint Engine
" ------------- "

let g:ale_sign_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

let g:ale_linters = {
    \ 'cs': [ 'OmniSharp' ] 
\ }

