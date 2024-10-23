if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'fx'

augroup filetypedetect
    au! BufRead,BufNewFile *.fx       setfiletype hlsl
augroup END
