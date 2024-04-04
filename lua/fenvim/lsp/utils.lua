local M = {}

local tbl = require("utils.table")

function M.is_client_active(name)
    local clients = vim.lsp.get_clients()
    return tbl.find_first(clients, function(client)
        return client.name == name
    end)
end

function M.get_active_clients_by_ft(filetype)
    local matches = {}
    local clients = vim.lsp.get_clients()
    for _, client in pairs(clients) do
        local supported_filetypes = client.config.filetypes or {}
        if client.name ~= "null-ls" and vim.tbl_contains(supported_filetypes, filetype) then
            table.insert(matches, client)
        end
    end
    return matches
end

function M.get_client_capabilities(client_id)
    local client = vim.lsp.get_client_by_id(tonumber(client_id))
    if not client then
        return
    end

    local enabled_caps = {}
    for capability, status in pairs(client.server_capabilities) do
        if status == true then
            table.insert(enabled_caps, capability)
        end
    end

    return enabled_caps
end

---Get supported filetypes per server
---@param server_name string can be any server supported by nvim-lsp-installer
---@return string[] supported filestypes as a list of strings
function M.get_supported_filetypes(server_name)
    local status_ok, config = pcall(require, ("lspconfig.server_configurations.%s"):format(server_name))
    if not status_ok then
        return {}
    end

    return config.default_config.filetypes or {}
end

---Get supported servers per filetype
---@param filter { filetype: string | string[] }?: (optional) Used to filter the list of server names.
---@return string[] list of names of supported servers
function M.get_supported_servers(filter)
    local _, supported_servers = pcall(function()
        return require("mason-lspconfig").get_available_servers(filter)
    end)
    return supported_servers or {}
end

---Get all supported filetypes by nvim-lsp-installer
---@return string[] supported filestypes as a list of strings
function M.get_all_supported_filetypes()
    local status_ok, filetype_server_map = pcall(require, "mason-lspconfig.mappings.filetype")
    if not status_ok then
        return {}
    end
    return vim.tbl_keys(filetype_server_map or {})
end

function M.setup_document_highlight(client, bufnr)
    local status_ok, highlight_supported = pcall(function()
        return client.supports_method("textDocument/documentHighlight")
    end)
    if not status_ok or not highlight_supported then
        return
    end
    local group = "lsp_document_highlight"
    local hl_events = { "CursorHold", "CursorHoldI" }

    local ok, hl_autocmds = pcall(vim.api.nvim_get_autocmds, {
        group = group,
        buffer = bufnr,
        event = hl_events,
    })

    if ok and #hl_autocmds > 0 then
        return
    end

    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_create_autocmd(hl_events, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })
end

function M.setup_document_symbols(client, bufnr)
    local symbols_supported = client.supports_method("textDocument/documentSymbol")
    if not symbols_supported then
        vim.notify("skipping setup for document_symbols, method not supported by " .. client.name)
        return
    end
end

function M.setup_codelens_refresh(client, bufnr)
    local status_ok, codelens_supported = pcall(function()
        return client.supports_method("textDocument/codeLens")
    end)
    if not status_ok or not codelens_supported then
        return
    end
    local group = "lsp_code_lens_refresh"
    local cl_events = { "BufReadPost", "InsertLeave" }
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

---filter passed to vim.lsp.buf.format
---always selects null-ls if it's available and caches the value per buffer
---@param client table client attached to a buffer
---@return boolean if client matches
function M.format_filter(client)
    local filetype = vim.bo.filetype
    local n = require("null-ls")
    local s = require("null-ls.sources")
    local method = n.methods.FORMATTING
    local available_formatters = s.get_available(filetype, method)

    if #available_formatters > 0 then
        return client.name == "null-ls"
    elseif client.supports_method("textDocument/formatting") then
        return true
    else
        return false
    end
end

---Simple wrapper for vim.lsp.buf.format() to provide defaults
---@param opts table|nil
function M.format(opts)
    opts = opts or {}
    opts.filter = opts.filter or M.format_filter

    return vim.lsp.buf.format(opts)
end

local uv = vim.loop

--- Returns a table with the default values that are missing.
--- either parameter can be empty.
--@param config (table) table containing entries that take priority over defaults
--@param default_config (table) table contatining default values if found
function M.apply_defaults(config, default_config)
    config = config or {}
    default_config = default_config or {}
    local new_config = vim.tbl_deep_extend("keep", vim.empty_dict(), config)
    new_config = vim.tbl_deep_extend("keep", new_config, default_config)
    return new_config
end

--- Checks whether a given path exists and is a file.
--@param path (string) path to check
--@returns (bool)
function M.is_file(path)
    local stat = uv.fs_stat(path)
    return stat and stat.type == "file" or false
end

--- Checks whether a given path exists and is a directory
--@param path (string) path to check
--@returns (bool)
function M.is_directory(path)
    local stat = uv.fs_stat(path)
    return stat and stat.type == "directory" or false
end

M.join_paths = _G.join_paths

---Write data to a file
---@param path string can be full or relative to `cwd`
---@param txt string|table text to be written, uses `vim.inspect` internally for tables
---@param flag string used to determine access mode, common flags: "w" for `overwrite` or "a" for `append`
function M.write_file(path, txt, flag)
    local data = type(txt) == "string" and txt or vim.inspect(txt)
    uv.fs_open(path, flag, 438, function(open_err, fd)
        assert(not open_err, open_err)
        uv.fs_write(fd, data, -1, function(write_err)
            assert(not write_err, write_err)
            uv.fs_close(fd, function(close_err)
                assert(not close_err, close_err)
            end)
        end)
    end)
end

---Copies a file or directory recursively
---@param source string
---@param destination string
function M.fs_copy(source, destination)
    local source_stats = assert(vim.loop.fs_stat(source))

    if source_stats.type == "file" then
        assert(vim.loop.fs_copyfile(source, destination))
        return
    elseif source_stats.type == "directory" then
        local handle = assert(vim.loop.fs_scandir(source))

        assert(vim.loop.fs_mkdir(destination, source_stats.mode))

        while true do
            local name = vim.loop.fs_scandir_next(handle)
            if not name then
                break
            end

            M.fs_copy(M.join_paths(source, name), M.join_paths(destination, name))
        end
    end
end

return M
