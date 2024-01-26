local M = {}
function M.config()
    local null_ls_status_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_status_ok then
        return
    end

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local completion = null_ls.builtins.completion

    local source_configs = {
        { exe = "prettier", source = formatting.prettier.with({ extra_args = { "--tab-width", "2" } }), type = "formatting" },
        { exe = "black", source = formatting.black.with({ extra_args = { "--line-length", "79" } }), type = "formatting" },
        { exe = "stylua", source = formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }), type = "formatting" },
        { exe = "clang-format", source = formatting.clang_format.with({ extra_args = { "--style", "{BasedOnStyle: Chromium, IndentWidth: 4, ColumnLimit: 80, AlignTrailingComments: true, BraceWrapping: {AfterFunction: false}}", }, filetypes = { "c", "cpp", "arduino" }, }), type = "formatting" },
        { exe = "shellcheck", source = diagnostics.shellcheck.with({ filetypes = { "sh", "zsh" } }), type = "diagnostics" },
        { exe = "shfmt", source = formatting.shfmt.with({ filetypes = { "sh", "zsh" } }), type = "formatting" },
        { exe = "jq", source = formatting.jq.with({ filetypes = { "json" } }), type = "formatting" },
        { exe = "sql-formatter", source = formatting.sql_formatter, type = "formatting" },
        { exe = "google-java-format", source = formatting.google_java_format, type = "formatting" },
        { exe = "csharpier", source = formatting.csharpier.with({ filetypes = { "cs" } }), type = "formatting" },
        { exe = "markdownlint", source = diagnostics.markdownlint, type = "diagnostics" },
        { exe = "aspell", source = completion.spell.with({ filetypes = { "markdown", ".md" } }), type = "completion" },
    }

    local sources = {}
    for _, config in ipairs(source_configs) do
        if vim.fn.executable(config.exe) == 1 then
            table.insert(sources, config.source)
        end
    end

    null_ls.setup({
        debug = false,
        sources = sources,
    })
end
return M

