----------------------------------------------[[ Bootstrap Lazy ]]

require("utils/lazy_bootstrap") -- bootstraps folke/lazy

----------------------------------------------[[  User Settings ]]

require("core")

----------------------------------------------[[  Load Plugins  ]]


require("lazy").setup("fenvim", {
    checker = { enabled = false },
    diff = { cmd = "diffview.nvim" },
    ui = { border = require("core.prefs").ui.border_style },
    change_detection = { enabled = false },
})

if vim.g.neovide then
    require("fenvim.ui.neovide")
end

-- TODO:
-- Fix Markdown/Rust autopairs (** and |)
-- Fix Zen Mode, no twilight mode, no numbers. "Reading/Notes" mode.

