if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'javascript'

call lsp_config#load()
