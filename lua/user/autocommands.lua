-- Turn off IndentBlankline for big files
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("IndentBlanklineBigFile", {}),
    pattern = "*",
    callback = function()
        if vim.api.nvim_buf_line_count(0) > 1000 then
            require("indent_blankline.commands").disable()
        end
    end,
})
