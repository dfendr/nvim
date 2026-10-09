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

-- No prebuilt linux-arm64 binaries in Mason for these.
local arm_linux_unsupported = { selene = true }

function M.check()
    local mr = require("mason-registry")
    local uname = vim.uv.os_uname()
    local arm_linux = uname.sysname == "Linux" and uname.machine:match("^a") ~= nil
    for _, tool in ipairs(M.tools) do
        local p = mr.get_package(tool)
        if not (arm_linux and arm_linux_unsupported[tool]) and not p:is_installed() then
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
