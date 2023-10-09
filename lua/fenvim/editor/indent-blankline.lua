local M = {}

function M.config()
    vim.opt.list = true
    --     vim.api.nvim_create_autocmd("BufEnter", {
    --
    --         group = vim.api.nvim_create_augroup("IndentBlanklineBigFile", {}),
    --         pattern = "*",
    --         callback = function()
    --             if vim.api.nvim_buf_line_count(0) > 2000 then
    --                 require("indent_blankline.commands").disable()
    --             end
    --         end,
    --     })
    require("ibl").setup({
        indent = {
            char = "│",
        },
    })
end
return M
