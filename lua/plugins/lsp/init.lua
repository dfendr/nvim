return {
    {
        { "b0o/schemastore.nvim", ft = { "typescript", "javascript" } },
        { "mfussenegger/nvim-jdtls", ft = { "java" } },

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
    -- Neovim 0.11+ built-in LSP. nvim-lspconfig is loaded as a config registry
    -- only (provides `lsp/<name>.lua` defaults on the runtimepath); we never
    -- call `require("lspconfig")`.
    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        event = "VeryLazy",
        config = function()
            require("plugins.lsp.mason").config()
            -- Start built-in LSP servers via vim.lsp.start
            require("plugins.lsp.builtin").setup()
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
        "mrcjkb/rustaceanvim",
        version = "^6",
        lazy = false, -- plugin provides its own ftplugin/lazy loading
        init = function()
            require("plugins.lsp.settings.rust")
        end,
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
