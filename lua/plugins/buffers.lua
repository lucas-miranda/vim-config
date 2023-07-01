-- buffer Handling

return {
    {
        'Asheq/close-buffers.vim',
        keys = {
            { 'Q', '<cmd>Bdelete menu<cr>', desc = 'Open close buffers menu.', silent = true },
        }
    },
}
