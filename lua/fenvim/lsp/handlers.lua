local M = {}

local settings = require("config.settings")

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local utils = require("fenvim.lsp.utils")

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
            border = "rounded",
            source = "if_many", -- Or "always"
            header = "",
            prefix = "",
            width = 40,
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        -- width = 60,
        -- height = 30,
    })
    --
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        -- width = 60,
        -- height = 30,
    })
end

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<F12>", "<cmd>Telescope lsp_definitions<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_declarations<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- Go Hover
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- Go ...Lerror? Go....let me see diagnostics? Convenient but not easy to remember.
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<M-f>", "<cmd>Format<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-.>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "]e",
        '<cmd>lua vim.diagnostic.goto_next({severity=vim.diagnostic.severity.ERROR, border = "rounded" })<CR>',
        opts
    )
    vim.api.nvim_buf_set_keymap(
        bufnr,
        "n",
        "[e",
        '<cmd>lua vim.diagnostic.goto_prev({severity=vim.diagnostic.severity.ERROR, border = "rounded" })<CR>',
        opts
    )
end

M.on_attach = function(client, bufnr)
    client.server_capabilities.semanticTokensProvider = false
    require("fenvim.lsp.lsp-signature").config()
    lsp_keymaps(bufnr)

    if client.name == "jdt.ls" then
        vim.lsp.codelens.refresh()
        if JAVA_DAP_ACTIVE then
            require("jdtls").setup_dap({ hotcodereplace = "auto" })
            require("jdtls.dap").setup_dap_main_class_configs()
        end
    end
    if client.name == "clangd" then -- disable formatting, handled by null-ls
        -- client.resolved_capabilities.document_formatting = false -- 0.7 and earlier
        client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
    end
end

function M.enable_format_on_save()
    vim.cmd([[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
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

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("user.lsp.handlers").toggle_format_on_save()' ]])

return M
