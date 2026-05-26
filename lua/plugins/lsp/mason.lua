local M = {}

M.tools = {
    "black",
    "clang-format",
    "codelldb",
    "debugpy",
    "flake8",
    "prettier",
    "selene",
    "ruff",
    "shfmt",
    "stylua",
}

function M.check()
    local mr = require("mason-registry")
    for _, tool in ipairs(M.tools) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
            p:install()
        end
    end
end

function M.config()
    require("mason").setup({
        ui = {
            border = require("core.prefs").ui.border_style,
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
    })

    require("mason-lspconfig").setup({
        ensure_installed = require("plugins.lsp.builtin").mason_servers,
        -- automatic_enable defaults to true in v2 → installed servers are
        -- enabled via vim.lsp.enable() automatically, using nvim-lspconfig's
        -- registry for defaults plus our per-server overrides.
    })
    M.check()
end
return M
