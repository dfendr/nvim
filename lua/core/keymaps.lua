-- Keybind function shortcut
local M = {}

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

local map = require("core.functions").map

function M.setup_keymaps()
    local opts = { noremap = true, silent = true }
    -- NORMAL --
    map("n", "x", '"_x', opts, "Yankless Character Delete")
    map("n", "yA", ":0,$y<cr>", opts, "Select All")

    -- Tabs
    map("n", "<m-t>", ":tabnew %<cr>", opts, "New Tab")
    map("n", "te", ":tabedit<CR>", opts, "New Tab-Edit")
    map("n", "<leader><tab>", ":tabnext<cr>", opts, "Next Tab")
    map("n", "<leader><s-tab>", ":tabprev<cr>", opts, "Prev Tab")

    -- Buffers
    map("n", "[b", "<Cmd>execute 'bprevious' . v:count1<CR>", opts, "Previous Buffer")
    map("n", "]b", "<Cmd>execute 'bnext' . v:count1<CR>", opts, "Next Buffer")
    map("n", "<C-w> c", ":bdelete!<CR>", opts, "Delete Buffer")

    -- Explorer
    map("n", "<Leader>e", "<cmd>Neotree toggle<cr>", opts, "Toggle Explorer")

    -- Resize
    map("n", "<M-Up>", ":resize +2<CR>", opts, "Increase Horizontal Size")
    map("n", "<M-Down>", ":resize -2<CR>", opts, "Decrease Horizontal Size")
    map("n", "<M-Right>", ":vertical resize +2<CR>", opts, "Increase Vertical Size")
    map("n", "<M-Left>", ":vertical resize -2<CR>", opts, "Decrease Vertical Size")

    map("n", "<C-l>", "$", opts, "Move to end of line")
    map("n", "<C-h>", "^", opts, "Move to beginning of line")

    map("n", "<leader><leader>", ":nohl<cr>", opts, "Clear Highlighting")
    map("n", "<C-,>", "1z=", opts, "Fix Spelling")

    -- VISUAL --
    map("v", "<", "<gv", opts, "Indent Left")
    map("v", ">", ">gv", opts, "Indent Right")
    map("v", "<C-l>", "$", opts, "Move to end of line")
    map("v", "<C-h>", "^", opts, "Move to beginning of line")

    map("x", "K", ":move '<-2<CR>gv-gv", opts, "Shift Text Up")
    map("x", "J", ":move '>+1<CR>gv-gv", opts, "Shift Text Down")
    map("x", "p", '"_dP', opts, "Noncopying Paste")
    map("x", "<Space>on", ":s/^$\\n//g<CR>", opts, "Delete Blank Lines")
    map("x", "<Space>ow", ":s/\\%V\\s\\+//g<CR>", opts, "Delete Whitespace")

    -- TERMINAL --
    local term_opts = { silent = true }
    map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
    map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
    map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
    map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
end

return M
