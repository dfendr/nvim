vim.g.maplocalleader = ","

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
vim.cmd("setlocal scrolloff=10")
vim.cmd(":setlocal tw=80")

local mappings = {
    L = {
        name = "Neorg",
        e = { "<cmd>Neorg export<cr>", "Convert to Latex" },
        -- p = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview On/Off" },
        -- P = { "<cmd>PasteImg<cr>", "Paste Image" },
        -- s = { "<cmd>lua _SLIDES_TOGGLE()<cr>", "Preview Slides" },
    },
}

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = { noremap = true, silent = true }
which_key.register(mappings, opts)
