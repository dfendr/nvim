local M = {}

function M.config()
    vim.opt.list = true
    local status_ok, indentblankline = pcall(require, "indent_blankline")
    if not status_ok then
        return
    end

    vim.api.nvim_create_autocmd("BufEnter", {

        group = vim.api.nvim_create_augroup("IndentBlanklineBigFile", {}),
        pattern = "*",
        callback = function()
            if vim.api.nvim_buf_line_count(0) > 2000 then
                require("indent_blankline.commands").disable()
            end
        end,
    })

    indentblankline.setup({
        -- for example, context is off by default, use this to turn it on
        show_current_context = false,
        show_current_context_start = false,
        space_char_blankline = "⋅",
        filetype_exclude = {
            "help",
            "Trouble",
            "alpha",
            "NvimTree",
        },
    })
end
return M
