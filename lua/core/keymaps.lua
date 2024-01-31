-- Keybind function shortcut
local M = {}
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local f = require("core.functions")

function M.setup_keymaps()
    --NORMAL--

    -- Do not yank with x
    f.map("n", "x", '"_x', opts, "Yankless Character Delete")

    -- Select all
    f.map("n", "yA", ":0,$y<cr>", opts, "Select All")

    -- New Tab/Easy Splits
    -- Tabs --
    f.map("n", "<m-t>", ":tabnew %<cr>", opts, "New Tab")
    f.map("n", "te", ":tabedit<CR>", opts, "New Tab-Edit")
    f.map("n", "<leader><tab>", ":tabnext<cr>", opts, "Next Tab")
    f.map("n", "<leader><s-tab>", ":tabprev<cr>", opts, "Prev Tab")

    -- Easy Buffer Navigation, supports counts (e.g. 3]b moves to 3 buffers over)
    f.map("n", "[b", "<Cmd>execute 'bprevious' . v:count1<CR>", opts, "Previous Buffer")
    f.map("n", "]b", "<Cmd>execute 'bnext' . v:count1<CR>", opts, "Next Buffer")
    f.map("n", "<C-w> c", ":bdelete!<CR>", opts, "Delete Buffer")

    -- Explorer/Tree
    f.map("n", "<Leader>e", ":lua require'nvim-tree'.toggle()<CR>", opts, "Toggle Explorer")

    -- Resize with arrows
    f.map("n", "<M-Up>", ":resize +2<CR>", opts, "Increase Horizontal Size")
    f.map("n", "<M-Down>", ":resize -2<CR>", opts, "Decrease Horizontal Size")
    f.map("n", "<M-Right>", ":vertical resize +2<CR>", opts, "Increase Vertical Size")
    f.map("n", "<M-Left>", ":vertical resize -2<CR>", opts, "Decrease Vertical Size")

    f.map("n", "<C-l>", "$", opts, "Move to end of line")
    f.map("n", "<C-h>", "^", opts, "Move to begining of line")
    f.map("v", "<C-l>", "$", opts, "Move to end of line")
    f.map("v", "<C-h>", "^", opts, "Move to begining of line")

    f.map("n", "<leader><leader>", ":nohl<cr>", opts, "Clear Highlighting")

    -- VISUAL --
    -- Stay in indent mode after indentation
    f.map("v", "<", "<gv", opts, "Indent Left")
    f.map("v", ">", ">gv", opts, "Indent Right")

    -- Move text up and down (sick as hell)
    f.map("x", "K", ":move '<-2<CR>gv-gv", opts, "Shift Text Up")
    f.map("x", "J", ":move '>+1<CR>gv-gv", opts, "Shift Text Down")

    -- Paste without putting overwritten text in clipboard
    f.map("x", "p", '"_dP', opts, "Noncopying Paste")

    -- keybinding to delete blank lines in visual selection
    f.map("x", "<Space>on", ":s/^$\\n//g<CR>", opts, "Delete blank lines in visual selection")
    f.map("x", "<Space>ow", ":s/\\%V\\s\\+//g<CR>", opts, "Delete all whitespace in visual selection")

    -- Terminal --
    -- Better terminal navigation (allows easy window switching)
    f.map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
    f.map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
    f.map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
    f.map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
end

return M
