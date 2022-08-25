local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = false,
    sources = {
        formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
        formatting.black.with({ extra_args = { "--line-length", "79" } }),
        formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
        --formatting.stylua.with({ extra_args = { "--indent_type", "Spaces" } }),
        --formatting.stylua,
        --formatting.black,
        -- formatting.yapf,
        diagnostics.flake8,
    },
})
