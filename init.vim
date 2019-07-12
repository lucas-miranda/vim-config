" Plugins
call plug#begin('~/AppData/Local/nvim/plugins-database')

" General
Plug 'tpope/vim-sensible'    	" a standard vimrc configuration
Plug 'scrooloose/nerdtree'   	" file tree viewer
Plug 'kassio/neoterm'			" terminal inside vim

" Git
Plug 'tpope/vim-fugitive'		" Git integration

" Fuzzyfinder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntax Checker
" Plug 'vim-syntastic/syntastic'

" Languages
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

set guifont=FuraCode\ NF:h12
execute 'GuiFont! FuraCode NF:h12'

syntax on
colorscheme onedark
set termguicolors

set noshowmode " lightline plugin already handles mode
set showcmd

set number
set showmatch

set tabstop=4
set shiftwidth=4
set autoindent
set copyindent
set nowrap
set smarttab

set backspace=indent,eol,start

set hlsearch
set incsearch

set nobackup
set noswapfile

set history=1000
set undolevels=1000
set title

" ------------- "

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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
\ }

function! Filetype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! Fileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

"
" augroup AutoSyntastic
" 	autocmd!
" 	autocmd BufWritePost *.rs,*.toml call s:syntastic()
" augroup END

" function! s:syntastic()
"	SyntasticCheck
"	call lightline#update()
"endfunction

