M = {}


local function lsp_keymaps(bufnr)
    local opts = { buffer = bufnr, silent = true, noremap = true }

    vim.diagnostic.config({
        float = { border = require("core.prefs").ui.border_style },
    })

    local telescope_ok, _ = pcall(require, "telescope")

    if telescope_ok then
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Go To Definitions" }))
        vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", vim.tbl_extend("force", opts, { desc = "Go To Implementations" }))
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Go To References" }))
    else
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go To Definition" }))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go To Implementation" }))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go To References" }))
    end

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go To Declaration" }))
    vim.keymap.set("n", "gh", function() vim.lsp.buf.hover({ border = require("core.prefs").ui.border_style }) end, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show Line Diagnostics" }))
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Show Signature Help" }))
    vim.keymap.set("n", "<M-f>", function() vim.lsp.buf.format({ async = true }) end, vim.tbl_extend("force", opts, { desc = "Format Code" }))
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
    vim.keymap.set("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, vim.tbl_extend("force", opts, { desc = "Next Error" }))
    vim.keymap.set("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, vim.tbl_extend("force", opts, { desc = "Previous Error" }))
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { buffer = bufnr, silent = true, desc = "Previous Diagnostic" })
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { buffer = bufnr, silent = true, desc = "Next Diagnostic" })
    vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add Workspace Folder" }))
    vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove Workspace Folder" }))
    vim.keymap.set("n", "<leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, vim.tbl_extend("force", opts, { desc = "List Workspace Folders" }))

    local actions_ok, actions_preview = pcall(require, "actions-preview")
    if actions_ok then
        vim.keymap.set("n", "<C-.>", actions_preview.code_actions, vim.tbl_extend("force", opts, { desc = "Code Actions Preview" }))
    else
        vim.keymap.set("n", "<C-.>", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    end
end


-- Attach keymaps for every LSP client that connects
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        lsp_keymaps(bufnr)
    end,
})

function M.init_lsp()
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

    -- Custom Server Capabilities
    local servers = { "ts_ls", "pyright" }
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
