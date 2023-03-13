-- Keybind function shortcut
local function map(mode, key, cmd, opts)
    local options = {}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, key, cmd, options)
end

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>") -- pop WhichKey up on leader press
-- map("n", "<C-i>", "<C-i>", opts) -- ??


--NORMAL--

-- Do not yank with x
map("n", "x", '"_x', opts)

-- Select all
map("n", "yA", ":0,$y<cr>", opts)

-- New Tab/Easy Splits
-- Tabs --
map("n", "<m-t>", ":tabnew %<cr>", opts)
map("n", "te", ":tabedit<CR>", opts)

-- Easy Buffer Navigation
map("n", "[b", ":bprevious<CR>", opts)
map("n", "]b", ":bnext<CR>", opts)
map("n", "[t", ":tabprevious<CR>", opts)
map("n", "]t", ":tabnext<CR>", opts)
-- map("n", "gb", ":bnext<CR>", opts)

map("n", "<C-w> c", ":bdelete!<CR>", opts)
map("n", "<C-\\>", ":vsplit<CR>", opts) -- VSCode-like shortcut

-- Explorer/Tree
map("n", "<Leader>e", ":lua require'nvim-tree'.toggle()<CR>", opts)

-- Easy Source
map("n", "<Leader><Leader>x", ":so $MYVIMRC<CR>", opts)

-- Resize with arrows
map("n", "<M-Up>", ":resize +2<CR>", opts)
map("n", "<M-Down>", ":resize -2<CR>", opts)
map("n", "<M-Left>", ":vertical resize -2<CR>", opts)
map("n", "<M-Right>", ":vertical resize +2<CR>", opts)

-- Navigate Lines
map("n", "<C-l>", "$", opts)
map("n", "<C-h>", "^", opts)

-- VISUAL --
-- Stay in indent mode after indentation
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Navigate Lines
map("v", "<C-l>", "$", opts)
map("v", "<C-h>", "^", opts)

-- Move text up and down (doesn't work in terms that don't send alt correctly)
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)
map("x", "p", '"_dP', opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

-- VISUAL BLOCK --
-- Move text up and down (sick as hell)
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation (allows easy window switching)
map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
