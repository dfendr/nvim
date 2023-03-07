local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = 0, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
vim.cmd("setlocal shiftwidth=2")
vim.cmd("setlocal tabstop=2")
vim.cmd("setlocal scrolloff=10")

local mappings = {
    L = {
        name = "Markdown",
        l = { "<cmd>!md2pdf %:p<cr>", "Comvert to Latex" },
        p = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview On/Off" },
        P = { "<cmd>PasteImg<cr>", "Paste Image" },
        s = { "<cmd>lua _SLIDES_TOGGLE()<cr>", "Preview Slides" },
    },
}
which_key.register(mappings, opts)
local opts = { noremap = true, silent = true }

-- Shorten function name
-- map(mode, key, cmd, options) = (vim.api.nvim_set_keymap(mode, key, cmd, options)
local map = require("utils").map

-- Remap space as leader key
--map("", "<Space>", "<Nop>", opts)
map("i", "<m-p>", "<cmd>PasteImg<Cr>", opts) -- ??

-- vim.cmd[[set formatoptions+=r]]
-- vim.cmd[[set comments-=fb:-]]
-- vim.cmd[[set comments+=:-]]
