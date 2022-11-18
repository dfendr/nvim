local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
-- map(mode, key, cmd, options) = (vim.api.nvim_set_keymap(mode, key, cmd, options)
local map = require("user.utils").map

-- Remap space as leader key
--map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
map("n", "<C-Space>", "<cmd>WhichKey \\<leader><cr>") -- pop WhichKey up on leader press
map("n", "<C-i>", "<C-i>", opts) -- ??

--NORMAL--
-- Increment/Decrement
-- map("n", "+", "<C-a>", opts)
-- map("n", "-", "<C-x>", opts)

-- Do not yank with x
map("n", "x", '"_x', opts)

-- Clear highlighting after searching.
-- map("n", "_", "<cmd>nohl<CR>", opts)

-- Select all
-- map("n", "<C-a>", "gg<S-V>G")

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

--map("n", "sh", ":split<CR><C-w>w") // not needed as these are taken care of by WhichKey
--map("n", "sv", ":vsplit<CR><C-w>w") -- not sure if I like this
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

-- Navigate to Prev/Next Location (Back/Forward)
-- map("n", "<C-h>", "<C-o>", opts)
-- map("n", "<C-l>", "<C-i>", opts)

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
map("v", "p", '"_dP', opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)

-- VISUAL BLOCK --
-- Move text up and down (sick as hell)
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation (allows easy window switching)
-- not sure if noremap = false is needed
map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
