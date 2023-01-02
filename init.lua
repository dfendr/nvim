----------------------------------------------[[ Bootstrap Lazy ]]

require("utils/lazy_bootstrap") -- bootstraps folke/lazy

----------------------------------------------[[  User Settings ]]

require("config") -- loads lua/user/init.lua
-- require("user.options")          -- loads lua/user/options.lua
-- require("user.keymaps")             -- etc.

----------------------------------------------[[  Load Plugins  ]]

require("lazy").setup("fenvim", {
    checker = { enabled = false },
    diff = { cmd = "diffview.nvim" },
    ui = { border = "rounded" },
})

if vim.g.neovide then
    require("user.neovide")
end
