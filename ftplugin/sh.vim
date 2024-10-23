if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'sh'

augroup filetypedetect
    au! BufRead,BufNewFile *.sh       setfiletype sh
augroup END
