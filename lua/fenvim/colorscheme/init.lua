return {
    { "rktjmp/lush.nvim" },
    {
        "postfen/fenbox",
        dependencies = {
            "ellisonleao/gruvbox.nvim",
        },
        branch = "sandbox",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("fenvim.colorscheme.fenbox").config()
        end,
    },
}
