return {
    {
        { "b0o/schemastore.nvim", ft = { "typescript", "javascript" } },
        -- { "jose-elias-alvarez/typescript.nvim", ft = { "typescript", "javascript" } },
        { "mfussenegger/nvim-jdtls", ft = { "java" } },
        { "ray-x/lsp_signature.nvim", enabled = false },

        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- Library items can be absolute paths
                    -- "~/projects/my-awesome-lib",
                    -- Or relative, which means they will be resolved as a plugin
                    -- "LazyVim",
                    -- When relative, you can also provide a path to the library in the plugin dir
                    "luvit-meta/library", -- see below
                },
            },
        },
        { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    },
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "akinsho/flutter-tools.nvim",
        },

        config = function()
            require("plugins.lsp.lspconfig").init_lsp()
        end,
    },
    -- },
    {
        url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = true,
        event = "BufReadPre",
    },
    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("plugins.lsp.mason").config()
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.lsp.formatting").config()
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.lsp.linting").config()
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        ft = { "rust" },
    },

    {
        "p00f/clangd_extensions.nvim",
        ft = { "c", "cpp" },
    },
    {
        "akinsho/flutter-tools.nvim",
        lazy = true,
        ft = "dart",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim", -- optional for vim.ui.select
        },
        config = function()
            local status_ok, telescope = pcall(require, "telescope")
            if status_ok then
                telescope.load_extension("flutter")
            end
            local on_attach = require("plugins.lsp.handlers").on_attach
            local capabilities = require("plugins.lsp.handlers").capabilities

            require("flutter-tools").setup({
                lsp = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                },
            })
        end,
    },
}
