vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
--vim.opt.listchars:append "eol:↴"
--vim.opt.listchars:append "eol:﬌"
-- vim.opt.listchars:append tab:▷ ,trail:·,extends:◣,precedes:◢,nbsp:○
local status_ok, indentblankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("IndentBlanklineBigFile", {}),
    pattern = "*",
    callback = function()
        if vim.api.nvim_buf_line_count(0) > 1000 then
            require("indent_blankline.commands").disable()
        end
    end,
})



indentblankline.setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = false,
    space_char_blankline = " ",
    filetype_exclude = {
        "help",
        "Trouble",
        "alpha",
        "NvimTree",
    }
}
