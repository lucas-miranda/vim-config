let vim_root_folder = '~/AppData/Local/nvim'

" Plugins Manager
call plug#begin(vim_root_folder . '/plugins-database')

" General
Plug 'tpope/vim-sensible'    	" a standard vimrc configuration
Plug 'scrooloose/nerdtree'   	" file tree viewer
" Plug 'kassio/neoterm'			" terminal inside vim
Plug 'ycm-core/YouCompleteMe'   " autocomplete as you type
                                " langs installed: rust and C#

" Git
Plug 'tpope/vim-fugitive'		" Git integration

" Fuzzyfinder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntax Checker
" Plug 'vim-syntastic/syntastic'

" Compile
Plug 'neomake/neomake'

" Language Specifics
Plug 'rust-lang/rust.vim'

" Visuals
Plug 'sheerun/vim-polyglot'  	" helps others plugins with language specifics support
Plug 'itchyny/lightline.vim' 	" bottom powerline
Plug 'ryanoasis/vim-devicons'	" tons of icons

" Themes
Plug 'junegunn/seoul256.vim'
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

" ------------- "
" Key Remaps

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Terminal
tnoremap <Esc> <C-\><C-n>

" Others
nnoremap <C-Q><C-V> :call Edit(vim_root_folder . '/init.vim')<CR>

" ------------- "
" Plugins Configurations

" Lightline
" ------------- "

let g:lightline = {
	\ 'active': {
	\	'left': [
	\		[ 'mode', 'paste' ],
	\		[ 'readonly', 'filename', 'modified', 'syntastic' ],
	\		[ 'gitbranch' ],
	\		[ 'lineinfo' ]
	\ 	],
	\	'right': [
	\		[ 'percent' ],
	\		[ 'fileformat' ],
	\		[ 'fileencoding', 'filetype' ]
	\	]
	\ },
	\ 'component_function': {
	\	'filetype': 'Filetype',
	\	'fileformat': 'Fileformat',
	\ 	'gitbranch': 'fugitive#head',
	\ 	'syntastic-warnings': 'syntastic#warningmsg',
	\ 	'syntastic-statusflag': 'SyntasticStatuslineFlag',
	\ },
	\ 'component_expand': {
	\	'syntastic': 'SyntasticStatuslineFlag'
	\ },
	\ 'component_type': {
	\	'syntastic': 'error'
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

function! Filetype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! Fileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
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

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" ------------- "
" Other Configurations

function! Edit(filepath)
	execute "e " . fnameescape(a:filepath)
endfunction
