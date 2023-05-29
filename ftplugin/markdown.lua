local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = 0, -- Local Buffer
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
vim.cmd("setlocal shiftwidth=2")
vim.cmd("setlocal tabstop=2")
-- vim.cmd("set scrolloff=10")
vim.cmd("setlocal tw=79")
vim.cmd("setlocal spell")
vim.cmd("setlocal conceallevel=3")

local mappings = {
    L = {
        name = "Markdown",
        l = { "<cmd>lua ConvertToLatex()<cr>", "Convert to Latex" },
        p = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview On/Off" },
        P = { "<cmd>PasteImg<cr>", "Paste Image" },
        s = { "<cmd>lua _SLIDES_TOGGLE()<cr>", "Preview Slides" },
    },
}

function ConvertToLatex()
    local path = vim.fn.expand("%:p")
    local quoted_path = vim.fn.shellescape(path)
    vim.cmd("!md2pdf " .. quoted_path)
end

which_key.register(mappings, opts)
local opts = { noremap = true, silent = true }

-- Shorten function name
-- map(mode, key, cmd, options) = (vim.api.nvim_set_keymap(mode, key, cmd, options)
local map = require("utils").map

map("i", "<m-p>", "<cmd>PasteImg<Cr>", opts) -- ??
map("n", "<C-,>", "1z=", opts) -- ??
