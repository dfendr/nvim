local ui_settings = require("core.prefs").ui

return {
    -- "MunifTanjim/nui.nvim",
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = true,
    },
    {
        "Bekaboo/dropbar.nvim",
        -- optional, but required for fuzzy finder support
        enabled = require("core.prefs").ui.breadcrumbs,
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
        },
    },
    {
        -- bufferline
        "akinsho/nvim-bufferline.lua",
        -- commit = "eb4e95b",
        enabled = true,
        event = "BufAdd",
        -- Keeps buffers and tabs scoped/separate
        dependencies = { "tiagovla/scope.nvim", config = true },
        config = function()
            require("fenvim.ui.bufferline").config()
        end,
    },
    {
        -- statusline
        "nvim-lualine/lualine.nvim",
        enabled = true,
        dependencies = { "meuter/lualine-so-fancy.nvim" },
        config = function()
            require("fenvim.ui.lualine").config()
        end,
    },
    {
        -- dashboard
        "goolord/alpha-nvim",
        lazy = false,
        enabled = true,
        priority = 100,
        config = function()
            require("fenvim.ui.alpha").config()
        end,
    },
    { -- incremental renaming, see renames in all instances of variable, live.
        "smjonas/inc-rename.nvim",
        enabled = false,
        config = true,
    },
    {
        -- Cute UI widget for LSP loading
        "j-hui/fidget.nvim",
        event = "BufReadPost",
        config = function()
            require("fenvim.ui.fidget").config()
        end,
        enabled = true,
    },

    {
        -- auto resizing windows
        "anuvyklack/windows.nvim",
        dependencies = { "anuvyklack/middleclass" },
        event = "WinNew",
        config = true,
        opts = { ignore = {
            filetype = { "Outline" },
        } },
    },
    {
        -- Scrollbar on the side, helpful for diagnostics
        "petertriho/nvim-scrollbar",
        event = "BufReadPost",
        enabled = true,
        config = function()
            require("fenvim.ui.scrollbar").config()
        end,
    },
    {
        "aznhe21/actions-preview.nvim",
        config = function()
            require("fenvim.ui.actions-preview").config()
        end,
    },
    {
        "lukas-reineke/headlines.nvim",
        ft = { "markdown", "orgmode", "neorg" },
        config = true,
    },
}
