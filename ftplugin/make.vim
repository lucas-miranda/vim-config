if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'make'

function! RecreateCsprojReferences()
    let l:path = expand('%:h')
    let l:files = globpath(l:path, '**/*.cs', 0, 1)
    let l:files = map(l:files, 'strpart(v:val, len(l:path) + 1) . " \\"')
    call append(".", l:files)
endfunction

command! RecreateCsprojReferences call RecreateCsprojReferences()
