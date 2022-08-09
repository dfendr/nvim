local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
--keymap("n", "<C-h>", "<C-w>h", opts)
--keymap("n", "<C-j>", "<C-w>j", opts)
--keymap("n", "<C-k>", "<C-w>k", opts)
--keymap("n", "<C-l>", "<C-w>l", opts)

-- Explorer
 keymap('n', '<Leader>e', ":lua require'lv-nvimtree'.toggle_tree()<CR>", {noremap = true, silent = true})

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
--keymap("n", "<S-l>", ":bnext<CR>", opts)
--keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Navigate Lines
keymap("n", "<S-l>", "$", opts)
keymap("n", "<S-h>", "^", opts)

-- Navigate to Prev/Next Location (Back/Forward)
keymap("n", "<C-h>", "<C-o>", opts)
keymap("n", "<C-l>", "<C-i>", opts)

-- Tabs --
keymap("n", "<m-t>", ":tabnew %<cr>", opts)

--Alternate ways to save
--keymap("n", "<C-s>", ":w <bar> :Format<CR>", opts)
keymap("n", "<leader> s", ":w<CR>", opts)

--Alternate ways to quit
keymap("n", "<C-q>", ":wq!", opts)
keymap("n", "<leader>q", ":q", opts)

-- Insert --
-- Press jk fast to enter
--keymap("i", "jk", "<ESC>", opts) -- Not needed with caps lock being routed to ESC

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope
keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

--Tree Sitter
keymap("n", "<leader>c", "<cmd>TSHighlightCapturesUnderCursor<cr>", opts)

-- Nvimtree
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)
