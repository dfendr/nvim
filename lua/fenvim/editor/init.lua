local using_neovide = false
if vim.g.neovide then
    using_neovide = true
end

return {
    {
        -- Auto bracket pairs
        "windwp/nvim-autopairs",
        event = "BufReadPost",
        config = function()
            require("fenvim.editor.autopairs").config()
        end,
    },
    {
        -- Text alignment
        "echasnovski/mini.align",
        branch = "stable",
        event = "BufReadPost",
        config = function()
            require("fenvim.editor.align").config()
        end,
    },
    {
        -- True/False toggler
        "nat-418/boole.nvim",
        event = "BufReadPost",
        opts = {
            mappings = {
                increment = "<C-a>",
                decrement = "<C-x>",
            },
            -- User defined loops ()
            additions = {
                { "Foo", "Bar" },
                { "tic", "tac", "toe" },
            },
        },
    },
    {
        -- dots in indents for easy space counting
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        config = function()
            require("fenvim.editor.indent-blankline").config()
        end,
    },
    {
        -- Automatically change tabstop to match doc
        "nmac427/guess-indent.nvim",
        event = "BufReadPre",
        config = true,
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("fenvim.editor.toggleterm").config()
        end,
    },
    {
        "CRAG666/code_runner.nvim",
        event = "VeryLazy",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("fenvim.editor.coderunner").config()
        end,
    },

    {
        "is0n/jaq-nvim",
        event = "VeryLazy",
        enabled = false,
        config = function()
            require("fenvim.editor.jaq").config()
        end,
    },
    {
        "gbprod/yanky.nvim",
        event = "BufReadPost",
        dependencies = {
            "kkharji/sqlite.lua",
        },
        enabled = function()
            return not jit.os:find("Windows")
        end,
        config = function()
            require("fenvim.editor.yanky").config()
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "BufReadPost",
        cmd = { "TodoTrouble", "TodoTelescope" },
        keys = {
            {
                "]t",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "Next todo comment",
            },
            {
                "[t",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "Previous todo comment",
            },
        },
        config = function()
            require("fenvim.editor.todo-comments").config()
        end,
    },
    {
        "gaoDean/autolist.nvim",
        ft = {
            "markdown",
            "text",
            "tex",
            "plaintex",
        },
        event = "BufReadPost",
        enabled = false,
        config = function()
            require("fenvim.editor.autolist").config()
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
        config = function()
            require("fenvim.editor.trouble").config()
        end,
    },
    {
        "kylechui/nvim-surround",
        config = true,
        event = "BufReadPost",
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = true,
        ft = { "typescript", "html", "tsx", "vue", "svelte", "php", "rescript" },
    },
    {
        -- Hex editor
        "RaafatTurki/hex.nvim",
        config = true,
        event = "VeryLazy",
        enabled = true,
    },

    {
        "simrat39/symbols-outline.nvim",
        config = true,
        opts = { relative_width = true, width = 10 },
        cmd = "SymbolsOutline",
    },
    {
        -- Big files over 2mb activate BigFile mode, disabling some plugins.
        "LunarVim/bigfile.nvim",
        enabled = true,
        config = true,
    },
}
