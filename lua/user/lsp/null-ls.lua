local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

null_ls.setup({
    debug = false,
    sources = {
        formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
        formatting.black.with({ command = "black", extra_args = { "--line-length", "79" } }),
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),

        formatting.clang_format.with({
            command = "clang-format",
            extra_args = {
                "--style",
                "BasedOnStyle: Chromium, IndentWidth: 4, AlignTrailingComments: true, BraceWrapping: {AfterFunction: false}, ColumnLimit: 80",
            },
        }),

        diagnostics.flake8,
        diagnostics.shellcheck,
        formatting.shfmt,
        completion.spell.with({
            filetypes = {"markdown", ".md"}
        }),

    },
})
