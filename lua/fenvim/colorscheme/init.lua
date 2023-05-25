return {
    { "rktjmp/lush.nvim" },
    {
        "xiyaowong/transparent.nvim",
        enabled = require("core.prefs").ui.transparent,
        config = require("fenvim.colorscheme.transparency"),
    },
    {
        "postfen/fenbox",
        branch = "sandbox",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("fenvim.colorscheme.fenbox").config()
        end,
    },
}
