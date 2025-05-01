return {
    {
        "dfendr/fenbox",
        -- dir = "~/Repos/Personal/fenbox/",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            if vim.env.SSH_CONNECTION or vim.env.SSH_CLIENT then
                vim.cmd("colorscheme retrobox")
            else
                require("fenvim.colorscheme.fenbox").config()
            end
        end,
    },
    { "Shatur/neovim-ayu" },
    { "EdenEast/nightfox.nvim" },
    {
        "xiyaowong/transparent.nvim",
        enabled = require("core.prefs").ui.transparent,
        config = require("fenvim.colorscheme.transparency").config(),
    },
    {
        "f-person/auto-dark-mode.nvim",
        enabled = false,
        opts = {
            update_interval = 1000,
            set_dark_mode = function()
                vim.api.nvim_set_option_value("background", "dark", {})
                vim.cmd("colorscheme fenbox")
            end,
            set_light_mode = function()
                vim.api.nvim_set_option_value("background", "light", {})
                vim.cmd("colorscheme ayu-light")
            end,
        },
    },
}
