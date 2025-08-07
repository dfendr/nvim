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
    local opts = {
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities,
    }

    require("mason").setup({
        ui = {
            border = require("core.prefs").ui.border_style,
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
    })

    require("mason-lspconfig").setup({
        ensure_installed = {
            "bashls",
            "clangd",
            "html",
            "jsonls",
            "lua_ls",
            "pyright",
            "marksman",
            "omnisharp",
            "rust_analyzer",
            "phpactor",
            "yamlls",
        },
        automatic_installation = true,
    })
    M.check()
end
return M
