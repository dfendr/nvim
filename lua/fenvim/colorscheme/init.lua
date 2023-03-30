return {
        "postfen/gruvbox-baby",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require("fenvim.colorscheme.gruvbox-baby").config()
    end,
}
