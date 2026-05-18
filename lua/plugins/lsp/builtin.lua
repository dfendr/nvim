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

local function build_servers()
    local schemastore = safe_require("schemastore")

    return {
        pyright = {
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = { "python" },
            root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
        },
        gopls = vim.tbl_deep_extend("force", {
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_markers = { "go.work", "go.mod", ".git" },
            settings = {
                gopls = {
                    analyses = { unusedparams = true, shadow = true },
                    gofumpt = true,
                },
            },
        }, safe_require("plugins.lsp.settings.gopls") or {}),
        vtsls = {
            cmd = { "vtsls", "--stdio" },
            filetypes = {
                "javascript", "javascriptreact", "javascript.jsx",
                "typescript", "typescriptreact", "typescript.tsx",
            },
            root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
        },
        bashls = {
            cmd = { "bash-language-server", "start" },
            filetypes = { "sh", "zsh" },
            root_markers = { ".git" },
        },
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
            root_markers = { "compile_commands.json", ".git" },
            capabilities = { offsetEncoding = "utf-8" },
        },
        jsonls = {
            cmd = { "vscode-json-language-server", "--stdio" },
            filetypes = { "json", "jsonc" },
            root_markers = { ".git" },
            settings = schemastore and { json = { schemas = schemastore.json.schemas() } } or nil,
        },
        lua_ls = {
            cmd = { "lua-language-server" },
            filetypes = { "lua" },
            root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
            settings = {
                Lua = {
                    telemetry = { enable = false },
                    workspace = { checkThirdParty = false },
                    diagnostics = { globals = { "vim" } },
                },
            },
        },
        yamlls = {
            cmd = { "yaml-language-server", "--stdio" },
            filetypes = { "yaml", "yml" },
            root_markers = { ".git" },
            settings = { yaml = { schemaStore = { enable = true } } },
        },
        tailwindcss = safe_require("plugins.lsp.settings.tailwindcss") or {
            cmd = { "tailwindcss-language-server", "--stdio" },
            filetypes = { "html", "css" },
        },
        emmet_ls = safe_require("plugins.lsp.settings.emmet_ls"),
        omnisharp = vim.tbl_deep_extend("force", {
            cmd = { "omnisharp" },
            filetypes = { "cs", "vb", "razor" },
            root_dir = resolve_omnisharp_root,
        }, safe_require("plugins.lsp.settings.omnisharp") or {}),
    }
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

    local servers = build_servers()
    local names = {}
    for name, cfg in pairs(servers) do
        if cfg then
            vim.lsp.config(name, cfg)
            table.insert(names, name)
        end
    end
    vim.lsp.enable(names)
end

function M.server_names()
    local names = {}
    for name, cfg in pairs(build_servers()) do
        if cfg then
            table.insert(names, name)
        end
    end
    return names
end

return M
