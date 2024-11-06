return {
    "stevearc/conform.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.formatters.stylua = { prepend_args = { "--indent-type", "Spaces" } }
        -- conform.formatters.prettier = { prepend_args = { "--tab-width", "2" } }
        conform.formatters.black = { prepend_args = { "--line-length", "79" } }

        conform.formatters["clang-format"] = {
            prepend_args = {
                "--style",
                "{BasedOnStyle: Chromium, IndentWidth: 4, ColumnLimit: 80, AlignTrailingComments: true, PointerAlignment: Right, BraceWrapping: {AfterFunction: false}}",
            },
        }

        conform.formatters["sql-formatter"] = {
            command = "sql-formatter",
            args = {
                "--language",
                "sql",
                "--config",
                [[{
          "tabWidth": 4,
          "keywordCase": "upper",
          "linesBetweenQueries": 4
        }]],
            },
            stdin = true,
        }
        conform.setup({
            formatters_by_ft = {
                arduino = { "clang-format" },
                tex = { "latexindent" },
                sql = { "sql-formatter" },
                bash = { "shfmt" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                cs = { "csharpier" },
                css = { "prettier" },
                graphql = { "prettier" },
                html = { "prettier" },
                javascript = { "prettier" },
                javascriptreact = { "prettier" },
                proto = { "buf" },
                json = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                python = { "isort", "black" },
                sh = { "shfmt" },
                svelte = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                yaml = { "prettier" },
                zsh = { "shfmt" },
            },
        })
    end,
}
