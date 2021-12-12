if has('g:ginit_loaded')
    finish
endif

let g:ginit_loaded = 1

if exists('g:neovide')
    set guifont=FiraCode\ Nerd\ Font\ Mono:h11
    "set guifont=Ubuntu\ Mono\ R:h14

    "set guifont=Liga\ SFMono\ Nerd\ Font:h11

    "set guifont=Victor\ Mono:h11
else
    GuiFont! FuraCode NF:h11
    GuiPopupmenu 0
endif
