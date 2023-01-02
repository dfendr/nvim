-- Lua Utility Functions

local M = {}

-- Keybind mapping function
function M.map(mode, key, cmd, opts)
    local options = {}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, key, cmd, options)
end

---@return string
function M.get_root()
    local path = vim.loop.fs_realpath(vim.api.nvim_buf_get_name(0))
    ---@type string[]
    local roots = {}
    if path ~= "" then
        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace
                    and vim.tbl_map(function(ws)
                        return vim.uri_to_fname(ws.uri)
                    end, workspace)
                or client.config.root_dir and { client.config.root_dir }
                or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
end

function M.version()
    local v = vim.version()
    if v and not v.prerelease then
        vim.notify(
            ("Neovim v%d.%d.%d"):format(v.major, v.minor, v.patch),
            vim.log.levels.WARN,
            { title = "Neovim: not running nightly!" }
        )
    end
end

return M
