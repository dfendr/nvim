local M = {}

function M.config()
    local status_ok, lualine = pcall(require, "lualine")
    -- TODO: work on this guy some more. Can do some cool stuff
    local lualine_scheme = vim.api.nvim_command_output("colo")
    local colors = {
        dark = "#202020",
        foreground = "#EBDBB2",
        bg = "#282828",
        bg_dark = "#242424",
        bg_light = "#32302F",
        medium_gray = "#504945",
        comment = "#665C54",
        gray = "#DEDEDE",
        yellow = "#EEBD35",
        dark_green = "#98971A",
        orange = "#D65D0E",
        red = "#cc241d",
        magenta = "#B16286",
        pink = "#D4879C",
        light_blue = "#7FA2AC",
        dark_gray = "#83A598",
        blue_gray = "#458588",
        green = "#689D6A",
        light_green = "#8EC07C",
        white = "#E7D7AD",
        white2 = "#D5C4A1",
        white3 = "#BDAE93",
    }

    if lualine_scheme == "gruvbox" then
        colors.gray = "#928374"
        colors.dark_gray = "#3c3836"
        colors.red = "#CC241D"
        colors.blue = "#458588"
        colors.green = "#427b58"
        colors.cyan = "#8ec07c"
        colors.orange = "#FE8019"
        colors.indent = "#fe8019"
        colors.indent = "#CE9178"
        colors.yellow = "#d5c4a1"
        colors.yellow_orange = "#BDAE93"
        colors.purple = "#b16286"
    end

    if lualine_scheme == "gruvbox-baby" then
        colors.dark = "#202020"
        colors.foreground = "#EBDBB2"
        colors.bg = "#282828"
        colors.bg_dark = "#242424"
        colors.bg_light = "#32302F"
        colors.medium_gray = "#504945"
        colors.comment = "#665C54"
        colors.gray = "#DEDEDE"
        colors.yellow = "#EEBD35"
        colors.dark_green = "#98971A"
        colors.orange = "#D65D0E"
        colors.red = "#CC241D"
        colors.magenta = "#B16286"
        colors.pink = "#D4879C"
        colors.light_blue = "#7fA2AC"
        colors.dark_gray = "#83A598"
        colors.blue_gray = "#458588"
        colors.green = "#689D6A"
        colors.light_green = "#8EC07C"
        colors.white = "#E7D7AD"
    end

    -- Table that's used in functions to dynamically sets component colors based on mode
    local mode_color = {
        n = colors.comment,
        i = colors.dark_green,
        v = colors.orange,
        [""] = colors.orange,
        V = colors.orange,
        c = colors.pink,
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
        ["!"] = colors.light_blue,
        t = "",
        text = colors.white,
    }

    local funcs = require("utils.functions")
    local daylight = funcs.daylight() -- check time

    -- change colors based on time (only normal mode atm)
    local function n_time_colors()
        if daylight then
            mode_color.n = colors.comment
            -- mode_color.n = colors.dark_green
            mode_color.text = colors.white
            return
        else
            mode_color.n = colors.comment
            -- mode_color.n = colors.blue_gray
            mode_color.text = colors.white2
            return colors.comment
        end
    end

    --[[ Mode Icons:     盛滛      ]]
    -- "  "
    -- "  "
    local function day_icon_max()
        if daylight then
            return "  "
        else
            return "  "
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
    local darker_green = (funcs.fade_RGB(colors.blue_gray, colors.bg_dark, 90)) -- TODO: finish the fade function

    local background = colors.bg_dark
    -- Maybe use these differently than just aliases?
    local c_color = mode_color.c
    local gruvbox_baby_custom = {
        normal = {
            a = { fg = colors.bg, bg = mode_color.n },
            b = { fg = mode_color.text, bg = funcs.fade_RGB(mode_color.n, background, 90) },
            c = {
                fg = mode_color.text, --[[ bg = funcs.fade_RGB(n_color, background, 95) ]]
            },
            -- z= { fg = mode_color.text },
        },

        insert = {
            a = { fg = colors.bg, bg = mode_color.i },
            b = { fg = mode_color.text, bg = funcs.fade_RGB(mode_color.i, background, 90) },
            c = { fg = mode_color.text },
        },
        visual = {
            a = { fg = colors.bg, bg = mode_color.v },
            b = { fg = mode_color.text, bg = funcs.fade_RGB(mode_color.v, background, 90) },
            c = { fg = mode_color.text },
        },

        visual_block = {
            a = { fg = colors.bg, bg = mode_color.v },
            b = { fg = mode_color.text, bg = funcs.fade_RGB(mode_color.v, background, 90) },
            c = { fg = mode_color.text },
        },
        replace = {
            a = { fg = colors.bg, bg = mode_color.r },
            b = { fg = mode_color.text, bg = funcs.fade_RGB(mode_color.r, background, 90) },
            c = { fg = mode_color.text },
        },

        inactive = {
            a = { fg = colors.white, bg = colors.black },
            b = { fg = mode_color.text },
            c = { fg = mode_color.text },
        },
        command = {
            a = { fg = colors.bg, bg = mode_color.c },
            b = { fg = mode_color.text, bg = funcs.fade_RGB(mode_color.c, background, 90) },
            c = { fg = mode_color.text },
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
        -- color = function()
        --     -- auto change color according to neovims mode
        --     return { bg = mode_color[vim.fn.mode()] }
        -- end,
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
        cond = hide_in_width(60),
        colored = false,
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
        -- symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
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
        cond = hide_in_width(60),
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
            -- unix = "LF " , -- usually LF, blank if so
            unix = "", -- usually LF, blank if so
            dos = "CRLF ",
            mac = "CR ",
        },
        -- color = function()
        --     -- auto change color according to neovims mode
        --     return { fg = mode_color[vim.fn.mode()] }
        -- end,
    }

    local filetype = {
        "filetype",
        icons_enabled = true,
        icon = nil,
        always_visible = false,
        cond = hide_in_width(80),
        -- color = function()
        --     -- auto change color according to neovims mode
        --     return { fg = mode_color[vim.fn.mode()] }
        -- end,
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
        padding = 1,
        always_visible = false,
        cond = hide_in_width(40),
        fmt = function(str)
            -- return " " .. str
            return str
        end,
    }

    local progress = {
        "progress",
        padding = 1,
        always_visible = false,
        cond = hide_in_width(60),

        fmt = function(str)
            -- return " " .. str
            return str
        end,
    }

    local filename = {
        "filename",
        always_visible = false,
        cond = hide_in_width(80),
        on_click = function()
            -- funcs.open_explorer()
            -- vim.cmd("q")
        end,
    }

    ---------------------------------------------------------------------------
    -----------------------------Clock-----------------------------------------

    local function clock()
        local date_str = os.date("%-H:%M")
        local day_icon_str = day_icon()
        return date_str .. " " .. day_icon_str
    end

    local clock_comp = {
        clock,
        color = function()
            -- auto change color according to neovims mode
            return { bg = mode_color[vim.fn.mode()] }
        end,
    }

    ---------------------------------------------------------------------------
    -----------------------------Spaces----------------------------------------
    local spaces = {
        function()
            local buf_ft = vim.bo.filetype

            local ui_filetypes = {
                "help",
                "packer",
                "neogitstatus",
                "NvimTree",
                "Trouble",
                "lir",
                "Outline",
                "spectre_panel",
                "DressingSelect",
                "",
            }
            local space = ""

            if contains(ui_filetypes, buf_ft) then
                space = " "
            end

            local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")

            if shiftwidth == nil or shiftwidth == 4 then
                return ""
            end

            return " " .. shiftwidth .. space .. " "
        end,
        padding = 0,
    }
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

    local wordcount = {
        "words",
        cond = function()
            local ft = vim.opt_local.filetype:get()
            local count = {
                latex = true,
                tex = true,
                text = true,
                txt = true,
                markdown = true,
                vimwiki = true,
                neorg = true,
            }
            return count[ft] ~= nil
        end,
        fmt = function()
            local words = vim.fn.wordcount()["words"]
            return "Words: " .. words
        end,
    }

    -------------------------------------------------------------------------------
    -----------------------------Treesitter Icon------------------------------
    --TODO:Finish this function and apply to statusbar
    -- local treesitter = {
    --     function()
    --         return ""
    --     end,
    --     color = function()
    --         local buf = vim.api.nvim_get_current_buf()
    --         local ts = vim.treesitter.highlighter.active[buf]
    --         return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
    --     end,
    --     cond = conditions.hide_in_width,
    -- }
    -------------------------------------------------------------------------------
    ------------------------------Auto Theme application---------------------------

    -- Get current theme
    -- TODO: Fix the auto-custom theme change.
    local vimtheme = vim.api.nvim_command_output("colo")
    local lualine_theme = auto
    if vimtheme == "gruvbox-baby" then
        lualine_theme = gruvbox_baby_custom
    end

    ---------------------------------------------------------------------------
    --------------------------Lualine Setup------------------------------------

    lualine.setup({
        options = {
            globalstatus = true,
            icons_enabled = true,
            theme = lualine_theme,
            -- component_separators = { left = '', right = ''},
            -- section_separators = { left = '', right = ''},
            section_separators = { left = "", right = "" },
            component_separators = { left = "", right = "" },
            -- section_separators = { left = "", right = "" },
            -- component_separators = { left = "", right = "" },
            disabled_filetypes = {
                { "alpha", "NvimTree", "dashboard" },
            },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { mode },
            lualine_b = { branch, diff },
            lualine_c = { diagnostics },
            lualine_x = {
                -- filename, --[[ filetype, ]]
                encoding,
                fileformat,
            },
            lualine_y = { wordcount, spaces, location, progress },
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
end
return M
