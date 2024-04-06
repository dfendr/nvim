
vim.cmd("setlocal spell")

local opts = {
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

-- Shorten function name
-- map(mode, key, cmd, options) = (vim.api.nvim_set_keymap(mode, key, cmd, options)
local map = require("core.functions").map

-- Remap space as leader key
map("n", "<C-,>", "1z=", opts, "Correct Spelling", 0) -- Shortcut to autocorrection for spelling
