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
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
-- vim.wo.scrolloff = 10 -- sets globally
vim.opt_local.textwidth = 79
vim.opt_local.spell = true
vim.opt_local.conceallevel = 3



local mappings = {
    L = {
        name = "Markdown",
        l = { "<cmd>lua ConvertToLatex()<cr>", "Convert Buffer to Latex" },
        p = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview On/Off" },
        P = { "<cmd>PasteImg<cr>", "Paste Image" },
        s = { "<cmd>lua _SLIDES_TOGGLE()<cr>", "Preview Slides" },
    },
}


------------------------------------------------------ [[ConvertToLatex]]
-- Shell script used for ConvertToLatex
-- Place in .bashrc, and make sure pandoc is installed.

-- md2pdf() {
-- 	v2=${1:0:-3}
-- 	pandoc "$1" -o "$v2".pdf -V geometry:margin=1in
-- }

function ConvertToLatex()
    local path = vim.fn.expand("%:p")
    local quoted_path = vim.fn.shellescape(path)
    vim.fn.system("md2pdf " .. quoted_path)
    if vim.v.shell_error == 0 then
        vim.notify("Conversion Success", vim.log.levels.INFO)
    else
        vim.notify("Conversion Failure", vim.log.levels.ERROR)
    end
end
------------------------------------------------------

which_key.register(mappings, opts)

opts = { noremap = true, silent = true }

-- Shorten function name
-- map(mode, key, cmd, options) = (vim.api.nvim_set_keymap(mode, key, cmd, options)
local map = require("utils").map

map("i", "<m-p>", "<cmd>PasteImg<Cr>", opts) -- ??
map("n", "<C-,>", "1z=", opts) -- ??
