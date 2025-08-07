return {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    dependencies = { "meuter/lualine-so-fancy.nvim" },
    config = function()
        local ok, lualine = pcall(require, "lualine")
        if not ok then
            return
        end

        local funcs = require("core.functions")
        local daylight = funcs.daylight()

        local function day_icon_left()
            return daylight and " 󰉊 " or "  "
        end

        local function day_icon_right()
            return daylight and "󰖨" or ""
        end

        local function diff_source()
            local gitsigns = require("plugins.ui.icons").git
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

        local function contains(t, value)
            for _, v in pairs(t) do
                if v == value then return true end
            end
            return false
        end

        local mode = { day_icon_left, padding = 0, on_click = function() vim.cmd("Alpha") end }

        local diagnostics = {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            sections = { "error", "warn" },
            symbols = { error = " ", warn = " " },
            cond = hide_in_width(60),
            colored = false,
            update_in_insert = false,
            always_visible = false,
            on_click = function() vim.cmd("TroubleToggle") end,
        }

        local lsp_servers = {
            "lsp_icon",
            cond = function() return hide_in_width(100)() end,
        }

        local diff = {
            "diff",
            colored = true,
            cond = hide_in_width(80),
            source = diff_source(),
            on_click = function() vim.cmd("Gitsigns diffthis HEAD") end,
        }

        local branch = {
            "branch",
            icons_enabled = true,
            icon = "",
            fmt = function(str) return (str == "" or not str) and "!=vcs" or str end,
            cond = hide_in_width(50),
            on_click = function() vim.cmd("lua _LAZYGIT_TOGGLE()") end,
        }

        local fileformat = {
            "fileformat",
            symbols = { unix = "", dos = "CRLF ", mac = "CR " },
        }

        local filetype = {
            "filetype",
            icons_enabled = true,
            icon = nil,
            cond = hide_in_width(80),
        }

        local encoding = {
            function()
                local ret = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
                return ret
            end,
            padding = 0,
            cond = hide_in_width(80),
        }

        local location = { "location", padding = 1, cond = hide_in_width(40) }
        local progress = { "progress", padding = 1, cond = hide_in_width(60) }

        local filename = {
            "filename",
            cond = function()
                return hide_in_width(30)() and not require("core.prefs").ui.winbar_title
            end,
            on_click = function() funcs.open_explorer() end,
        }

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
            if not mixed then return "" end
            if mixed_same_line and mixed_same_line > 0 then return "MI:" .. mixed_same_line end
            local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
            local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total
            return "MI:" .. ((space_indent_cnt > tab_indent_cnt) and tab_indent or space_indent)
        end

        local function clock()
            return os.date("%-H:%M") .. " " .. day_icon_right()
        end

        local spaces = {
            function()
                local buf_ft = vim.bo.filetype
                local ui_filetypes = {
                    "", "DressingSelect", "NvimTree", "Outline", "Trouble",
                    "alpha", "prompt", "TelescopePrompt", "Telescope",
                    "help", "lir", "neogitstatus", "packer", "spectre_panel",
                }
                if contains(ui_filetypes, buf_ft) then return "" end
                local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
                if not shiftwidth or shiftwidth == 4 then return "" end
                return " " .. shiftwidth .. " "
            end,
            cond = hide_in_width(75),
            padding = 0,
        }

        local wordcount = {
            "words",
            cond = function()
                local ft = vim.bo.filetype
                local count = { latex = true, tex = true, text = true, txt = true, markdown = true, vimwiki = true, neorg = true }
                return hide_in_width(60)() and count[ft] ~= nil
            end,
            fmt = function()
                if vim.fn.mode():match("[vV\22]") then
                    return "Selected: " .. (vim.fn.wordcount().visual_words or 0) .. " words"
                end
                return "Words: " .. vim.fn.wordcount().words .. " words"
            end,
        }

        lualine.setup({
            options = {
                globalstatus = true,
                icons_enabled = true,
                theme = "auto",
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                disabled_filetypes = { "alpha", "NvimTree", "dashboard" },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { branch, diff },
                lualine_c = { diagnostics },
                lualine_x = { lsp_servers, filename, encoding, fileformat },
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
    end,
}

