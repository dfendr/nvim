local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
    return
end

local servers = {
    "sumneko_lua",
    "tsserver",
    "pyright",
    "yamlls",
    "bashls",
    "clangd",
    "omnisharp",
    "rust_analyzer",
}

-- Package installation folder
-- local install_root_dir = vim.fn.stdpath "data" .. "/mason"

local settings = {
    ui = {
        border = "rounded",
        icons = {
            -- package_installed = "◍",
            -- package_pending = "◍",
            -- package_uninstalled = "◍",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}


local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    server = vim.split(server, "@")[1]

    if server == "jsonls" then
        local jsonls_opts = require("user.lsp.settings.jsonls")
        opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if server == "omnisharp" then
        local omnisharp_opts = require("user.lsp.settings.omnisharp")
        opts = vim.tbl_deep_extend("force", omnisharp_opts, opts)
    end

    if server == "bash-language-server" then
        local bash_opts = require("user.lsp.settings.bash")
        opts = vim.tbl_deep_extend("force", bash_opts, opts)
    end

    if server == "yamlls" then
        local yamlls_opts = require("user.lsp.settings.yamlls")
        opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
    end

    if server == "sumneko_lua" then
        local sumneko_opts = require("user.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    -- if server == "clangd" then
        -- goto continue
         -- local clangd = require "user.lsp.settings.clangd"
         -- opts = vim.tbl_deep_extend("force",clangd, opts)
    -- end

    if server == "tsserver" then
        local tsserver_opts = require("user.lsp.settings.tsserver")
        opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
    end

    if server == "pyright" then
        local pyright_opts = require("user.lsp.settings.pyright")
        opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    end

    if server == "rust_analyzer" then
        local rust_opts = require "user.lsp.settings.rust"
        opts = vim.tbl_deep_extend("force", rust_opts, opts)

        local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
        if not rust_tools_status_ok then
          return
        end

        rust_tools.setup(rust_opts)
        goto continue
    end

    if server == "jdtls" then
        goto continue
    end

    lspconfig[server].setup(opts)
    ::continue::
end

mason.setup(settings)
mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})
