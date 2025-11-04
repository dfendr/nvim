----------------------------------------------[[ Bootstrap Lazy ]]

require("startup.lazy")

----------------------------------------------[[  User Settings ]]

require("core")

----------------------------------------------[[  Load Plugins  ]]

require("lazy").setup("plugins", {
    checker = { enabled = false },
    diff = { cmd = "diffview.nvim" },
    ui = { border = require("core.prefs").ui.border_style },
    change_detection = { enabled = false },
})

if vim.g.neovide then
    require("plugins.ui.neovide")
end
