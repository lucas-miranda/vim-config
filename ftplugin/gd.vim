if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'gdscript'

call lsp_config#load()

function! FixTab()
    set tabstop=4
    set shiftwidth=0
    set expandtab
    set softtabstop=0
    set autoindent
    set copyindent
    set smarttab
endfunction

autocmd BufEnter *.gd call FixTab()
