vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.textwidth = 79
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2

------------------------------------------------------ [[ConvertToLatexPDF]]
-- pandox required
function ConvertToLatex()
    local path = vim.fn.expand("%:p")
    local dir = vim.fn.expand("%:p:h")
    local base_name = vim.fn.fnamemodify(path, ":r")
    local quoted_path = vim.fn.shellescape(path)
    local quoted_pdf_path = vim.fn.shellescape(base_name .. ".pdf")

    local command = string.format('cd "%s" && pandoc %s -o %s -V geometry:margin=1in', dir, quoted_path, quoted_pdf_path)

    -- Capture the output of the pandoc command for error reporting
    local result = vim.fn.system(command)

    if vim.v.shell_error == 0 then
        vim.notify("Conversion Success", vim.log.levels.INFO)
    else
        vim.notify("Conversion Failure: " .. result, vim.log.levels.ERROR)
    end
end

------------------------------------------------------ [[ConvertToWordDoc]]
-- pandoc required
function ConvertToWordDoc()
    local path = vim.fn.expand("%:p")
    local dir = vim.fn.expand("%:p:h")
    local base_name = vim.fn.fnamemodify(path, ":r")
    local quoted_path = vim.fn.shellescape(path)
    local quoted_docx_path = vim.fn.shellescape(base_name .. ".docx")

    local command = string.format('cd "%s" && pandoc %s -o %s', dir, quoted_path, quoted_docx_path)

    -- Capture the output of the pandoc command for error reporting
    local result = vim.fn.system(command)

    if vim.v.shell_error == 0 then
        vim.notify("Conversion Success", vim.log.levels.INFO)
    else
        vim.notify("Conversion Failure: " .. result, vim.log.levels.ERROR)
    end
end
------------------------------------------------------

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    which_key.add({
    { "<localleader>", buffer = 0, group = "Markdown", nowait = true, remap = false },
    { "<localleader>P", "<cmd>PasteImage<cr>", buffer = 0, desc = "Paste Image", nowait = true, remap = false },
    { "<localleader>d", "<cmd>lua ConvertToWordDoc()<cr>", buffer = 0, desc = "Convert Buffer to Word Doc", nowait = true, remap = false },
    { "<localleader>i", "<cmd>GuessIndent<cr>", buffer = 0, desc = "Guess Indent", nowait = true, remap = false },
    { "<localleader>l", "<cmd>lua ConvertToLatex()<cr>", buffer = 0, desc = "Convert Buffer to Latex", nowait = true, remap = false },
    { "<localleader>p", "<cmd>PeekOpen<cr>", buffer = 0, desc = "Markdown Preview On/Off", nowait = true, remap = false },
    { "<localleader>s", "<cmd>lua _SLIDES_TOGGLE()<cr>", buffer = 0, desc = "Preview Slides", nowait = true, remap = false },
    })
end

local opts = { noremap = true, silent = true }

local map = require("core.functions").map
map("n", "<C-,>", "1z=", opts, "Correct Spelling") -- change spelling error to first suggestion
map("i", "<m-p>", "<cmd>PasteImage<Cr>", opts, "Paste Image")
