M = {}

function M.config()
    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
        return
    end

    -- Change LSPInfo border to rounded
    require("lspconfig.ui.windows").default_options.border = require("core.prefs").ui.border_style

    -- integrate blink.cmp capabilities
    local blink_cmp_ok, blink_cmp = pcall(require, "blink.cmp")
    if not blink_cmp_ok then
        vim.notify("blink.cmp not available", vim.log.levels.WARN)
        return
    end

    -- set enhanced capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = blink_cmp.get_lsp_capabilities(capabilities)

    -- configure servers with enhanced capabilities
    local servers = { "ts_ls", "pyright" } -- add or modify server list
    for _, server in ipairs(servers) do
        lspconfig[server].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                -- optional: custom attach logic here
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        })
    end

    M.server_capabilities = function()
        local active_clients = vim.lsp.get_clients()
        local active_client_map = {}

        for index, value in ipairs(active_clients) do
            active_client_map[value.name] = index
        end

        vim.ui.select(vim.tbl_keys(active_client_map), {
            prompt = "Select client:",
            format_item = function(item)
                return "capabilities for: " .. item
            end,
        }, function(choice)
            local client = vim.lsp.get_clients()[active_client_map[choice]]
            print(vim.inspect(client.server_capabilities.executeCommandProvider))
            vim.pretty_print(client.server_capabilities)
        end)
    end

    require("fenvim.lsp.handlers").setup()
end

return M
