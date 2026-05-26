local M = {}

local function safe_require(mod)
    local ok, val = pcall(require, mod)
    if ok then return val end
    return nil
end

local function resolve_omnisharp_root(fname)
    local dir = vim.fs.dirname(fname)
    local project = vim.fs.find(function(name, _)
        return name:match("%.sln$") or name:match("%.csproj$")
    end, { path = dir, upward = true })[1]
    if project then
        return vim.fs.dirname(project)
    end
    local git = vim.fs.find({ ".git" }, { path = dir, upward = true })[1]
    return git and vim.fs.dirname(git) or dir
end

-- Servers installed via Mason. Adding a name auto-installs (mason-lspconfig
-- `ensure_installed`) and auto-enables (mason-lspconfig `automatic_enable`).
-- Defaults come from nvim-lspconfig's `lsp/<name>.lua` on the runtimepath.
M.mason_servers = {
    "bashls",
    "clangd",
    "emmet_ls",
    "gopls",
    "jsonls",
    "lua_ls",
    "omnisharp",
    "pyright",
    "tailwindcss",
    "vtsls",
    "yamlls",
}

-- Servers installed outside Mason (system packages, Qt-bundled binaries, etc.).
-- Same default-config resolution as above; just enabled manually below.
M.system_servers = {
    "qmlls",
}

-- Per-server overrides merged on top of nvim-lspconfig's registry defaults.
-- Only list keys you actually want to override.
local function server_overrides()
    local schemastore = safe_require("schemastore")
    return {
        gopls = vim.tbl_deep_extend("force", {
            settings = {
                gopls = {
                    analyses = { unusedparams = true, shadow = true },
                    gofumpt = true,
                },
            },
        }, safe_require("plugins.lsp.settings.gopls") or {}),
        bashls = { filetypes = { "sh", "zsh" } },
        clangd = {
            cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--completion-style=bundled",
                "--cross-file-rename",
                "--header-insertion=iwyu",
            },
            filetypes = { "c", "cpp", "arduino" },
            capabilities = { offsetEncoding = "utf-8" },
        },
        jsonls = schemastore
            and { settings = { json = { schemas = schemastore.json.schemas() } } }
            or nil,
        lua_ls = {
            settings = {
                Lua = {
                    telemetry = { enable = false },
                    workspace = { checkThirdParty = false },
                    diagnostics = { globals = { "vim" } },
                },
            },
        },
        yamlls = { settings = { yaml = { schemaStore = { enable = true } } } },
        tailwindcss = safe_require("plugins.lsp.settings.tailwindcss"),
        emmet_ls = safe_require("plugins.lsp.settings.emmet_ls"),
        omnisharp = vim.tbl_deep_extend("force", {
            root_dir = resolve_omnisharp_root,
        }, safe_require("plugins.lsp.settings.omnisharp") or {}),
    }
end

local function all_servers()
    local all = {}
    vim.list_extend(all, M.mason_servers)
    vim.list_extend(all, M.system_servers)
    return all
end

function M.setup()
    local handlers = require("plugins.lsp.handlers")
    handlers.setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local blink = safe_require("blink.cmp")
    if blink and blink.get_lsp_capabilities then
        capabilities = blink.get_lsp_capabilities(capabilities)
    end

    vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = handlers.on_attach,
    })

    for name, cfg in pairs(server_overrides()) do
        if cfg then
            vim.lsp.config(name, cfg)
        end
    end

    -- mason-lspconfig `automatic_enable` covers Mason-installed servers; this
    -- also enables system_servers and is idempotent for the Mason list.
    vim.lsp.enable(all_servers())
end

return M
