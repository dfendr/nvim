
local M = {}
function M.config()
    local status_ok, bufferline = pcall(require, "dropbar")
    if not status_ok then
        return
    end
end
return M
