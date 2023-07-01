if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'cs'

call lsp_config#load()
