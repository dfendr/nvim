-- Keybind function shortcut
local M = {}

-- TODO: Remove this or the one in util functions.
-- Alternatively move core functions to core folder.
local function map(mode, key, cmd, opts, desc)
    local options = {}
    if type(desc) == "table" then
        opts = vim.tbl_extend("force", opts, desc)
    else
        if type(desc) == "string" then
            options.desc = desc
        end
    end
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.api.nvim_set_keymap(mode, key, cmd, options)

    -- Check if whichkey is available and a description is provided
    if pcall(require, "which-key") and type(desc) == "string" then
        local whichkey = require("which-key")
        local wk_opts = {
            mode = mode, -- NORMAL, VISUAL, INSERT, etc.
            prefix = "",
            buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true, -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = true, -- use `nowait` when creating keymaps
        }
        local mappings = {
            [key] = { cmd, desc },
        }
        whichkey.register(mappings, wk_opts)
    end
end

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

function M.setup_keymaps()
    --NORMAL--

    -- Do not yank with x
    map("n", "x", '"_x', opts, "Yankless Character Delete")

    -- Select all
    map("n", "yA", ":0,$y<cr>", opts, "Select All")

    -- New Tab/Easy Splits
    -- Tabs --
    map("n", "<m-t>", ":tabnew %<cr>", opts, "New Tab")
    map("n", "te", ":tabedit<CR>", opts, "New Tab-Edit")
    map("n", "<leader><tab>", ":tabnext<cr>", opts, "Next Tab")
    map("n", "<leader><s-tab>", ":tabprev<cr>", opts, "Prev Tab")

    -- Easy Buffer Navigation
    map("n", "[b", ":bprevious<CR>", opts, "Previous Buffer")
    map("n", "]b", ":bnext<CR>", opts, "Next Buffer")
    map("n", "[t", ":tabprevious<CR>", opts, "Previous Tab")
    map("n", "]t", ":tabnext<CR>", opts, "Next Tab")
    map("n", "<C-w> c", ":bdelete!<CR>", opts, "Delete Buffer")

    -- Explorer/Tree
    map("n", "<Leader>e", ":lua require'nvim-tree'.toggle()<CR>", opts, "Toggle Explorer")

    -- Resize with arrows
    map("n", "<M-Up>", ":resize +2<CR>", opts, "Increase Horizontal Size")
    map("n", "<M-Down>", ":resize -2<CR>", opts, "Decrease Horizontal Size")
    map("n", "<M-Right>", ":vertical resize +2<CR>", opts, "Increase Vertical Size")
    map("n", "<M-Left>", ":vertical resize -2<CR>", opts, "Decrease Vertical Size")

    map("n", "<C-l>", "$", opts, "Move to end of line")
    map("n", "<C-h>", "^", opts, "Move to begining of line")
    map("v", "<C-l>", "$", opts, "Move to end of line")
    map("v", "<C-h>", "^", opts, "Move to begining of line")

    -- VISUAL --
    -- Stay in indent mode after indentation
    map("v", "<", "<gv", opts, "Indent Left")
    map("v", ">", ">gv", opts, "Indent Right")

    -- Move text up and down (sick as hell)
    map("x", "K", ":move '<-2<CR>gv-gv", opts, "Shift Text Up")
    map("x", "J", ":move '>+1<CR>gv-gv", opts, "Shift Text Down")

    -- Paste without putting overwritten text in clipboard
    map("x", "p", '"_dP', opts, "Noncopying Paste")

    -- keybinding to delete blank lines in visual selection
    map("x", "<Space>on", ":s/^$\\n//g<CR>", opts, "Delete blank lines in visual selection")
    map("x", "<Space>ow", ":s/\\%V\\s\\+//g<CR>", opts, "Delete all whitespace in visual selection")

    -- Terminal --
    -- Better terminal navigation (allows easy window switching)
    map("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
    map("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
    map("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
    map("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
end

return M
