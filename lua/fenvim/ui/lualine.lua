local M = {}

function M.config()
    local status_ok, lualine = pcall(require, "lualine")

    local funcs = require("utils.functions")
    local daylight = funcs.daylight() -- check time
    ------------------------------------------------------------------------

    --[[ Mode Icons:           ]]
    -- " 󰉊  󰉊 "
    -- "    "

    local function day_icon_max()
        if daylight then
            return " 󰉊 "
        else
            return "  "
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
    local function diff_source()
        local gitsigns = require("fenvim.ui.icons").git
        if gitsigns then
            return {
                added = gitsigns.Add,
                modified = gitsigns.Diff,
                removed = gitsigns.Remove,
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
    --[[ Mode Icons: 󰉊    盛滛            ]]
    local mode = {
        day_icon_max,
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
        -- color = { fg = colors.white, gui = "bold" },
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
        cond = hide_in_width(50),
        on_click = function()
            vim.cmd("lua _LAZYGIT_TOGGLE()")
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
    }

    local filetype = {
        "filetype",
        icons_enabled = true,
        icon = nil,
        always_visible = false,
        cond = hide_in_width(80),
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
        cond = function()
            return hide_in_width(30)() and not require("core.prefs").ui.winbar_title
        end,
        on_click = function()
            funcs.open_explorer()
        end,
    }

    ---------------------------------------------------------------------------
    ---------------------------------------------------------[[ Mixed Indent ]]
    local function mixed_indent()
        local space_pat = [[\v^ +]]
        local tab_pat = [[\v^\t+]]
        local space_indent = vim.fn.search(space_pat, "nwc")
        local tab_indent = vim.fn.search(tab_pat, "nwc")
        local mixed = (space_indent > 0 and tab_indent > 0)
        local mixed_same_line
        if not mixed then
            mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], "nwc")
            mixed = mixed_same_line > 0
        end
        if not mixed then
            return ""
        end
        if mixed_same_line ~= nil and mixed_same_line > 0 then
            return "MI:" .. mixed_same_line
        end
        local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
        local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
        if space_indent_cnt > tab_indent_cnt then
            return "MI:" .. tab_indent
        else
            return "MI:" .. space_indent
        end
    end

    ---------------------------------------------------------------------------
    -----------------------------Clock-----------------------------------------

    local function clock()
        local date_str = os.date("%-H:%M")
        local day_icon_str = day_icon()
        return date_str .. " " .. day_icon_str
    end

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
            return " " .. shiftwidth .. space .. " "
        end,
        cond = hide_in_width(75),
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
            return hide_in_width(60)() and count[ft] ~= nil --and hide_in_width(60))
        end,
        fmt = function()
            local words = vim.fn.wordcount()["words"]
            return "Words: " .. words
        end,
    }

    ---------------------------------------------------------------------------
    --------------------------Lualine Setup------------------------------------

    lualine.setup({
        options = {
            globalstatus = true,
            icons_enabled = true,
            theme = "auto",
            -- component_separators = { left = '', right = ''},
            -- section_separators = { left = '', right = ''},
            -- section_separators = { left = "", right = "" },
            -- component_separators = { left = "", right = "" },
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
            lualine_x = {
                filename, --[[ filetype, ]]
                encoding,
                fileformat,
            },
            lualine_y = { wordcount, mixed_indent, spaces, location, progress },
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
