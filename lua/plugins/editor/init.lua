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
            require("plugins.editor.autopairs").config()
        end,
    },
    { "folke/neoconf.nvim" },
    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },
    {
        -- Text alignment
        "echasnovski/mini.align",
        branch = "stable",
        event = "BufReadPost",
        config = function()
            require("plugins.editor.align").config()
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
            allow_caps_additions = {
                { "after", "before" },
                { "I", "II", "III", "IV", "V", "VI", "VII", "VII", "VIII", "IX", "X" },
                { "back", "forward" },
                { "north", "east", "south", "west" },
                { "enter", "exit" },
                { "entering", "exiting" },
                { "upload", "download" },
                { "input", "output" },
                { "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth" },
                { "high", "low" },
                { "relative", "absolute" },
                { "continuous", "discrete" },
                { "before", "after" },
                { "pass", "fail" },
                {
                    "alpha",
                    "beta",
                    "gamma",
                    "delta",
                    "epsilon",
                    "zeta",
                    "eta",
                    "theta",
                    "iota",
                    "kappa",
                    "lambda",
                    "mu",
                    "nu",
                    "xi",
                    "omicron",
                    "pi",
                    "rho",
                    "sigma",
                    "tau",
                    "upsilon",
                    "phi",
                    "chi",
                    "psi",
                    "omega",
                },
                { "lower", "higher" },
                { "major", "minor" },
                { "min", "max" },
                { "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten" },
                { "over", "under" },
                { "right", "left" },
                { "start", "stop" },
                { "starts", "stops" },
                { "tac", "tac", "toe" },
                { "up", "down" },
                { "activated", "deactivated" },
            },
        },
    },
    {
        -- dots in indents for easy space counting
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufReadPost",
        config = function()
            require("plugins.editor.indent-blankline").config()
        end,
    },
    {
        -- Automatically change tabstop to match doc
        "nmac427/guess-indent.nvim",
        event = "BufReadPost",
        config = true,
        opts = {
            filetype_exclude = {
                "netrw",
                "tutor",
            },
        },
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("plugins.editor.toggleterm").config()
        end,
    },
    {
        "CRAG666/code_runner.nvim",
        event = "VeryLazy",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("plugins.editor.coderunner").config()
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
            require("plugins.editor.todo-comments").config()
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
        config = function()
            require("plugins.editor.trouble").config()
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
        "toppair/peek.nvim",
        event = { "VeryLazy" },
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
        end,
        cmd = "PeekOpen",
        enabled = true,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = true, -- Auto close on trailing </
                },
            })
        end,
        ft = { "typescript", "html", "typescriptreact", "vue", "svelte", "php", "rescript" },
    },

    {
        "HiPhish/rainbow-delimiters.nvim",
        event = "BufReadPost",
        config = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    -- lua = "rainbow-blocks",
                },
                highlight = {
                    "TSRainbowMagenta",
                    "TSRainbowGray",
                    "TSRainbowCyan",
                    "TSRainbowYellow",
                    "TSRainbowOrange",
                    "TSRainbowPink",
                    "TSRainbowGreen",
                },
            }
        end,
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
            -- default config
            require("bigfile").setup({
                filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
                pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
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
            require("plugins.editor.ufo").config()
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
        dependencies = "nvim-telescope/telescope.nvim", -- optional dependency
        event = { "BufReadPost" },
        config = function()
            local map = require("core.functions").map

            -- Set key mappings for scissors plugin using custom map function
            map("n", "<leader>aS", "<cmd>lua require('scissors').editSnippet()<CR>", {}, "Edit Snippet")
            map("x", "<leader>as", "<cmd>lua require('scissors').addNewSnippet()<CR>", {}, "Add New Snippet")

            require("scissors").setup({
                snippetDir = require("core.functions").get_snippet_path(),
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
                        insertNextPlaceholder = "<C-t>", -- insert & normal mode
                    },
                },
                snippetSelection = {
                    telescope = {
                        -- By default, the query only searches snippet prefixes. Set this to
                        -- `true` to also search the body of the snippets.
                        alsoSearchSnippetBody = false,
                    },
                    -- `none` writes as a minified json file using `vim.encode.json`.
                    -- `yq`/`jq` ensure formatted & sorted json files, which is relevant when
                    -- you version control your snippets.
                    jsonFormatter = "none", -- "yq"|"jq"|"none"
                },
            })
        end,
    },
    {
        "stevearc/quicker.nvim",
        event = "FileType qf",
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {},
    },
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap",
            "mfussenegger/nvim-dap-python", --optional
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        },
        lazy = true,
        ft = "py",
        branch = "regexp", -- This is the regexp branch, use this for the new version
        config = function()
            require("venv-selector").setup()
        end,
        keys = {
            { ",v", "<cmd>VenvSelect<cr>" },
        },
    },
}
