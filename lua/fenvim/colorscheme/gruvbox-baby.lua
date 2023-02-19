local M = {} -- Example config in Lua

--vim.g.gruvbox_baby_function_style = "NONE"
--vim.g.gruvbox_baby_keyword_style = "italic"
function M.config()
    local dark = "#202020"
    local foreground = "#ebdbb2"
    local background = "#282828"
    local background_dark = "#242424"
    local bg_light = "#32302f"
    local medium_gray = "#504945"
    local comment = "#665c54"
    local gray = "#DEDEDE"
    local soft_yellow = "#EEBD35"
    local soft_green = "#98971a"
    local bright_yellow = "#fabd2f"
    local orange = "#d65d0e"
    local red = "#fb4934"
    local error_red = "#cc241d"
    local magenta = "#b16286"
    local pink = "#D4879C"
    local light_blue = "#7fa2ac"
    local dark_gray = "#83a598"
    local blue_gray = "#458588"
    local forest_green = "#689d6a"
    local clean_green = "#8ec07c"
    local milk = "#E7D7AD"

    -- OG Gruvbox
    local og_orange2 = "#FE8019"
    --  gruvbox = [
    -- (40, 40, 40),     # black
    -- (146, 131, 116),  # gray1
    -- (204, 36, 29),    # red1,
    -- (251, 73, 52),    # red2,
    -- (152, 151, 26),   # green1
    -- (184, 187, 38),   # green2
    -- (215, 153, 33),   # yellow1
    -- (250, 189, 47),   # yellow2
    -- (69, 133, 136),   # blue1
    -- (131, 165, 152),  # blue2
    -- (177, 98, 134),   # purple1
    -- (104, 157, 106),  # purple2
    -- (142, 192, 124),  # aqua1
    -- (168, 153, 132),  # aqua2
    -- (235, 219, 178),  # gray2
    -- (214, 93, 14),    # orange1
    -- (254, 128, 25),   # orange2

    -- Dark theme changes colors to
    -- ["dark"] = {
    --       dark = "#161616",
    --       background = "#202020",
    --       background_dark = "#161616",
    --     },
    --]]
    -- Each highlight group must follow the structure:
    -- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
    -- See also :h highlight-guifg
    -- Example:

    local colors = require("gruvbox-baby.colors").config()

    vim.o.termguicolors = false
    vim.g.gruvbox_baby_background_color = "dark"

    -- Enable telescope theme
    vim.g.gruvbox_baby_telescope_theme = false
    vim.g.gruvbox_baby_transparent_mode = false
    vim.g.gruvbox_baby_comment_style = { style = nil}
    vim.g.gruvbox_baby_function_style = { style = "bold" }
    vim.g.gruvbox_baby_keyword_style = "NONE"
    vim.g.gruvbox_baby_use_original_palette = true
    local colorscheme = "gruvbox-baby"
    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not status_ok then
        vim.notify("colorscheme " .. colorscheme .. " not found!")
        return
    end
end
return M
