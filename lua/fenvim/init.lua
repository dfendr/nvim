return {
    {
        "danymat/neogen",
        event = "VeryLazy",
        config = function()
            require("neogen").setup({})
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
        version = "*",
    },
    {

        "folke/twilight.nvim",
        config = true,
        cmd = { "Zenmode", "Twilight" },
    },
    {
        "saecki/crates.nvim",
        version = "v0.3.0",
        dependencies = { "nvim-lua/plenary.nvim" },
        ft = { "toml", "rust", "rs" },
        config = function()
            require("crates").setup()
        end,
    },

}
