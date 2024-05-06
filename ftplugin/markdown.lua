vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.textwidth = 79
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2

------------------------------------------------------ [[ConvertToLatex]]
-- pandox required
function ConvertToLatex()
    local path = vim.fn.expand("%:p")
    local dir = vim.fn.expand("%:p:h")
    local base_name = vim.fn.fnamemodify(path, ":r")
    local quoted_path = vim.fn.shellescape(path)
    local quoted_pdf_path = vim.fn.shellescape(base_name .. ".pdf")
    vim.fn.system(
        "cd " .. dir .. " && pandoc " .. quoted_path .. " -o " .. quoted_pdf_path .. " -V geometry:margin=1in"
    )
    if vim.v.shell_error == 0 then
        vim.notify("Conversion Success", vim.log.levels.INFO)
    else
        vim.notify("Conversion Failure", vim.log.levels.ERROR)
    end
end
------------------------------------------------------

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<localleader>",
        buffer = 0, -- Local Buffer
        silent = true,
        noremap = true,
        nowait = true,
    }

    local mappings = {
        name = "Markdown",
        l = { "<cmd>lua ConvertToLatex()<cr>", "Convert Buffer to Latex" },
        p = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown Preview On/Off" },
        P = { "<cmd>PasteImage<cr>", "Paste Image" },
        s = { "<cmd>lua _SLIDES_TOGGLE()<cr>", "Preview Slides" },
    }

    which_key.register(mappings, opts)
end

local opts = { noremap = true, silent = true }

local map = require("core.functions").map
map("n", "<C-,>", "1z=", opts, "Correct Spelling") -- change spelling error to first suggestion
map("i", "<m-p>", "<cmd>PasteImage<Cr>", opts, "Paste Image")
