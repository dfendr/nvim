return {
    "ellisonleao/gruvbox.nvim",
    {
        "postfen/gruvbox-baby",
        lazy = false,
        priority = 1000,
        config = function()
            require("fenvim.colorscheme.gruvbox-baby").config()
            -- require("fenvim.colorscheme.gruvbox").config()
        end,
    },

    -- bufferline
}

-- require("user.colorscheme.ayu")
-- require("user.colorscheme.gruvbox-material")
-- require("user.colorscheme.nightfox")
