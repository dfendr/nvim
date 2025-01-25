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
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        ft = { "md", "tex" },
    },
    {
        -- Git Diff viewer
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        config = true,
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
        tag = "stable",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufRead Cargo.toml" },
        config = function()
            require("crates").setup({
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
        "dfendr/trozo.nvim",
        enabled = true,
        opts = { clipboard = true, browser = true },
        cmd = { "TrozoUploadSelection", "TrozoUploadFile" },
        keys = function()
            local map = require("core.functions").map

            -- Set key mappings for scissors plugin using custom map function
            map("x", "<leader>ac", "<cmd>TrozoUploadSelection<CR>", {}, "Upload Code Selection")
            map("x", "<leader>aC", "<cmd>TrozoUploadFile<CR>", {}, "Upload Code File")
        end,
    },
    {
        "tpope/vim-dadbod",
        dependencies = {
            { "kristijanhusak/vim-dadbod-completion" },
            {
                "kristijanhusak/vim-dadbod-ui",
                config = function()
                    vim.g.db_ui_force_echo_notifications = 1
                end,
            },
        },
        cmd = { "DBUI", "DBUIToggle" },
    },
    {
        "NStefan002/screenkey.nvim",
        cmd = "Screenkey",
        config = true,
        opts = { win_opts = { border = require("core.prefs").ui.border_style } },
    },
}
