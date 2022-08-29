local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

-- A lot of this stolen from chris@machine & devaslife
-- TODO work on this guy some more. Can do some cool stuff

--- Colors -----

-- local gray = "#32363e"
-- local dark_gray = "#282C34"
-- local dark_gray = "#282C34"
-- local red = "#D16969"
-- local blue = "#569CD6"
-- local green = "#6A9955"
-- local cyan = "#4EC9B0"
-- local orange = "#CE9178"
-- local indent = "#CE9178"
-- local yellow = "#DCDCAA"
-- local yellow_orange = "#D7BA7D"
-- local purple = "#C586C0"

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

local lualine_scheme = "gruvbox"

if lualine_scheme == "gruvbox" then
    local gray = "#928374"
    local dark_gray = "#3c3836"
    local red = "#cc241d"
    local blue = "#458588"
    local green = "#427b58"
    local cyan = "#8ec07c"
    local orange = "#fe8019"
    local indent = "#fe8019"
    local indent = "#CE9178"
    local yellow = "#d5c4a1"
    local yellow_orange = "#bdae93"
    local purple = "#b16286"
end

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = dark_gray })
vim.api.nvim_set_hl(0, "SLTermIcon", { fg = purple, bg = gray })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#abb2bf", bg = dark_gray, bold = false })
vim.api.nvim_set_hl(0, "SLProgress", { fg = purple, bg = gray })
vim.api.nvim_set_hl(0, "SLLocation", { fg = blue, bg = gray })
vim.api.nvim_set_hl(0, "SLFT", { fg = cyan, bg = gray })
vim.api.nvim_set_hl(0, "SLIndent", { fg = indent, bg = gray })
vim.api.nvim_set_hl(0, "SLLSP", { fg = "#6b727f", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLSep", { fg = gray, bg = "NONE" })
vim.api.nvim_set_hl(0, "SLFG", { fg = "#abb2bf", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#6b727f", bg = "NONE", italic = true })
vim.api.nvim_set_hl(0, "SLError", { fg = "#bf616a", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLWarning", { fg = "#D7BA7D", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = "NONE" })

-- TODO Change these colors to match gruvbox

local mode_color = {
    n = blue,
    i = orange,
    v = "#b668cd",
    [""] = "#b668cd",
    V = "#b668cd",
    -- c = '#B5CEA8',
    -- c = '#D7BA7D',
    c = "#46a6b2",
    no = "#D16D9E",
    s = green,
    S = orange,
    [""] = orange,
    ic = red,
    R = "#D16D9E",
    Rv = red,
    cv = blue,
    ce = blue,
    r = red,
    rm = "#46a6b2",
    ["r?"] = "#46a6b2",
    ["!"] = "#46a6b2",
    t = red,
}

-- Helper Functions
local hide_in_width_60 = function() -- hide component when vim under width 80
    return vim.fn.winwidth(0) > 60
end

local hide_in_width = function() -- hide component when vim under width 80
    return vim.fn.winwidth(0) > 80
end

local hide_in_width_100 = function() -- hide component when vim under width 80
    return vim.fn.winwidth(0) > 100
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
    color = { fg = milk, gui = "bold" },
    padding = 1,
}

local left_pad = {
    function()
        return " "
    end,
    padding = 0,
    color = function()
        return { fg = gray }
    end,
}

local right_pad = {
    function()
        return " "
    end,
    padding = 0,
    color = function()
        return { fg = dark_gray }
    end,
}

local left_pad_alt = {
    function()
        return " "
    end,
    padding = 0,
    color = function()
        return { fg = gray }
    end,
}

local right_pad_alt = {
    function()
        return " "
    end,
    padding = 0,
    color = function()
        return { fg = gray }
    end,
}

-- Change icon based on time of day
local daylight = require("user.functions").daylight()
local function day_icon()
    if daylight then
        return "  "
    else
        return "  "
    end
end

-- Change mode string
--[[ Mode Icons:    盛滛            ]]
local mode = {
    -- mode component
    function()
        -- return "▊"
        return day_icon()
        -- return "  "
    end,
    -- color = function()
    --     -- auto change color according to neovims mode
    --     return { bg = mode_color[vim.fn.mode()], fg = gray }
    -- end,
    padding = 0,
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
}

-- Git diff signs
local diff = {
    "diff",
    colored = true,
    symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
    cond = hide_in_width,
}

local filetype = {
    "filetype",
    icons_enabled = true,
    icon = nil,
}

local branch = {
    "branch",
    icons_enabled = true,
    icon = "",
}

local location = {
    "location",
    padding = 0,
}

local filename = {
    file_status = true, -- display file status
    path = 0, -- just filename
}

local function window() -- Display window number
    return vim.api.nvim_win_get_number(0)
end

--local spaces = {
--  function()
--    local buf_ft = vim.bo.filetype
--
--    local ui_filetypes = {
--      "help",
--      "packer",
--      "neogitstatus",
--      "NvimTree",
--      "Trouble",
--      "lir",
--      "Outline",
--      "spectre_panel",
--      "DressingSelect",
--      "",
--    }
--    local space = ""
--
--    if contains(ui_filetypes, buf_ft) then
--      space = " "
--    end
--
--    local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
--
--    if shiftwidth == nil then
--      return ""
--    end
--
--    -- TODO: update codicons and use their indent
--    return hl_str(" ", "SLSep") .. hl_str(" " .. shiftwidth .. space, "SLIndent") .. hl_str("", "SLSep")
--  end,
--  padding = 0,
--  -- separator = "%#SLSeparator#" .. " │" .. "%*",
--  -- cond = hide_in_width_100,
--}

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
local navic = require("nvim-navic")

local theme = lualine.setup({
    options = {
        globalstatus = true,
        icons_enabled = true,
        -- theme = "gruvbox",
        --component_separators = { left = '', right = ''},
        --section_separators = { left = '', right = ''},
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {
            { "alpha", "NvimTree", "dashboard" },
        },
        always_divide_middle = true,
    },
    sections = { -- Backup while I fuck with stuff
        lualine_a = { mode },
        lualine_b = { branch, diff },
        lualine_c = { "filename", diagnostics },
        lualine_x = { "encoding", filetype },
        lualine_y = { "location", "progress" },
        lualine_z = {{'os.date("%-H:%M")', color = {gui='NONE'}}}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = {},
    },
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{navic.get_location, cond = navic.is_available},},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
})
