"
" Helpers to assist plugins loading
"   main goal is to make init.vim less bloated
"   by separating plugin settings loading and
"   any checks needed
"
"   Requires:
"     * github.com/junegunn/vim-plug
"

if exists('g:loaded_plugins')
  finish
endif
let g:loaded_plugins = 1

function! s:exists_file(filepath)
    return !empty(glob(a:filepath))
endfunction

function! plugins#is_plugin_loaded(name)
    return has_key(g:plugs, a:name)
endfunction

" args:
"   #0 | plugin_name => plugin exactly name
"   #1 | force => 0 or 1
function! plugins#load_settings(plugin_name, ...) 
    let l:force = 0

    if a:0 > 0
        let l:force = a:1
    endif

    if !l:force && !plugins#is_plugin_loaded(a:plugin_name)
        echohl WarningMsg
        echomsg "Warning: Plugin '" . a:plugin_name . "' isn't loaded"
        echohl None
        return 0
    endif

    let l:plugin_settings_foldername = tolower(a:plugin_name)
    let l:full_path = g:vim_root_folder . '/settings/plugins/' . l:plugin_settings_foldername . '.settings.vim'

    if !s:exists_file(l:full_path)
        echoerr "Plugin settings file '" . l:full_path . "' doesn't exists"
        return 0
    endif
    
    execute 'so ' . l:full_path
    return 1
endfunction

function! plugins#load_settings_with_dependents(plugin_name, ...)
    if !plugins#load_settings(a:plugin_name)
        return 0
    endif

    echomsg "Loading '" . a:plugin_name . "' dependents..."

    for arg in a:000
        call plugins#load_settings(arg, 1)
    endfor

    echomsg "Dependents from '" . a:plugin_name . "' loaded!"
    return 1
endfunction
