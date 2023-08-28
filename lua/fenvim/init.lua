return {
    {
        -- Document Generator
        "danymat/neogen",
        event = "VeryLazy",
        config = function()
            require("neogen").setup({})
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
        version = "*",
    },
    {
        -- Zen Mode/Focus. "Spotlight" effect on code
        "folke/twilight.nvim",
        config = true,
        enabled = true,
        cmd = { "Twilight" },
    },
    {
        -- Rust Cargo package version checker
        "saecki/crates.nvim",
        version = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = { "toml", "rust", "rs" },
        config = function()
            require("crates").setup({
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
                popup = {
                    border = require("core.prefs").ui.border_style,
                },
            })
        end,
    },
    {
        "mrshmllow/open-handlers.nvim",
        -- We modify builtin functions, so be careful lazy loading
        lazy = false,
        cond = vim.ui.open ~= nil,
        config = function()
            local oh = require("open-handlers")
            oh.setup({
                -- In order, each handler is tried.
                -- The first handler to successfully open will be used.
                handlers = {
                    oh.issue, -- A builtin which handles github and gitlab issues
                    oh.commit, -- A builtin which handles git commits
                    oh.native, -- Default native handler. Should always be last
                },
            })
        end,
    },
    {
        "postfen/trozo.nvim",
        enabled = true,
        config = true,
        cmd = { "TrozoUploadSelection", "TrozoUploadFile" },
    },
}
