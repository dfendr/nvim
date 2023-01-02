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
        config = function()
            require("fenvim.ui.bufferline").config()
        end,
    },
    {
        -- Keeps buffers and tabs scoped/separate
        "tiagovla/scope.nvim",
        event = "WinNew",
        config = true,
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

    -- {
    --     "j-hui/fidget.nvim",
    --     event = "BufReadPre",
    --     config = true,
    --     enabled = false,
    -- },

    {
        -- noicer ui
        "folke/noice.nvim",
        event = "VeryLazy",
        enabled = true,
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
        "petertriho/nvim-scrollbar",
        event = "BufReadPost",
        config = function()
            require("fenvim.ui.scrollbar").config()
        end,
    },
}
