if exists('b:format_plugin_type')
    finish
endif

let b:format_plugin_type = 'xml'

function! RecreateCsprojReferences()
    let l:path = expand('%:h')
    let l:files = globpath(l:path, '**/*.cs', 0, 1)
    let l:files = map(l:files, '"<Compile Include=\"" . substitute(strpart(v:val, len(l:path) + 1), "/", "\\", "g") . "\" />"')
    call append(".", l:files)
endfunction

command! RecreateCsprojReferences call RecreateCsprojReferences()
