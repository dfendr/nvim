local M = {} -- Example config in Lua

function M.config()
    vim.o.termguicolors = false
    vim.g.fenbox_background_color = "dark"

    -- Enable telescope theme
    vim.g.fenbox_telescope_theme = false
    vim.g.fenbox_transparent_mode = false
    vim.g.fenbox_comment_style = { nil }
    vim.g.fenbox_function_style = {"bold" }
    -- vim.g.fenbox_function_style = { nil }
    vim.g.fenbox_keyword_style = "NONE"
    vim.g.fenbox_use_original_palette = true

    vim.cmd("hi @neorg.markup.strikethrough gui=strikethrough")

    local colorscheme = "fenbox"
    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not status_ok then
        vim.notify("colorscheme " .. colorscheme .. " not found!")
        return
    end
end
return M
