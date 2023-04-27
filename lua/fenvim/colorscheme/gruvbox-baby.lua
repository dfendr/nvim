local M = {} -- Example config in Lua

function M.config()
    vim.o.termguicolors = false
    vim.g.gruvbox_baby_background_color = "dark"

    -- Enable telescope theme
    vim.g.gruvbox_baby_telescope_theme = false
    vim.g.gruvbox_baby_transparent_mode = false
    vim.g.gruvbox_baby_comment_style = { nil }
    -- vim.g.gruvbox_baby_function_style = {"bold" }
    vim.g.gruvbox_baby_function_style = { nil }
    vim.g.gruvbox_baby_keyword_style = "NONE"
    vim.g.gruvbox_baby_use_original_palette = true

    vim.cmd("hi @neorg.markup.strikethrough gui=strikethrough")

    local colorscheme = "gruvbox-baby"
    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not status_ok then
        vim.notify("colorscheme " .. colorscheme .. " not found!")
        return
    end
end
return M
