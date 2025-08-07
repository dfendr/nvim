local M = {}

local settings = require("core.prefs")

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

M.setup = function()
    if settings.lsp.show_diagnostic_signs then
        local icons = require("plugins.ui.icons")
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                    [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
                    [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                    [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
                },
            },
        })
    else
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.HINT] = "",
                    [vim.diagnostic.severity.INFO] = "",
                },
            },
            numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticError",
                [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
                [vim.diagnostic.severity.HINT] = "DiagnosticHint",
                [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            },
        })
    end

    local config = {
        -- disable virtual text
        on_attach_callback = nil,
        on_init_callback = nil,
        virtual_lines = false,
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = require("core.prefs").ui.border_style,
            source = "if_many", -- Or "always"
            header = "",
            prefix = "",
            -- width = 40,
        },
    }

    vim.diagnostic.config(config)

end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local map = require("core.functions").map

    -- Diagnostic display
    vim.diagnostic.config({
        float = { border = require("core.prefs").ui.border_style },
    })

    -- Check if Telescope is available
    local status_telescope, _ = pcall(require, "telescope")
    if status_telescope then
        -- Telescope-based LSP mappings
        map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts, "Go To Definitions", bufnr)
        map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts, "Go To Implementations", bufnr)
        map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts, "Go To References", bufnr)
    else
        -- Fallback LSP mappings if Telescope is not installed
        map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts, "Go To Definition", bufnr)
        map("n", "gi", "<cmd>lua vim.lsp.buf.implemention()<CR>", opts, "Go To Implemention", bufnr)
        map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts, "Go To References", bufnr)
    end

    -- Non-Telescope LSP mappings
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts, "Go To Declaration", bufnr)
    map(
        "n",
        "gh",
        -- TODO: Find an alternative to this
        "<cmd>lua vim.lsp.buf.hover({border = require('core.prefs').ui.border_style})<CR>",
        opts,
        "Hover Documentation",
        bufnr
    )
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts, "Show Line Diagnostics", bufnr)
    map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts, "Show Signature Help", bufnr)
    map("n", "<M-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts, "Format Code", bufnr)
    map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts, "Previous Diagnostic", bufnr)
    map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts, "Next Diagnostic", bufnr)
    map(
        "n",
        "]e",
        "<cmd>lua vim.diagnostic.goto_next({severity=vim.diagnostic.severity.ERROR})<CR>",
        opts,
        "Next Error",
        bufnr
    )
    map(
        "n",
        "[e",
        "<cmd>lua vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR})<CR>",
        opts,
        "Previous Error",
        bufnr
    )
    map("n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts, "Add Workspace Folder", bufnr)
    map(
        "n",
        "<leader>lwr",
        "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
        opts,
        "Remove Workspace Folder",
        bufnr
    )
    map(
        "n",
        "<leader>lwl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        opts,
        "List Workspace Folders",
        bufnr
    )

    -- Code action key mapping
    local ok, _ = pcall(require, "actions-preview")
    if ok then
        map("n", "<C-.>", "<cmd>lua require('actions-preview').code_actions()<cr>", opts, "Code Actions Preview", bufnr)
    else
        map("n", "<C-.>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts, "Code Actions", bufnr)
    end
end

M.on_attach = function(client, bufnr)
    require("plugins.lsp.utils").setup_document_symbols(client, bufnr)
    require("plugins.lsp.utils").setup_codelens_refresh(client, bufnr)

    -- Don't use semantic tokens
    -- client.server_capabilities.semanticTokensProvider = nil

    lsp_keymaps(bufnr)

    if client:supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

function M.enable_format_on_save()
    vim.cmd([[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * :FormatBuffer
    augroup end
  ]])
    vim.notify("Enabled format on save")
end

function M.disable_format_on_save()
    M.remove_augroup("format_on_save")
    vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
    if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
        M.enable_format_on_save()
    else
        M.disable_format_on_save()
    end
end

vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("plugins.lsp.handlers").toggle_format_on_save()' ]])

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

return M
