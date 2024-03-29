local M = {}

local function spinner_icon()
    if require("core.functions").daylight() then
        return "star"
    else
        return "moon"
    end
end

function M.config()
    local border_style = "none"
    local status_ok, ui_prefs = pcall(require, "core.prefs")
    if status_ok then
        border_style = ui_prefs.ui.fidget.border_style
    end
    require("fidget").setup({
        progress = {
            ignore_done_already = true, -- Ignore new tasks that are already complete
            display = {
                done_icon = "✔", -- character shown when all tasks are complete
                progress_icon = { pattern = spinner_icon(), period = 1 },
            },
        },
        notification = {
            -- Options related to the notification window and buffer
            window = {
                normal_hl = "Comment", -- Base highlight group in the notification window
                winblend = 0, -- Background color opacity in the notification window
                border = border_style, -- Border around the notification window
                zindex = 45, -- Stacking priority of the notification window
                max_width = 0, -- Maximum width of the notification window
                max_height = 0, -- Maximum height of the notification window
                x_padding = 1, -- Padding from right edge of window boundary
                y_padding = 0, -- Padding from bottom edge of window boundary
                align = "bottom", -- How to align the notification window
                relative = "editor", -- What the notification window position is relative to
            },
        },
        integration = {
            ["nvim-tree"] = {
                enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
            },
        },
    })
end
return M
