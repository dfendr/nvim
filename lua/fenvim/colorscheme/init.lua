return {
    { "rktjmp/lush.nvim" },
    {
        "xiyaowong/transparent.nvim",
        enabled = true,
        config = function()
            require("transparent").setup({
                groups = { -- table: default groups
                    "Comment",
                    "Conditional",
                    "Constant",
                    "CursorLineNr",
                    "EndOfBuffer",
                    "FloatBorder",
                    "FloatShadow",
                    "Function",
                    "FidgetTitle",
                    "Identifier",
                    "LineNr",
                    "NoicePopup",
                    "NonText",
                    "Normal",
                    "NormalFloat",
                    "NormalNC",
                    "Operator",
                    "PreProc",
                    "Repeat",
                    "SignColumn",
                    "Special",
                    "Statement",
                    "String",
                    "Structure",
                    "Todo",
                    "Type",
                    "Underlined",
                },
                extra_groups = {}, -- table: additional groups that should be cleared
                exclude_groups = {}, -- table: groups you don't want to clear
            })
        end,
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
