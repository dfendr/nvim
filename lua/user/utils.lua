-- Lua Utility Functions

local M = {}

-- Keybind mapping function
function M.map(mode, key, cmd, opts)
    local options = { }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, key, cmd, options)
end




return M
