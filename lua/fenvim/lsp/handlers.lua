local M = {}

local settings = require("core.prefs")

local cmp_nvim_lsp = require("cmp_nvim_lsp")

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
    if settings.lsp.show_diagnostic_signs then
        local icons = require("fenvim.ui.icons")
        local signs = {
            { name = "DiagnosticSignError", text = icons.diagnostics.Error },
            { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
            { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
            { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
        }
        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
        end
    else
        vim.fn.sign_define(
            "DiagnosticSignError",
            { texthl = "DiagnosticSignError", text = "", numhl = "DiagnosticError" }
        )
        vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "DiagnosticWarn" })
        vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "DiagnosticHint" })
        vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "DiagnosticInfo" })
    end

    local config = {
        -- disable virtual text
        on_attach_callback = nil,
        on_init_callback = nil,
        -- on_init_callback = function(_)
        --     require("fenvim.lsp.lsp-signature").config()
        -- end,
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
            width = 40,
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = require("core.prefs").ui.border_style,
        --     -- width = 60,
        --     -- height = 30,
    })
    --
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = require("core.prefs").ui.border_style,
        -- width = 60,
        -- height = 30,
    })
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    local map = require("core.functions").map

    -- Diagnostic display
    vim.diagnostic.config({
        float = { border = require("core.prefs").ui.border_style },
    })

    -- LSP Key mappings
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts, "Go To Declaration", bufnr)
    map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts, "Go To Definitions", bufnr)
    map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts, "Hover Documentation", bufnr)
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts, "Show Line Diagnostics", bufnr)
    map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts, "Go To Implementations", bufnr)
    map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts, "Go To References", bufnr)
    map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts, "Show Signature Help", bufnr)
    map("n", "<M-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts, "Format Code", bufnr)
    map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts, "Previous Diagnostic", bufnr)
    map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts, "Next Diagnostic", bufnr)
    map( "n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity=vim.diagnostic.severity.ERROR})<CR>", opts, "Next Error", bufnr)
    map( "n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR})<CR>", opts, "Previous Error", bufnr)
    map("n", "<leader>lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts, "Add Workspace Folder", bufnr)
    map( "n", "<leader>lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts, "Remove Workspace Folder", bufnr)
    map( "n", "<leader>lwl", "<cmd>lua  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts, "List Workspace Folders", bufnr)

    -- Code action key mapping
    local ok, _ = pcall(require, "actions-preview")
    if ok then
        map("n", "<C-.>", "<cmd>lua require('actions-preview').code_actions()<cr>", opts, "Code Actions Preview", bufnr)
    else
        map("n", "<C-.>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts, "Code Actions", bufnr)
    end
end

M.on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = false
    require("fenvim.lsp.utils").setup_document_symbols(client, bufnr)
    lsp_keymaps(bufnr)

    if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(bufnr, true)
    end

    if client.name == "tsserver" or client.name == "clangd" then
        client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
        client.server_capabilities.documentRangeFormattingProvider = false -- 0.8 and later
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


vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("fenvim.lsp.handlers").toggle_format_on_save()' ]])

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

return M
