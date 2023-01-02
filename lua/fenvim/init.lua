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
        "LintaoAmons/scratch.nvim",
        cmd = "Scratch",
        config = true,
    },
}
