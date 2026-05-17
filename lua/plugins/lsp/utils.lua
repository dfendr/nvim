local M = {}

function M.setup_codelens_refresh(client, bufnr)
    local status_ok, codelens_supported = pcall(function()
        return client:supports_method("textDocument/codeLens")
    end)
    if not status_ok or not codelens_supported then
        return
    end
    local group = "lsp_code_lens_refresh"
    local cl_events = { "BufEnter", "InsertLeave" }
    local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
        group = group,
        buffer = bufnr,
        event = cl_events,
    })
    if ok and #cl_autocmds > 0 then
        return
    end
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_create_autocmd(cl_events, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
    })
end

return M
