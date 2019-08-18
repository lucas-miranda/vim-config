" Keymaps

" Specifics

"
" lightline detail modes will work as:
"   0 - normal (full informations)
"   1 - simplified (important info and some extra)
"   2 - minimal (only most important info)
"
" more detail modes can be added, but it should always be
" in descending order of detail
"
let g:lightline_detail_modes = [
    \ {
    \   'name': 'full'
    \ }, {
    \   'name': 'simplified',
    \   'max-width': 0.5
    \ }, {
    \   'name': 'minimal',
    \   'max-width': 0.34
    \ }
\ ]

function! s:lightline_detail_mode(detail_mode_level)
    let l:level = 0

    for mode in g:lightline_detail_modes
        if a:detail_mode_level == l:level
            return mode
        endif

        let l:level += 1
    endfor
endfunction

function! s:lightline_current_detail_mode()
    let l:current_width = winwidth(0)
    let l:window_width = &columns
    let l:detail_mode_name = ''
    let l:detail_mode_level = 0

    let l:current_detail_mode_level = 0

    for mode in g:lightline_detail_modes
        if has_key(mode, 'max-width') && l:current_width / (l:window_width * 1.0) <= mode['max-width']
            let l:detail_mode_name = mode.name
            let l:detail_mode_level = l:current_detail_mode_level
        endif

        let l:current_detail_mode_level += 1
    endfor

    let l:detail_mode = g:lightline_detail_modes[l:detail_mode_level]

    return { 
        \ 'level': l:detail_mode_level, 
        \ 'name': l:detail_mode.name, 
        \ 'mode': l:detail_mode
    \ }
endfunction

let g:lightline = {
    \ 'colorscheme': 'one',
	\ 'active': {
	\	'left': [
	\		[ 'mode' ],
	\		[ 'readonly', 'filename', 'codeanalysis' ],
	\		[ 'gitbranch' ],
	\		[ 'lineinfo', 'ctrlpmark' ]
	\ 	],
	\	'right': [
	\		[ 'filetype' ],
	\		[ 'time' ],
	\		[ 'music', 'fileencoding', 'fileformat' ]
	\	]
	\ },
    \ 'inactive': {
    \   'left': [ 
    \       [ 'inactivemodeorfilename' ],
    \       [ ],
    \       [ 'lineinfo' ]
    \   ],
    \   'right': [ 
    \       [ 'filetype' ]
    \   ] 
    \ },
	\ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'readonly': 'LightlineReadonly',
	\	'fileformat': 'LightlineFileformat',
	\	'filetype': 'LightlineFiletype',
	\	'fileencoding': 'LightlineFileencoding',
	\	'mode': 'LightlineMode',
	\	'inactivemode': 'LightlineInactiveMode',
	\ 	'gitbranch': 'LightlineFugitive',
	\	'ctrlpmark': 'CrtlPMark',
	\	'time': 'LightlineCurrentTime',
	\	'music': 'LightlineMusicDisplay',
	\	'codeanalysis': 'LightlineCodeAnalysis',
    \   'inactivemodeorfilename': 'LightlineInactiveModeOrFilename'
	\ },
	\ 'component_expand': {
	\ },
	\ 'component_type': {
	\ },
    \ 'component': {
	\   'lineinfo': ' %l:%v',
    \ },
    \ 'separator': {
	\   'left': '',
    \   'right': ''
    \ },
    \ 'subseparator': {
	\   'left': '',
    \   'right': '' 
    \ }
\ }

function! LightlineInactiveModeOrFilename()
    let l:mode = LightlineInactiveMode()

    if l:mode == ''
        return LightlineFilename()
    endif

    return l:mode
endfunction

function! LightlineCodeAnalysis()
    let l:detail_mode = s:lightline_current_detail_mode()

    if l:detail_mode.name !=? 'full' 
        return ''
    endif

    let l:code_analysis = ''

    let l:is_some_analyzer_working = 0
    let l:error_count = 0
    let l:warn_count = 0

    try 
        " ALE
        let l:ale_counts = ale#statusline#Count(bufnr(''))

        let l:ale_errors = l:ale_counts.error + l:ale_counts.style_error
        let l:ale_non_errors = l:ale_counts.total - l:ale_errors

        let l:error_count += l:ale_errors
        let l:warn_count += l:ale_non_errors

        let l:is_some_analyzer_working = 1
    catch
    endtry

    try
        " YCM

        let l:error_count += youcompleteme#GetErrorCount()
        let l:warn_count += youcompleteme#GetWarningCount()

        let l:is_some_analyzer_working = 1
    catch
    endtry

    if l:is_some_analyzer_working == 1
        let l:code_analysis = g:ycm_error_symbol . ' ' . l:error_count . '  ' . g:ycm_warning_symbol . ' ' . l:warn_count
    endif

    return l:code_analysis
endfunction

function! LightlineMusicDisplay()
    let l:detail_mode = s:lightline_current_detail_mode()
    let l:music_display = spotify#player#display()

    " impose some width limits to music_display
    let l:display_length = len(l:music_display)
    if l:display_length > 70 " max width to make detail mode decay one level
        if l:detail_mode.level - 1 >= 0
            let l:previous_mode = s:lightline_detail_mode(l:detail_mode.level - 1)
            let l:detail_mode.level = l:detail_mode.level - 1
            let l:detail_mode.name = l:previous_mode.name
            let l:detail_mode.mode = l:previous_mode
        endif
    elseif l:display_length > 50 " max width to make detail mode decay two level
        if l:detail_mode.level - 2 >= 0
            let l:new_mode = s:lightline_detail_mode(l:detail_mode.level - 2)
            let l:detail_mode.level = l:detail_mode.level - 2
            let l:detail_mode.name = l:new_mode.name
            let l:detail_mode.mode = l:new_mode
        endif
    endif

    if l:detail_mode.name ==? 'minimal'
        return ''
    elseif l:detail_mode.name ==? 'simplified'
        return spotify#player#status_icon() . ' ' . spotify#player#track()
    else
        return l:music_display
    endif

    return spotify#player#status_icon()
endfunction

let s:clock_full_display = 0

function! LightlineCurrentTime()
    let l:detail_mode = s:lightline_current_detail_mode()

    if l:detail_mode.name ==? 'minimal' 
        return ''
    endif

    let clock_text = ''

    if l:detail_mode.name ==? 'simplified' 
        let clock_text = ' %H:%M'
    else
        if s:clock_full_display
            let clock_text = ' %H:%M | %A, %d de %B de %Y' 
        else
            let clock_text = ' %H:%M | %a %d/%b'
        endif
    endif

    return strftime(clock_text)
endfunction

function! LightlineModified()
    if &ft =~ 'help'
        return '' "
    elseif &modified
        return '﯑'
    elseif &modifiable
        return ''
    endif

    return '-'
endfunction

function! LightlineReadonly()
    if &ft !~? 'help' && &readonly 
        return ''
    endif

    return ''
endfunction

function! LightlineFilename()
    let l:detail_mode = s:lightline_current_detail_mode()

    if l:detail_mode.name == 'minimal'
        return ''
    endif

    let l:fname = expand('%:t')

    if l:fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item')
        return g:lightline.ctrlp_item
    elseif l:fname == '__Tagbar__'
        return g:lightline.fname
    elseif l:fname =~ '__Gundo\|NERD_tree' 
        return ''
    elseif &ft == 'vimfiler'
        return vimfiler&get_status_string()
    elseif &ft == 'unite'
        return unite#get_status_string()
    elseif &ft == 'vimshell'
        return vimshell#get_status_string()
    endif

    let l:display_fname = ''

    let l:readonly = LightlineReadonly()
    if l:readonly != ''
        let l:display_fname .= l:readonly . ' '
    endif

    if l:fname != ''
        let l:display_fname .= l:fname
    else
        let l:display_fname .= '[No Name]'
    endif

    let l:modified = LightlineModified()
    if l:modified != ''
        let l:display_fname .= ' ' . l:modified
    endif

    return l:display_fname
endfunction

function! LightlineFugitive()
    let l:detail_mode = s:lightline_current_detail_mode()

    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ''
            let branch = fugitive#head()

            if branch !=# ''
                if l:detail_mode.name == 'minimal'
                    return mark
                endif

                return mark . ' ' . branch
            endif
        endif
    catch
    endtry

    return ''
endfunction

function! LightlineFileformat()
    let l:detail_mode = s:lightline_current_detail_mode()

    if l:detail_mode.name ==? 'full'
        return &fileformat . ' ' . WebDevIconsGetFileFormatSymbol()
    endif

    return ''
endfunction

function! LightlineFiletype()
    let l:detail_mode = s:lightline_current_detail_mode()

    if l:detail_mode.name ==? 'minimal'
        return WebDevIconsGetFileTypeSymbol()
    elseif strlen(&filetype)
        return &filetype . ' ' . WebDevIconsGetFileTypeSymbol()
    endif

    return 'no ft'
endfunction

function! LightlineFileencoding()
    let l:detail_mode = s:lightline_current_detail_mode()

    if l:detail_mode.name ==? 'full'
        if &fenc !=# ''
            return &fenc
        else
            return &enc
        endif
    endif

    return ''
endfunction

function! LightlineMode()
    let l:fname = expand('%:t')

    if l:fname == '__Tagbar__'
        return 'Tagbar'
    elseif l:fname == 'ControlP'
        return 'CtrlP'
    elseif l:fname == '__Gundo__'
        return 'Gundo'
    elseif l:fname == '__Gundo_Preview__'
        return 'Gundo Preview'
    elseif l:fname =~ 'NERD_tree'
        return 'NERDTree'
    elseif &ft == 'unite'
        return 'Unite'
    elseif &ft == 'vimfiler'
        return 'VimFiler'
    elseif &ft == 'vimshell'
        return 'VimShell'
    endif

    return lightline#mode()
endfunction

function! LightlineInactiveMode()
    let l:fname = expand('%:t')

    if l:fname == '__Tagbar__'
        return 'Tagbar'
    elseif l:fname == 'ControlP'
        return 'CtrlP'
    elseif l:fname == '__Gundo__'
        return 'Gundo'
    elseif l:fname == '__Gundo_Preview__'
        return 'Gundo Preview'
    elseif l:fname =~ 'NERD_tree'
        return 'NERDTree'
    elseif &ft == 'unite'
        return 'Unite'
    elseif &ft == 'vimfiler'
        return 'VimFiler'
    elseif &ft == 'vimshell'
        return 'VimShell'
    endif

    return ''
endfunction

function! CtrlPMark()
    if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
              \ , g:lightline.ctrlp_next], 0)
    endif

    return ''
endfunction

let g:ctrlp_status_func = {
    \ 'main': 'CtrlPStatusFunc_1',
    \ 'prog': 'CtrlPStatusFunc_2',
\ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

" Syntastic can call a post-check hook, let's update lightline there
" For more information: :help syntastic-loclist-callback
"function! SyntasticCheckHook(errors)
    "call lightline#update()
"endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

function! LightlineReload()
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
endfunction
