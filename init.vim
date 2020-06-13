if has('win32')
    let g:vim_root_folder = '~/AppData/Local/nvim'
    let g:python3_host_prog = expand('C:/Program Files/Python37/python')
    let g:python_host_prog = g:python3_host_prog
else
    let g:vim_root_folder = '/home/luke/.config/nvim'
endif


" Plugins Manager
call plug#begin(g:vim_root_folder . '/plugins-database')

" General
Plug 'tpope/vim-sensible'    	        " A standard vimrc configuration
Plug 'ycm-core/YouCompleteMe', "{ 'do': 'python install.py --cs-completer' }      autocomplete as you type
Plug 'prabirshrestha/async.vim'         " Normalize async job control api between vim and neovim
Plug 'chaoren/vim-wordmotion'           " Modify lowercase motions
Plug 'RRethy/vim-illuminate'            " Automatically hightlights matching words under cursor
Plug 'ncm2/float-preview.nvim'          " Uses neovim float window to preview

" Org
"Plug 'jceb/vim-orgmode'
Plug 'vimwiki/vimwiki'                  " A personal wiki

" Git
Plug 'tpope/vim-fugitive'		        " Git integration

" File manager interface
Plug 'rafaqz/ranger.vim'                " Interface to Ranger file manager

" Fuzzyfinder
"  Note!  Install 'fd' and set FZF_DEFAULT_COMMAND
"  FZF_DEFAULT_COMMNAND="fd --type f --hidden --follow --exclude .git"
set rtp+=~/.fzf
if has('win32')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'sh install --all' }
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif

Plug 'junegunn/fzf.vim'

" Language Syntax
Plug 'beyondmarc/hlsl.vim'
Plug 'juliosueiras/cakebuild.vim'

" Utilities
Plug 'chrisbra/Colorizer'               " Colorize colors definitions

" Visuals
"Plug 'TaDaa/vimade'                    " Makes inactive buffers fades a bit
Plug 'lucas-miranda/spotify.vim'        " Retrieve info from Spotify to be displayed somewhere
Plug 'sheerun/vim-polyglot'  	        " Helps others plugins with language specifics support
Plug 'itchyny/lightline.vim' 	        " Bottom powerline
Plug 'ryanoasis/vim-devicons'	        " Tons of icons

" Themes
Plug 'joshdick/onedark.vim'

call plug#end()

" ------------- "
" Vim Settings

syntax on
colorscheme onedark
set termguicolors

set nocompatible
set noshowmode " lightline.vim plugin already handles mode
set showcmd

"set wrap linebreak nolist

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

set ignorecase
set smartcase
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
"set foldlevelstart=1
set foldlevel=20
filetype plugin indent on
filetype plugin on

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

set previewheight=10
set completeopt=longest,menuone

" Unix
" ------------- "

if has('unix')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
endif

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

" Autocmds
"------------- "

" Soft save when leaving a buffer or window loses focus
augroup autoSoftSave
    autocmd!
    autocmd BufLeave * silent! w
    autocmd FocusLost * silent! wa
augroup END

"augroup specialCommands
"    autocmd!
"    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
"augroup END

" ------------- "
" Commands

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--all-types --numbers --ignore={.git,.vs} --width ' . (winwidth(0) - 10), {'options': '--delimiter : --nth 4..'} , <Bang>0)

" ------------- "
" Key Remaps

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Text
nnoremap U <C-R>

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"tnoremap <C-J> <C-\><C-N><C-W><C-J>
"tnoremap <C-K> <C-\><C-N><C-W><C-K>
"tnoremap <C-L> <C-\><C-N><C-W><C-L>
"tnoremap <C-H> <C-\><C-N><C-W><C-H>
nnoremap <C-W><C-J> <C-W>J
nnoremap <C-W><C-K> <C-W>K
nnoremap <C-W><C-L> <C-W>L
nnoremap <C-W><C-H> <C-W>H
nnoremap <Leader>v :vsp<CR>
nnoremap <Leader>h :sp<CR>
" set split to the maximum width and height possible
nnoremap <C-W><C-E> :res<CR> :vertical res<CR> 

" Tabs
nnoremap <A-h> :tabprevious<CR>
nnoremap <A-l> :tabnext<CR>
nnoremap <A-t> :tabnew<CR>
nnoremap <A-x> :tabclose<CR>
inoremap <A-h> <Esc>:tabprevious<CR>i
inoremap <A-l> <Esc>:tabnext<CR>i
inoremap <A-t> <Esc>:tabnew<CR>i
inoremap <A-x> <Esc>:tabclose<CR>
tnoremap <A-h> <C-\><C-N>:tabprevious<CR>
tnoremap <A-l> <C-\><C-N>:tabnext<CR>
tnoremap <A-t> <C-\><C-N>:tabnew<CR>
tnoremap <A-x> <C-\><C-N>:tabclose<CR>
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> 10gt
nnoremap <A-t>s <C-W>T
nnoremap <A-t><A-t> <C-W>T

" Terminal
tnoremap <Esc> <C-\><C-n>

" Others
nnoremap <C-Q><C-V> :call Edit(g:vim_root_folder . '/init.vim')<CR>
nnoremap <C-Q><C-G> :call Edit(g:vim_root_folder . '/ginit.vim')<CR>
nnoremap <C-Q><C-A> :call EditTodo('~/TODO.org')<CR>
nnoremap <C-Q><C-T> :call EditTodo('TODO.org')<CR>
nnoremap <Leader>N :noh<CR>
nnoremap <Leader>M :messages<CR>
nnoremap <F3> :set hlsearch!<CR> 
nnoremap <buffer> <Leader>r :e <CR>

" Language Opts
" ------------- "

let g:cs_keybinds_scheme = 'ycm'

" Plugins
" ------------- "

call plugins#load_settings_with_dependents('YouCompleteMe', 'omnisharp')
call plugins#load_settings('vim-illuminate')
call plugins#load_settings('vimwiki')
call plugins#load_settings('ranger.vim')
call plugins#load_settings('fzf.vim')
call plugins#load_settings('spotify.vim')
call plugins#load_settings('lightline.vim')
call plugins#load_settings('vim-devicons')
call plugins#load_settings('float-preview.nvim')
"call plugins#load_settings('ale')
"call LoadPluginSettings('nerdcommenter')
"call LoadPluginSettings('nerdtree')
"call LoadPluginSettings('racer')

" .org
" ------------- "

autocmd FileType org setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType cake setlocal shiftwidth=4 softtabstop=4 expandtab
