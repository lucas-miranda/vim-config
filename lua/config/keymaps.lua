-------------------------
-- Map functions

local function map(mode, lhs, rhs, opts)
    --[[
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
    end
    ]]

    vim.keymap.set(mode, lhs, rhs, opts)
end

local function nmap(lhs, rhs, opts)
    map('n', lhs, rhs, opts)
end

local function imap(lhs, rhs, opts)
    map('i', lhs, rhs, opts)
end

local function xmap(lhs, rhs, opts)
    map('x', lhs, rhs, opts)
end

local function del_map(mode, lhs, opts)
    vim.keymap.del(mode, lhs, opts)
end

-------------------------

-- useless command history navigation
-- I *always* type this instead of :q
--del_map('n', 'q:')


-------------------------
-- Text
-------------------------

--> Redo
map('n', 'U', '<C-R>')

--> Insert 4 spaces
nmap('<leader><tab>', 'i<space><space><space><space><C-\\><C-n>')

--> Duplicate line
nmap('Y', 'yyp')

--> Move line up
nmap('Dk', 'ddkP')
nmap('DK', 'ddkP')

--> Move line down
nmap('Dj', 'ddp')
nmap('DJ', 'ddp')

--> Highlight every word which is the same as which the cursor is above
map(
    { 'n', 'x', 's', 'o' },
    '*',
    ":let @/='\\<<C-R>=expand(\"<cword>\")<cr>\\>'<cr>:set hls<cr>",
    { silent = true }
)

--> Paste from clipboard register
map({ 'n', 'x' }, '\\y', '"+y')

--> Paste from clipboard register
map({ 'n', 'x' }, '\\p', '"+p')
map({ 'n', 'x' }, '\\P', '"+P')

--> Execute visual selected expression
xmap('\\=', 'c<C-R>=<C-R>"<cr>')

--> Sort lines at visual range
xmap('S', ':\'<,\'>sort<cr>')

-------------------------
-- Movement

--> Move to line first char
nmap('<A-0>', '^')

-------------------------
-- Macros

nmap('q', '<nop>', { noremap = true })
nmap('<leader>m', 'q', { noremap = true, desc = 'Record macro' })
nmap('<M-,>', 'Q', { noremap = true, desc = 'Replay last register as macro' })

-------------------------
-- Editor

nmap('q', '<cmd>w<cr>')

-------------------------
-- Marks

--> Go to it's position at line, instead only returning to the given line
nmap("'", '`')

-------------------------
-- Splits
-------------------------

nmap('<C-j>', '<C-w><C-j>')
nmap('<C-k>', '<C-w><C-k>')
nmap('<C-l>', '<C-w><C-l>')
nmap('<C-h>', '<C-w><C-h>')
--tmap('<C-J>', '<C-\\><C-N><C-W><C-J>')
--tmap('<C-K>', '<C-\\><C-N><C-W><C-K>')
--tmap('<C-L>', '<C-\\><C-N><C-W><C-L>')
--tmap('<C-H>', '<C-\\><C-N><C-W><C-H>')
nmap('<C-W><C-J>', '<C-W>J')
nmap('<C-W><C-K>', '<C-W>K')
nmap('<C-W><C-L>', '<C-W>L')
nmap('<C-W><C-H>', '<C-W>H')
nmap('<leader>v', '<cmd>vsp<cr>')
nmap('<leader>h', '<cmd>sp<cr>')

--> set buffer split to the maximum width and height possible
nmap('<C-W><C-E>', '<cmd>res<cr> <cmd>vertical res<cr>')


-------------------------
-- Buffers
-------------------------

--nmap('<leader>b', '<cmd>ls<cr>')

--> * movements
--nmap('<A-h>', '<cmd>bprevious<cr>')
--nmap('<A-l>', '<cmd>bnext<cr>')

--> * spit and move
--nmap('<leader><A-h>', '<cmd>sbprevious<cr>')
--nmap('<leader><A-l>', '<cmd>sbnext<cr>')

--> * edit
--nmap('<A-t>', '<cmd>tabnew<cr>')
--nmap('<A-x>', '<cmd>bd<cr>')

--> * reallocate buffers
--nmap('<A-j>', '<cmd>tabm -1<cr>')
--nmap('<A-k>', '<cmd>tabm +1<cr>')


-------------------------
-- Tabs
-------------------------

--> * movements
nmap('<A-h>', '<cmd>tabprevious<cr>')
nmap('<A-l>', '<cmd>tabnext<cr>')
imap('<A-h>', '<esc><cmd>tabprevious<cr>i')
imap('<A-l>', '<esc><cmd>tabnext<cr>i')
--tmap('<A-h>', '<C-\\><C-N><cmd>tabprevious<cr>')
--tmap('<A-l>', '<C-\\><C-N><cmd>tabnext<cr>')

--> * edit
nmap('<A-t>', "<cmd>call fzf#run(fzf#wrap({'sink': 'tabedit!'}))<cr>")
nmap('<A-X>', '<cmd>tabclose<cr>')
nmap('<A-x>', '<cmd>x<cr>')
nmap('<leader><A-x>', '<cmd>q!<cr>')
imap('<A-t>', '<Esc><cmd>tabnew<cr>i')
imap('<A-X>', '<Esc><cmd>tabclose<cr>')
nmap('<A-x>', '<Esc><cmd>x<cr>')
--tmap('<A-t>', '<C-\\><C-N><cmd>tabnew<cr>')
--map({ 'n', 'x', 's', 'o' }, '<A-x>', ' <C-\\><C-N><cmd>tabclose<cr>')

--> * reallocate tabs
nmap('<A-j>', '<cmd>tabm -1<cr>')
nmap('<A-k>', '<cmd>tabm +1<cr>')
--map({ 'n', 'x', 's', 'o' }, '<A-j>', '<cmd>tabm -1<cr>')
--map({ 'n', 'x', 's', 'o' }, '<A-k>', '<cmd>tabm +1<cr>')

--> * sends current buffer to a new tab
nmap('<A-w>', '<C-W>T')
--nmap('<C-W><C-T>', '<C-W>T')

--> Terminal
map({ 'n', 'x', 's', 'o' }, '<C-BS>', '<C-\\><C-n>')

--> Others
nmap('<C-z>', '<nop>')
nmap('<C-Q><C-V>', function() vim.fn.edit(vim.g.vim_root_folder .. '/init.lua') end)
nmap('<C-Q><C-G>', function() vim.fn.edit(vim.g.vim_root_folder .. '/ginit.vim') end)
nmap('<leader>N', '<cmd>noh<cr>')
nmap('<leader>M', '<cmd>messages<cr>')
nmap('<F3>', '<cmd>set hlsearch!<cr>')
nmap('<buffer>', '<leader>r <cmd>e<cr>')


-------------------------
-- Experimental
-------------------------

map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
