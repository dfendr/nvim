return {
    "ellisonleao/gruvbox.nvim",
    {
        "postfen/gruvbox-baby",
        lazy = false,
        priority = 1000,
        config = function()
            require("fenvim.colorscheme.gruvbox-baby").config()
        end,
    },
}
