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
        config = {
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
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        config = function()
            require("fenvim.editor.indent-blankline").config()
        end,
    },
    {
        "nmac427/guess-indent.nvim",
        event = "BufReadPre",
        config = true,
    },
    {
        "akinsho/toggleterm.nvim",
        -- cmd = { "ToggleTerm", "_GITUI_TOGGLE" },
        -- event = "BufReadPre",
        config = function()
            require("fenvim.editor.toggleterm").config()
        end,
    },
    {
        "is0n/jaq-nvim",
        event = "BufReadPost",
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
        event = "BufReadPre",
        config = function()
            require("fenvim.editor.todo-comments").config()
        end,
    },
    {
        "gaoDean/autolist.nvim",
        event = "BufReadPre",
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
        "jbyuki/venn.nvim", --TODO: Finish setting up Venn
        -- config = function()
        --     require("fenvim.editor.venn").config()
        -- end,
        -- cmd = "Toggle_venn",
    },
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
}
