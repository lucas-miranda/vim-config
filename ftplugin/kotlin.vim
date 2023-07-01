if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'kotlin'

call lsp_config#load()
