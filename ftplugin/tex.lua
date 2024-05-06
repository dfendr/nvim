vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.textwidth = 79
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
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
        name = "VimTeX",
        p = { "<cmd>VimtexCompile<cr>", "Compile and Preview" },
        i = { "<cmd>VimtexInfo<cr>", "VimTeX Info" },
        t = { "<cmd>VimtexTocToggle<cr>", "Toggle ToC" },
        v = { "<cmd>VimtexView<cr>", "View PDF" },
        r = { "<cmd>VimtexReload<cr>", "Reload" },
        s = { "<cmd>VimtexStop<cr>", "Stop Compilation" },
        e = { "<cmd>VimtexErrors<cr>", "Show Errors" },
        l = { "<cmd>VimtexClean<cr>", "Clean Auxiliary Files" },
        P = { "<cmd>PasteImage<cr>", "Paste Image" },
    }

    which_key.register(mappings, opts)

    local opts = { noremap = true, silent = true }
    local map = require("core.functions").map

    map("i", "<m-p>", "<cmd>PasteImage<Cr>", opts)
end
