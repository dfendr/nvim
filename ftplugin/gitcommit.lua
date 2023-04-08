
vim.cmd("setlocal spell")

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = 0, -- Local Buffer
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

-- Shorten function name
-- map(mode, key, cmd, options) = (vim.api.nvim_set_keymap(mode, key, cmd, options)
local map = require("utils").map

-- Remap space as leader key
--map("", "<Space>", "<Nop>", opts)
map("n", "<C-,>", "1z=", opts) -- Shortcut to autocorrection for spelling
