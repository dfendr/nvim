return {
    {
        "postfen/fenbox",
        -- branch = "sandbox",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("fenvim.colorscheme.fenbox").config()
        end,
    },
    { "Shatur/neovim-ayu" },
    { "EdenEast/nightfox.nvim" },
    {
        "xiyaowong/transparent.nvim",
        enabled = require("core.prefs").ui.transparent,
        config = require("fenvim.colorscheme.transparency").config(),
    }
}
