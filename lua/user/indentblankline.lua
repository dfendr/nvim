vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"


local status_ok, indentblankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

indentblankline.setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = false,
    show_current_context_start = true,
    space_char_blankline = " ",
}
