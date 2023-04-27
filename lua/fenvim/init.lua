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
        -- Zen Mode/Focus. "Spotlight" effect on codie
        "folke/twilight.nvim",
        config = true,
        cmd = { "Zenmode", "Twilight" },
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
}
