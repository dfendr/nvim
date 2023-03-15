return {
    -- "MunifTanjim/nui.nvim",
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = true,
    },

    {
        -- bufferline
        "akinsho/nvim-bufferline.lua",
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
        config = function()
            require("fenvim.ui.lualine").config()
        end,
    },

    {
        -- dashboard
        "goolord/alpha-nvim",
        config = function()
            require("fenvim.ui.alpha").config()
        end,
    },

    {
        -- Cute UI widget for LSP loading
        "j-hui/fidget.nvim",
        event = "BufReadPre",
        config = function()
            require("fenvim.ui.fidget").config()
        end,
        enabled = true,
    },

    {
        -- noicer ui
        "folke/noice.nvim",
        event = "VeryLazy",
        enabled = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("fenvim.ui.noice").config()
        end,
    },
    {
        -- auto resizing windows
        "anuvyklack/windows.nvim",
        dependencies = { "anuvyklack/middleclass" },
        event = "WinNew",
        config = true,
    },
    {
        -- Scrollbar on the side, helpful for diagnostics
        "petertriho/nvim-scrollbar",
        event = "BufReadPost",
        config = function()
            require("fenvim.ui.scrollbar").config()
        end,
    },
}
