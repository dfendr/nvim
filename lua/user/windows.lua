local status_ok, windows = pcall(require, "windows")
if not status_ok then
    return
end

vim.o.winwidth = 10
vim.o.winminwidth = 10
vim.o.equalalways = false

windows.setup()
