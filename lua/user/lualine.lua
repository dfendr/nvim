local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

-- A lot of this stolen from chris@machine & devaslife
-- TODO work on this guy some more. Can do some cool stuff

--- Colors -----

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
    n = gray,
    i = blue,
    v = orange,
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

-- Change mode string
--[[ Mode Icons:           ]]
local mode = {
    -- mode component
    function()
        -- return "▊"
        return "  "
        -- return "  "
    end,
    color = function()
        -- auto change color according to neovims mode
        return { fg = mode_color[vim.fn.mode()], bg = gray }
    end,
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
            statusline = {
                { "alpha", "NvimTree" },
            },
            winbar = {
            },
        },
        -- disabled_filetype = { "alpha", "NvimTree" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { mode },
        lualine_b = { branch, diff },
        lualine_c = { diagnostics, "filename" },
        lualine_x = { "encoding", filetype },
        lualine_y = { "progress" },
        lualine_z = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
})
