return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        local map = require("core.functions").map

        conform.formatters.stylua = { prepend_args = { "--indent-type", "Spaces" } }
        conform.formatters.prettier = { prepend_args = { "--tab-width", "2" } }
        conform.formatters.black = { prepend_args = { "--line-length", "79" } }
        conform.formatters.clang_format = {
            prepend_args = {
                "--style",
                "{BasedOnStyle: Chromium, IndentWidth: 4, ColumnLimit: 80, AlignTrailingComments: true, PointerAlignment: Right, BraceWrapping: {AfterFunction: false}}",
            },
        }
        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                lua = { "stylua" },
                python = { "isort", "black" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                arduino = { "clang_format" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
                cs = { "csharpier" },
            },
        })
    end,
}
