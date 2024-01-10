vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

local status_ok, rusttools = pcall(require, "clangd_extensions")
if not status_ok then
    print("clangd_extensions not installed!")
    return
end

require("clangd_extensions.inlay_hints").setup_autocmd()
require("clangd_extensions.inlay_hints").set_inlay_hints()
