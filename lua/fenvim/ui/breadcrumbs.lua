local icons = require("fenvim.ui.icons")

local M = {}
M.options = {
    winbar_filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neo-tree",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "Jaq",
        "harpoon",
        "dap-repl",
        "dap-terminal",
        "dapui_console",
        "dapui_hover",
        "lab",
        "notify",
        "noice",
        "neotest-summary",
        "",
    },
}

M.setup = function()
    M.create_winbar()
end

M.get_filename = function()
    local filename = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")
    local f = require("utils.functions")

    if not f.isempty(filename) then
        local file_icon, hl_group
        local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
        if devicons_ok then
            file_icon, hl_group = devicons.get_icon(filename, extension, { default = true })

            if f.isempty(file_icon) then
                file_icon = icons.File
            end
        else
            file_icon = ""
            hl_group = "Normal"
        end

        local buf_ft = vim.bo.filetype

        if buf_ft == "dapui_breakpoints" then
            file_icon = icons.ui.Bug
        end

        if buf_ft == "dapui_stacks" then
            file_icon = icons.ui.Stacks
        end

        if buf_ft == "dapui_scopes" then
            file_icon = icons.ui.Scopes
        end

        if buf_ft == "dapui_watches" then
            file_icon = icons.ui.Watches
        end

        if buf_ft == "dapui_console" then
            file_icon = icons.ui.DebugConsole
        end

        local navic_text = vim.api.nvim_get_hl(0, { name = "Normal" })
        vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

        return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
    end
end

local get_gps = function()
    local status_gps_ok, gps = pcall(require, "nvim-navic")
    if not status_gps_ok then
        return ""
    end

    local status_ok, gps_location = pcall(gps.get_location, {})
    if not status_ok then
        return ""
    end

    if not gps.is_available() or gps_location == "error" then
        return ""
    end

    if not require("utils.functions").isempty(gps_location) then
        return "%#NavicSeparator#" .. icons.ui.ChevronRight .. "%* " .. gps_location
    else
        return ""
    end
end

local excludes = function()
    return vim.tbl_contains(M.options.winbar_filetype_exclude or {}, vim.bo.filetype)
end

M.get_winbar_navic = function()
    if excludes() then
        return
    end
    local f = require("utils.functions")
    local value = M.get_filename()

    if not f.isempty(value) and f.get_buf_option("mod") then
        local mod = "%#LspCodeLens#" .. " *" .. "%*"
        value = value .. mod
    end

    local num_tabs = #vim.api.nvim_list_tabpages()

    if num_tabs > 1 and not f.isempty(value) then
        local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
        value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
    end

    local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
    if not status_ok then
        return
    end
end

M.create_winbar = function()
    vim.api.nvim_create_augroup("_winbar", {})
    vim.api.nvim_create_autocmd({
        "CursorHoldI",
        "CursorHold",
        "BufWinEnter",
        "BufFilePost",
        "InsertEnter",
        "BufWritePost",
        "TabClosed",
        "TabEnter",
    }, {
        group = "_winbar",
        callback = function()
            local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
            if not status_ok then
                M.get_winbar_navic()
            end
        end,
    })
end

return M
