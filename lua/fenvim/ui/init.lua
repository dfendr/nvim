local ui_settings = require("core.prefs").ui

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
    { -- incremental renaming, see renames in all instances of variable, live.
        "smjonas/inc-rename.nvim",
        enabled = false,
        config = true,
    },
    {
        -- Cute UI widget for LSP loading
        "j-hui/fidget.nvim",
        event = "BufReadPre",
        branch = "legacy",
        config = function()
            require("fenvim.ui.fidget").config()
        end,
        enabled = true,
    },

    {
        -- noicer ui
        "folke/noice.nvim",
        event = "VeryLazy",
        -- enabled = not vim.g.neovide,
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
}
