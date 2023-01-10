local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
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
        p = { "<cmd>MarkdownPreviewToggle<Cr>", "Markdown Preview On/Off" },
        P = { "<cmd>PasteImg<Cr>", "Paste Image" },
    },
}

-- vim.cmd[[set formatoptions+=r]]
-- vim.cmd[[set comments-=fb:-]]
-- vim.cmd[[set comments+=:-]]

which_key.register(mappings, opts)
