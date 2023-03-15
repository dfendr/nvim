----------------------------------------------[[ Bootstrap Lazy ]]

require("utils/lazy_bootstrap") -- bootstraps folke/lazy

----------------------------------------------[[  User Settings ]]

require("config") -- loads lua/user/init.lua

----------------------------------------------[[  Load Plugins  ]]

require("lazy").setup("fenvim", {
    checker = { enabled = false },
    diff = { cmd = "diffview.nvim" },
    ui = { border = "rounded" },
    change_detection = { enabled = false },
})

if vim.g.neovide then
    require("fenvim.ui.neovide")
end
