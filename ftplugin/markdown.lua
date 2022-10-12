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

local mappings = {
    L = {
        name = "Markdown",
        -- h = { "<cmd>RustToggleInlayHints<Cr>", "Toggle Hints" },
        p = { "<cmd>MarkdownPreviewToggle<Cr>", "Markdown Preview On/Off" },
    },
}

vim.cmd[[set formatoptions+=r]]
vim.cmd[[set comments-=fb:-]]
vim.cmd[[set comments+=:-]]


which_key.register(mappings, opts)
