local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
    checker = { enabled = false },
    diff = { cmd = "diffview.nvim" },
    ui = { border = require("core.prefs").ui.border_style },
    change_detection = { enabled = false },
    rocks = { enabled = false },
})
