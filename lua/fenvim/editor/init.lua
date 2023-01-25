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
        event = "VeryLazy",
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
        -- cmd = "lua require(fenvim.editor.venn).Toggle_venn()",
        -- event = "Buf"
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
        enabled = vim.loop.os_uname().sysname == 'Darwin',
    },
}
