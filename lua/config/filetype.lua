vim.cmd([[
autocmd BufNewFile,BufRead *.gd setfiletype gdscript
]])

vim.filetype.add({
    extension = {
        gd = 'gdscript',
    },
    pattern = {
        ['.+%.gd'] = 'gdscript',
        ['.+%.gdscript'] = 'gdscript',
    },
})

