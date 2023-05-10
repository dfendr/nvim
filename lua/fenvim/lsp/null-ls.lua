local M = {}
function M.config()
    local null_ls_status_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_status_ok then
        return
    end

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local completion = null_ls.builtins.completion
    local code_actions = null_ls.builtins.code_actions

    null_ls.setup({
        debug = false,
        sources = {
            formatting.prettier.with({ extra_args = { "--tab-width", "2" } }),
            formatting.black.with({ command = "black", extra_args = { "--line-length", "79" } }),
            formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
            formatting.clang_format.with({
                command = "clang-format",
                extra_args = {
                    "--style",
                    "{BasedOnStyle: Chromium, IndentWidth: 4, ColumnLimit: 80, AlignTrailingComments: true, BraceWrapping: {AfterFunction: false}}",
                },
                filetypes = { "c", "cpp" },
            }),
            diagnostics.shellcheck.with({ filetypes = { "sh", "zsh" } }),
            formatting.sql_formatter,
            formatting.google_java_format,
            formatting.csharpier,
            formatting.shfmt.with({ filetypes = { "sh", "zsh" } }),
            diagnostics.markdownlint,
            formatting.markdownlint,
            code_actions.proselint,
            diagnostics.proselint,
            completion.spell.with({ filetypes = { "markdown", ".md" } }),
            require("typescript.extensions.null-ls.code-actions"),
        },
    })
end
return M
