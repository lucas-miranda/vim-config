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
"Plug 'ycm-core/YouCompleteMe', "{ 'do': 'python install.py --cs-completer' }      autocomplete as you type
Plug 'prabirshrestha/async.vim'         " Normalize async job control api between vim and neovim
Plug 'chaoren/vim-wordmotion'           " Modify lowercase motions
"Plug 'RRethy/vim-illuminate'            " Automatically hightlights matching words under cursor
Plug 'ncm2/float-preview.nvim'          " Uses neovim float window to preview
"Plug 'mhinz/vim-startify'

" Buffer Handling
Plug 'Asheq/close-buffers.vim'

" Org
"Plug 'jceb/vim-orgmode'
Plug 'vimwiki/vimwiki'                  " A personal wiki

" Git
Plug 'tpope/vim-fugitive'		        " Git integration

" File manager interface
Plug 'rafaqz/ranger.vim'                " Interface to Ranger file manager

" Code Completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

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

" Languages
Plug 'beyondmarc/hlsl.vim'
Plug 'juliosueiras/cakebuild.vim'
" -> C#
Plug 'OmniSharp/omnisharp-vim'
"Plug 'nickspoons/vim-sharpenup'

" Utilities
Plug 'KabbAmine/zeavim.vim'             " Allows to call zeal through vim
Plug 'Shougo/echodoc.vim'
Plug 'dense-analysis/ale'

" Sessions
Plug 'tpope/vim-obsession'

" Visuals
"Plug 'TaDaa/vimade'                    " Makes inactive buffers fades a bit
"Plug 'lucas-miranda/spotify.vim'        " Retrieve info from Spotify to be displayed somewhere
Plug 'sheerun/vim-polyglot'  	        " Helps others plugins with language specifics support
Plug 'itchyny/lightline.vim' 	        " Bottom powerline
Plug 'ryanoasis/vim-devicons'	        " Tons of icons
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Comfort
"Plug 'psliwka/vim-smoothie'             " Smooth scroll

" Color Theme Tools
"Plug 'lifepillar/vim-colortemplate'

" Themes
"Plug 'joshdick/onedark.vim'
"Plug 'ayu-theme/ayu-vim'
"Plug 'rafalbromirski/vim-aurora'
"Plug 'flrnd/candid.vim'
"Plug 'bluz71/vim-moonfly-colors'
"Plug 'ghifarit53/tokyonight-vim'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'srcery-colors/srcery-vim'
Plug 'sainnhe/forest-night'

call plug#end()

" ------------- "
" Theme Settings

syntax on
syntax enable

set termguicolors

" * candid
"set background=dark
"colorscheme candid

" * vim-aurora
"set background=dark
"colorscheme aurora

" * onedark
"colorscheme onedark

" * ayu
"let ayucolor = 'light'
"colorscheme ayu

" * moonfly
"colorscheme moonfly 

" * tokyonight
"let g:tokyonight_style = 'night' " available: night, storm
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight 

" * papercolor
"set background=dark " light or dark
"colorscheme PaperColor

" * srcery-vim
"let g:srcery_italic = 1
"colorscheme srcery

" * forest-night
let g:forest_night_enable_italic = 1
colorscheme forest-night

" ------------- "
" Vim Settings

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
set hidden

set ignorecase
set smartcase
set incsearch

set nobackup
set nowritebackup
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

if has('patch-8.1.1880')
    set completeopt=longest,menuone,popuphidden
    set completepopup=highlight:Pmenu,border:off
else
    set completeopt=longest,menuone
endif

set previewheight=10
set cmdheight=1

set updatetime=300
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Unix
" ------------- "

if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

    if has('unix')
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
    endif
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

function! RecreateCsprojReferences()
    let l:path = expand('%:h')
    let l:files = globpath(l:path, '**/*.cs', 0, 1)
    let l:files = map(l:files, '"<Compile Include=\"" . substitute(strpart(v:val, len(l:path) + 1), "/", "\\", "g") . "\" />"')
    call append(".", l:files)
endfunction

" Autocmds
"------------- "

" routines to execute when window loses it's focus or leaving a buffer
augroup onLostFocus
    autocmd!
    " Soft save
    autocmd BufLeave * silent! w
    autocmd FocusLost * silent! wa

    " Return to normal mode
    "autocmd BufLeave * silent! stopinsert
    "autocmd FocusLost * silent! stopinsert 
augroup END

"augroup specialCommands
"    autocmd!
"    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
"augroup END

" ------------- "
" Commands

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--all-types --numbers --ignore={.git,.vs} --width ' . (winwidth(0) - 10), {'options': '--delimiter : --nth 4..'} , <Bang>0)

command! RecreateCsprojReferences call RecreateCsprojReferences()

" ------------- "
" Key Remaps

let mapleader = "\<Space>"
let maplocalleader = "\<Space>"

" Text
nnoremap U <C-R>
nnoremap <Leader><Tab> i<Space><Space><Space><Space><C-\><C-n>
nnoremap Y yyp
  
" Editor
nnoremap <Leader>qq :q<CR>
nnoremap <Leader>qw :wq<CR>

" Movement
nnoremap <A-0> ^

" =====================
"   Splits
" =====================
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
" set buffer split to the maximum width and height possible
nnoremap <C-W><C-E> :res<CR> :vertical res<CR> 

" =====================
"   Buffers
" =====================

nnoremap <Leader>b :ls<CR>

" * movements
nnoremap <A-h> :bprevious<CR>
nnoremap <A-l> :bnext<CR>

" * split and move
nnoremap <Leader><A-h> :sbprevious<CR>
nnoremap <Leader><A-l> :sbnext<CR>

" * edit
"nnoremap <A-t> :tabnew<CR>
nnoremap <A-x> :bd<CR>

" * reallocate buffers
"nnoremap <A-j> :tabm -1<CR>
"nnoremap <A-k> :tabm +1<CR>

" =====================
"   Tabs
" =====================

" * movements
nnoremap <C-A-h> :tabprevious<CR>
nnoremap <C-A-l> :tabnext<CR>
inoremap <C-A-h> <Esc>:tabprevious<CR>i
inoremap <C-A-l> <Esc>:tabnext<CR>i
tnoremap <C-A-h> <C-\><C-N>:tabprevious<CR>
tnoremap <C-A-l> <C-\><C-N>:tabnext<CR>

" * edit
nnoremap <C-A-t> :call fzf#run(fzf#wrap({'sink': 'tabedit!'}))<CR>
nnoremap <C-A-x> :tabclose<CR>
inoremap <C-A-t> <Esc>:tabnew<CR>i
inoremap <C-A-x> <Esc>:tabclose<CR>
tnoremap <C-A-t> <C-\><C-N>:tabnew<CR>
tnoremap <C-A-x> <C-\><C-N>:tabclose<CR>

" * reallocate tabs
nnoremap <C-A-j> :tabm -1<CR>
nnoremap <C-A-k> :tabm +1<CR>
tnoremap <C-A-j> :tabm -1<CR>
tnoremap <C-A-k> :tabm +1<CR>

" * sends current buffer to a new tab
nnoremap <C-W>t <C-W>T
nnoremap <C-W><C-T> <C-W>T

" Terminal
tnoremap <Esc> <C-\><C-n>

" Others
nnoremap <C-Q><C-V> :call Edit(g:vim_root_folder . '/init.vim')<CR>
nnoremap <C-Q><C-G> :call Edit(g:vim_root_folder . '/ginit.vim')<CR>
nnoremap <Leader>N :noh<CR>
nnoremap <Leader>M :messages<CR>
nnoremap <F3> :set hlsearch!<CR> 
nnoremap <buffer> <Leader>r :e <CR>

" Language Opts
" ------------- "

let g:cs_keybinds_scheme = 'omni' " values: omni or ycm

" Plugins
" ------------- "

call plugins#load_settings('close-buffers.vim')
call plugins#load_settings('ale')
"call plugins#load_settings('YouCompleteMe') ", 'omnisharp-vim')
call plugins#load_settings('vim-illuminate')
call plugins#load_settings('vimwiki')
call plugins#load_settings('ranger.vim')
call plugins#load_settings('fzf.vim')
call plugins#load_settings('omnisharp-vim')
call plugins#load_settings('vim-sharpenup')
call plugins#load_settings('zeavim.vim')
call plugins#load_settings('echodoc.vim')
call plugins#load_settings('spotify.vim')
call plugins#load_settings('lightline.vim')
call plugins#load_settings('vim-obsession')
call plugins#load_settings('vim-hexokinase')
call plugins#load_settings('vim-devicons')
call plugins#load_settings('float-preview.nvim')
call plugins#load_settings('vim-startify')
call plugins#load_settings('coc.nvim')

" .org
" ------------- "

autocmd FileType org setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType cake setlocal shiftwidth=4 softtabstop=4 expandtab

"
"

if has('nvim')
    " Disable nvim match parenthesis
    let loaded_matchparen = 1
endif
