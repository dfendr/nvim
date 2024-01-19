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
                { "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth" },
                { "First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth", "Tenth" },
            },
        },
    },
    {
        -- dots in indents for easy space counting
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
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
        cmd = "ToggleMarkdownPreview",
        ft = { "markdown" },
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
        -- Improved Undo
        "kevinhwang91/nvim-fundo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require("fundo").install()
            vim.o.undofile = true
            require("fundo").setup()
        end,
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
        config = function()
            require("bigfile").setup({
                filesize = 2,
                -- detect long python files
                pattern = function(bufnr, filesize_mib)
                    -- you can't use `nvim_buf_line_count` because this runs on BufReadPre
                    local file_contents = vim.fn.readfile(vim.api.nvim_buf_get_name(bufnr))
                    local file_length = #file_contents
                    local filetype = vim.filetype.match({ buf = bufnr })
                    if filetype == "dbout" then
                        return true
                    end
                end,
                features = { -- features to disable
                    "indent_blankline",
                    "illuminate",
                    "lsp",
                    "treesitter",
                    "syntax",
                    "matchparen",
                    "vimopts",
                    "filetype",
                },
            })
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            require("fenvim.editor.ufo").config()
        end,
    },
    {

        "chrishrb/gx.nvim",
        event = { "BufEnter" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true, -- default settings
    },
    {
        "chrisgrieser/nvim-scissors",
        requires = "nvim-telescope/telescope.nvim", -- optional dependency
        config = function()
            local map = require("utils.functions").map

            -- Set key mappings for scissors plugin using custom map function
            map("n", "<leader>aS", "<cmd>lua require('scissors').editSnippet()<CR>", {}, "Edit Snippet")
            map("x", "<leader>as", "<cmd>lua require('scissors').addNewSnippet()<CR>", {}, "Add New Snippet")

            require("scissors").setup({
                snippetDir = require("utils.functions").get_snippet_path(),
                editSnippetPopup = {
                    height = 0.4, -- relative to the window, number between 0 and 1
                    width = 0.6,
                    border = require("core.prefs").ui.border_style,
                    keymaps = {
                        cancel = "q",
                        saveChanges = "<CR>", -- alternatively, can also use `:w`
                        goBackToSearch = "<BS>",
                        deleteSnippet = "<C-x>",
                        duplicateSnippet = "<C-d>",
                        openInFile = "<C-o>",
                        insertNextToken = "<C-t>", -- insert & normal mode
                        jumpBetweenBodyAndPrefix = "<Tab>", -- insert & normal mode
                    },
                },
                telescope = {
                    -- By default, the query only searches snippet prefixes. Set this to
                    -- `true` to also search the body of the snippets.
                    alsoSearchSnippetBody = false,
                },
                -- `none` writes as a minified json file using `vim.encode.json`.
                -- `yq`/`jq` ensure formatted & sorted json files, which is relevant when
                -- you version control your snippets.
                jsonFormatter = "none", -- "yq"|"jq"|"none"
            })
        end,
    },
}
