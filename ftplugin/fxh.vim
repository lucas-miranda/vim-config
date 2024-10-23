if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'fxh'

augroup filetypedetect
    au! BufRead,BufNewFile *.fxh       setfiletype hlsl
augroup END
