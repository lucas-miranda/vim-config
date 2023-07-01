
vim.cmd([[
function! StripTrailingWhitespaces()
    if !&binary && &filetype != 'diff'
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endif
endfun

autocmd FileType * autocmd BufWritePre <buffer> :call StripTrailingWhitespaces()

" routines to execute when window loses it's focus or leaving a buffer
function! StripTrailingWhitespacesAndSave()
    call StripTrailingWhitespaces()
    write
endfun

function! StripTrailingWhitespacesAndSaveAll()
    call StripTrailingWhitespaces()
    wall
endfun

augroup onLostFocus
    autocmd!

    " Soft save
    "autocmd BufLeave * silent! :call StripTrailingWhitespacesAndSave()
    autocmd FocusLost * silent! :call StripTrailingWhitespacesAndSaveAll()

    " Return to normal mode
    "autocmd BufLeave * silent! stopinsert
    "autocmd FocusLost * silent! stopinsert
augroup END

"augroup specialCommands
"    autocmd!
"    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
"augroup END
]])
