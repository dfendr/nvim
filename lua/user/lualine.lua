local status_ok, lualine = pcall(require, "lualine")
local notification       = require("notify.service.notification")
if not status_ok then
    return
end

-- A lot of this stolen from chris@machine & devaslife
-- TODO work on this guy some more. Can do some cool stuff

--- Colors -----
local lualine_scheme = "gruvbox_baby_custom"

local colors = {
    dark = "#202020",
    foreground = "#ebdbb2",
    bg = "#282828",
    bg_dark = "#242424",
    bg_light = "#32302f",
    medium_gray = "#504945",
    comment = "#665c54",
    gray = "#DEDEDE",
    yellow = "#EEBD35",
    dark_green = "#98971a",
    orange = "#d65d0e",
    red = "#cc241d",
    magenta = "#b16286",
    pink = "#D4879C",
    light_blue = "#7fa2ac",
    dark_gray = "#83a598",
    blue_gray = "#458588",
    green = "#689d6a",
    light_green = "#8ec07c",
    white = "#E7D7AD",
}

if lualine_scheme == "gruvbox" then
    colors.gray = "#928374"
    colors.dark_gray = "#3c3836"
    colors.red = "#cc241d"
    colors.blue = "#458588"
    colors.green = "#427b58"
    colors.cyan = "#8ec07c"
    colors.orange = "#fe8019"
    colors.indent = "#fe8019"
    colors.indent = "#CE9178"
    colors.yellow = "#d5c4a1"
    colors.yellow_orange = "#bdae93"
    colors.purple = "#b16286"
end

if lualine_scheme == "gruvbox_baby_custom" then
    colors.dark = "#202020"
    colors.foreground = "#ebdbb2"
    colors.bg = "#282828"
    colors.bg_dark = "#242424"
    colors.bg_light = "#32302f"
    colors.medium_gray = "#504945"
    colors.comment = "#665c54"
    colors.gray = "#DEDEDE"
    colors.yellow = "#EEBD35"
    colors.dark_green = "#98971a"
    colors.orange = "#d65d0e"
    colors.red = "#cc241d"
    colors.magenta = "#b16286"
    colors.pink = "#D4879C"
    colors.light_blue = "#7fa2ac"
    colors.dark_gray = "#83a598"
    colors.blue_gray = "#458588"
    colors.green = "#689d6a"
    colors.light_green = "#8ec07c"
    colors.white = "#E7D7AD"
end

-- Table that's used in functions to dynamically sets component colors based on mode
local mode_color = {
    n = colors.dark_green,
    i = colors.yellow,
    v = colors.orange,
    [""] = colors.orange,
    V = colors.orange,
    c = colors.medium_gray,
    no = "",
    s = colors.pink,
    S = colors.pink,
    [""] = colors.pink,
    ic = "",
    R = colors.red,
    Rv = "",
    cv = "",
    ce = "",
    r = colors.red,
    rm = "",
    ["r?"] = "",
    ["!"] = "",
    t = "",
}

local daylight = require("user.functions").daylight() -- check time

-- change colors based on time (only normal mode atm)
function n_time_colors()
    if daylight then
        mode_color.n = colors.dark_green
        return colors.dark_green
    else
        mode_color.n = colors.blue_gray
        return colors.blue_gray
    end
end

-- Change the colors over
n_time_colors()

--[[ Mode Icons:     盛滛            ]]
local function day_icon_max()
    if daylight then
        return "  "
    else
        return "  "
    end
end

local function day_icon()
    if daylight then
        return ""
    else
        return ""
    end
end

--

local gruvbox_baby_custom = {
    normal = {
        a = { fg = colors.bg, bg = n_time_colors() },
        b = { fg = mode_color.n },
        c = { fg = mode_color.n },
    },

    insert = {
        a = { fg = colors.bg, bg = mode_color.i },
        b = { fg = mode_color.i },
        c = { fg = mode_color.i },
    },
    visual = {
        a = { fg = colors.bg, bg = mode_color.v },
        b = { fg = mode_color.v },
        c = { fg = mode_color.v },
    },

    visual_block = {
        a = { fg = colors.bg, bg = mode_color.i },
        b = { fg = mode_color.v },
        c = { fg = mode_color.v },
    },
    replace = {
        a = { fg = colors.bg, bg = mode_color.r },
        b = { fg = mode_color.r },
        c = { fg = mode_color.r },
    },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
    },
    command = {
        a = { fg = colors.bg, bg = mode_color.c },
        b = { fg = mode_color.c },
        c = { fg = mode_color.c },
    },
}

local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

local function hide_in_width(width)
    return function()
        return vim.fn.winwidth(0) > width
    end
end

local hl_str = function(str, hl) -- Highlight string
    return "%#" .. hl .. "#" .. str .. "%*"
end

-- check if value in table
local function contains(t, value)
    for _, v in pairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

---------------- Sections-----------------
-- Change mode string
--[[ Mode Icons:     盛滛            ]]
local mode = {
    day_icon_max,
    -- color = function()
    --     -- auto change color according to neovims mode
    --     return { fg = mode_color[vim.fn.mode()] }
    -- end,
    color = function()
        -- auto change color according to neovims mode
        return { bg = mode_color[vim.fn.mode()] }
    end,
    padding = 0,
    on_click = function()
        vim.cmd("Alpha")
    end,
}

-------------------------------------------------------------------------------
-------------------------------LSP---------------------------------------------

local lsp_info = {
    -- Lsp server name .
    function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = " LSP:",
    color = { fg = colors.white, gui = "bold" },
    padding = 1,
}

-- Diagnostics
local diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " " },
    colored = true,
    update_in_insert = false,
    always_visible = false,
    on_click = function()
        vim.cmd("TroubleToggle")
    end,
}

--------------------------------------------------------------------
------------------------------- Git --------------------------------
local diff = {
    "diff",
    colored = true,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    always_visible = false,
    cond = hide_in_width(80),
    source = diff_source(),
    on_click = function()
        vim.cmd("Gitsigns diffthis HEAD")
    end,
}
local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
    fmt = function(str)
        if str == "" or str == nil then
            return "!=vcs"
        end
        return str
    end,
    on_click = function()
        vim.cmd("lua _GITUI_TOGGLE()")
    end,
}

------------------------------------------------------------------------------
---------------------------File Format/Type-----------------------------------
local fileformat = {
    "fileformat",
    icons_enabled = true,
    symbols = {
        unix = "", -- usually LF, blank if so
        dos = "CRLF",
        mac = "CR",
    },
    color = function()
        -- auto change color according to neovims mode
        return { fg = mode_color[vim.fn.mode()] }
    end,
}

local filetype = {
    "filetype",
    icons_enabled = true,
    icon = nil,
    always_visible = false,
    cond = hide_in_width(80),
    color = function()
        -- auto change color according to neovims mode
        return { fg = mode_color[vim.fn.mode()] }
    end,
}

-------------------------------------------------------------------------------
-----------------------------FILE Components-----------------------------------
local encoding_str = function()
    local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
    return ret
end

local encoding = {
    encoding_str,
    padding = 0,
    always_visible = false,
    cond = hide_in_width(80),
    color = function()
        -- auto change color according to neovims mode
        return { bg = mode_color[vim.fn.mode()] }
    end,
}
local location = {
    "location",
    -- separator = {right = "" },
    padding = 1,
    always_visible = false,
    cond = hide_in_width(80),
    fmt = function(str)
        return " " .. str
    end,
}

local function open_explorer()

    if vim.fn.has("mac") == 1 then
        return vim.cmd("TermExec cmd='open %:h'")
    elseif vim.fn.has("win32") == 1 then
        return vim.cmd("TermExec cmd='start .'")
    else
        return vim.cmd("TermExec cmd='nautilus .'")
    end
end

local filename = {
    "filename",
    always_visible = false,
    cond = hide_in_width(80),
    -- fmt = function(str)
    --     return "  "..str
    -- end,
    on_click = function()
        open_explorer()
        vim.cmd("q")
    end,
}

-------------------------------------------------------------------------------
-----------------------------Clock-----------------------------------------

local function clock()
    local date_str = os.date("%-H:%M")
    local day_icon_str = day_icon()
    return date_str .. " " .. day_icon_str
end

-------------------------------------------------------------------------------
-----------------------------MISC-----------------------------------------
local function window() -- Display window number
    return vim.api.nvim_win_get_number(0)
end

local function os_icon()
    local icons = {
        unix = "", -- e712
        dos = "", -- e70f
        mac = "", -- e711
    }
    if vim.fn.has("mac") == 1 then
        return icons.mac
    elseif vim.fn.has("win32") == 1 then
        return icons.dos
    else
        return icons.unix
    end
end
-- Get current theme
local vimtheme = vim.api.nvim_command_output("colo")
-------------------------------------------------------------------------------

local theme = lualine.setup({
    options = {
        globalstatus = true,
        icons_enabled = true,
        theme = gruvbox_baby_custom,
        -- theme = gruvbox,
        --component_separators = { left = '', right = ''},
        --section_separators = { left = '', right = ''},
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {
            { "alpha", "NvimTree", "dashboard" },
        },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff },
        lualine_c = { diagnostics },
        lualine_x = { filename, filetype, encoding, fileformat },
        lualine_y = { location, { "progress" } },
        lualine_z = { { clock } },
    },

    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = {},
    },
})
