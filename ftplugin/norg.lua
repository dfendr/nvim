vim.cmd("setlocal shiftwidth=2")
vim.cmd("setlocal tabstop=2")
vim.cmd("setlocal scrolloff=10")
vim.cmd(":setlocal tw=80")

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<localleader>",
        buffer = 0, -- Local Buffer
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }
    local mappings = {
        name = "Neorg",
        e = { "<cmd>Neorg export<cr>", "Convert to Latex" },
        -- p = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview On/Off" },
        -- P = { "<cmd>PasteImg<cr>", "Paste Image" },
        -- s = { "<cmd>lua _SLIDES_TOGGLE()<cr>", "Preview Slides" },
    }
    which_key.register(mappings, opts)
end
