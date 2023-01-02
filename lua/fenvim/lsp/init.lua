return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "simrat39/rust-tools.nvim",
            { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            {
                "folke/neodev.nvim",
                config = {
                    debug = true,
                    experimental = { pathStrict = true },
                    library = { runtime = "~/projects/neovim/runtime/" },
                },
            },

            debug = true,
            experimental = {
                pathStrict = true,
            },
            library = {
                runtime = "~/projects/neovim/runtime/",
            },
        },

        config = function()
            require("fenvim.lsp.lspconfig").config()
        end,
    },
    -- },
    {
        "Maan2003/lsp_lines.nvim",
        event = "BufReadPre",
        config = {
            text = {
                done = "✔",
            },
        },
    },
    --{require("fenvim.lsp.handlers").config(),},
    -- {
    --     "j-hui/fidget.nvim",
    --     event = "BufReadPre",
    --     config = true,
    -- },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
        },
        event = "BufReadPre",
        config = function()
            require("fenvim.lsp.mason").config()
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        config = function()
            require("fenvim.lsp.null-ls").config()
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufReadPost",
        config = function()
            require("fenvim.lsp.lsp-signature").config()
        end,
    },
}
