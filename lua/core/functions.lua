local M = {}

local merge_tb = vim.tbl_deep_extend

local function close_all_buffers_except_current()
    local current_buf_num = vim.api.nvim_get_current_buf()
    local buffers = vim.api.nvim_list_bufs()

    for _, buf_num in ipairs(buffers) do
        if
            vim.api.nvim_buf_is_loaded(buf_num)
            and vim.api.nvim_buf_is_valid(buf_num)
            and buf_num ~= current_buf_num
        then
            local buftype = vim.bo[buf_num].buftype
            if buftype ~= "terminal" then
                vim.api.nvim_buf_delete(buf_num, { force = false })
            end
        end
    end
end

vim.api.nvim_create_user_command("Bonly", close_all_buffers_except_current, {})

-- Used to retrieve $CONFIG/snippets path for scissors.nvim
function M.get_snippet_path()
    local config_path = vim.loop.fs_realpath(vim.fn.stdpath("config"))
    local snippet_relative_path = { "snippets" }
    local path_separator = package.config:sub(1, 1) -- Gets the path separator based on the OS
    local snippet_path =
        table.concat(vim.iter({ config_path, snippet_relative_path }):flatten():totable(), path_separator)
    return snippet_path
end

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

-- get length of current word
function M.get_word_length()
    local word = vim.fn.expand("<cword>")
    return #word
end

function M.toggle_option(option)
    local value = not vim.api.nvim_get_option_value(option, {})
    vim.opt[option] = value
    vim.notify(option .. " set to " .. tostring(value))
end

function M.toggle_tabline()
    local value = vim.api.nvim_get_option_value("showtabline", {})
    if value == 2 then
        value = 0
    else
        value = 2
    end

    vim.opt.showtabline = value

    vim.notify("showtabline" .. " set to " .. tostring(value))
end

function M.toggle_diagnostics()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

function M.isempty(s)
    return s == nil or s == ""
end

function M.format_buffer()
    if pcall(require, "conform") then
        -- conform is available, use it for formatting
        vim.cmd("lua require('conform').format({ lsp_fallback = true, async = false, timeout_ms = 500 })")
    else
        -- conform is not available, use LSP formatting
        vim.lsp.buf.format({ async = false })
    end
end

vim.api.nvim_create_user_command("FormatBuffer", M.format_buffer, {})

function M.convert_to_unix()
    -- First, remove ^M (carriage return characters)
    local choice = vim.fn.confirm("Confirm conversion to Unix?", "&Yes\n&No", 2)
    if choice == 1 then
        local cursor_position = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_command("%s/\\r//ge")
        vim.api.nvim_win_set_cursor(0, cursor_position)

        -- Then, convert the file from CRLF to LF
        local old_fileformat = vim.api.nvim_get_option_value("fileformat", { buf = 0 })
        vim.api.nvim_set_option_value("fileformat", "unix", { buf = 0 })
        if old_fileformat == "dos" then
            vim.api.nvim_command("write")
            vim.api.nvim_command("edit")
        end
    end
end

function M.convert_to_dos()
    -- Confirm the conversion before proceeding
    local choice = vim.fn.confirm("Confirm conversion to DOS?", "&Yes\n&No", 2)
    if choice == 1 then
        -- Convert the file from LF to CRLF
        local old_fileformat = vim.api.nvim_get_option_value("fileformat", { buf = 0 })
        vim.api.nvim_set_option_value("fileformat", "dos", { buf = 0 })
        if old_fileformat == "unix" then
            vim.api.nvim_command("write")
            vim.api.nvim_command("edit")
        end
    end
end

function M.smart_close()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_windows = vim.call("win_findbuf", bufnr)
    local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
    if modified and #buf_windows == 1 then
        local choice = vim.fn.confirm("You have unsaved changes. Quit anyway?", "&Yes\n&No", 2)
        if choice == 1 then
            vim.cmd("q!")
        end
    else
        vim.cmd("q!")
    end
end

function M.smart_exit()
    local bufnr = vim.api.nvim_get_current_buf()
    local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
    local buffers = vim.api.nvim_list_bufs()

    if not modified then
        for _, buf in ipairs(buffers) do
            if vim.api.nvim_get_option_value("modified", { buf = buf }) then
                vim.api.nvim_set_current_buf(buf)
                modified = true
                break
            end
        end
    end

    if modified then
        local choice = vim.fn.confirm("You have unsaved changes. Quit anyway?", "&Yes\n&No", 2)
        if choice == 1 then
            vim.cmd("qa!")
        end
    else
        vim.cmd("qa!")
    end
end
function M.wrap_in_quotes(string)
    return '"' .. string .. '"'
end

function M.open_explorer()
    local current_file_dir = vim.fn.expand("%:p:h")
    if vim.fn.has("mac") == 1 then
        vim.cmd("silent !open " .. current_file_dir)
    elseif vim.fn.has("win32") == 1 then
        vim.cmd("silent !start " .. current_file_dir)
    else
        vim.cmd("silent !xdg-open " .. current_file_dir)
    end
end

function M.code_action()
    local status, err = pcall(require("actions-preview").code_action)
    if not status then
        vim.lsp.buf.code_action()
    end
end

-- Keybind function shortcut
function M.map(mode, key, cmd, opts, desc, bufnr)
    local options = {}
    if type(desc) == "table" then
        opts = vim.tbl_extend("force", opts, desc)
    else
        if type(desc) == "string" then
            options.desc = desc
        end
    end

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    -- Check if cmd is a function and attach as a callback
    if type(cmd) == "function" then
        options.callback = cmd
        cmd = ""
    end

    vim.api.nvim_set_keymap(mode, key, cmd, options)

    -- Check if whichkey is available and a description is provided
    if pcall(require, "which-key") and type(desc) == "string" then
        local wk = require("which-key")
        local wk_opts = {
            mode = mode, -- NORMAL, VISUAL, INSERT, etc.
            prefix = "",
            buffer = bufnr, -- nil == Global
            silent = true,
            noremap = true,
            nowait = true,
        }
        local mappings = {
            [key] = { cmd, desc },
        }
        wk.add({ key, cmd, desc = desc }, { mode = mode })
        -- wk.register(mappings, wk_opts)
    end
end

function M.toggle_inlay_hints()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
end

function M.toggle_treesitter_local()
    local current_buf = vim.api.nvim_get_current_buf()

    if vim.treesitter.highlighter.active[current_buf] then
        -- Disable Tree-sitter highlighting
        vim.cmd("TSBufDisable highlight")
    else
        -- Enable Tree-sitter highlighting
        vim.cmd("TSBufEnable highlight")
    end
end

function M.toggle_treesitter_global()
    local current_buf = vim.api.nvim_get_current_buf()

    if vim.treesitter.highlighter.active[current_buf] then
        -- Disable Tree-sitter highlighting
        vim.cmd("TSDisable highlight")
    else
        -- Enable Tree-sitter highlighting
        vim.cmd("TSEnable highlight")
    end
end

function M.adjust_color(color, amount)
    color = vim.trim(color)
    color = color:gsub("#", "")
    local first = ("0" .. string.format("%x", (math.min(255, tonumber(color:sub(1, 2), 16) + amount)))):sub(-2)
    local second = ("0" .. string.format("%x", (math.min(255, tonumber(color:sub(3, 4), 16) + amount)))):sub(-2)
    local third = ("0" .. string.format("%x", (math.min(255, tonumber(color:sub(5, -1), 16) + amount)))):sub(-2)
    return "#" .. first .. second .. third
end

--- Picks a random element of a table
---@param table table
---@return any Random-element
-- https://github.com/max397574/omega-nvim/blob/master/lua/omega/utils/init.lua
function M.random_element(table)
    math.randomseed(os.clock())
    local index = math.random() * #table
    return table[math.floor(index) + 1]
end

--- Darkens a color by a certain value
---@param color string
---@param amount number
---@return string color
-- https://github.com/max397574/omega-nvim/blob/master/lua/omega/utils/init.lua
function M.darken_color(color, amount)
    return M.adjust_color(color, -amount)
end

--- Lightens a color by a certain value
---@param color string
---@param amount number
---@return string color
-- https://github.com/max397574/omega-nvim/blob/master/lua/omega/utils/init.lua
function M.lighten_color(color, amount)
    return M.adjust_color(color, amount)
end

function M.daylight()
    if tonumber(os.date("%H")) < 17 and 9 <= tonumber(os.date("%H")) then
        return true
    else
        return false
    end
end

-- http://www.indigorose.com/forums/threads/10192-Convert-Hexadecimal-to-Decimal
function M.Dec2Hex(nValue)
    if type(nValue) == "string" then
        nValue = tonumber(nValue)
    end
    local nHexVal = string.format("%X", nValue) -- %X returns uppercase hex, %x gives lowercase letters
    local sHexVal = nHexVal .. ""
    if nValue < 16 then
        return "0" .. tostring(sHexVal)
    else
        return sHexVal
    end
end

--- source https://stackoverflow.com/questions/35189592/lua-color-fading-function
function M.fade_RGB(colour1, colour2, percentage)
    local r1, g1, b1 = string.match(colour1, "#(%x%x)(%x%x)(%x%x)")
    local r2, g2, b2 = string.match(colour2, "#(%x%x)(%x%x)(%x%x)")
    local r3 = tonumber(r1, 16) * (100 - percentage) / 100.0 + tonumber(r2, 16) * percentage / 100.0
    local g3 = tonumber(g1, 16) * (100 - percentage) / 100.0 + tonumber(g2, 16) * percentage / 100.0
    local b3 = tonumber(b1, 16) * (100 - percentage) / 100.0 + tonumber(b2, 16) * percentage / 100.0
    return "#" .. M.Dec2Hex(r3) .. M.Dec2Hex(g3) .. M.Dec2Hex(b3)
end

function M.is_lsp_client_running(client_name)
    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
        if client.name == client_name then
            return true
        end
    end
    return false
end

function M.open_todo()
    local home_dir = os.getenv("HOME")
    local todo_path = home_dir .. "/todo.md"

    -- Create file if doesn't exist
    if vim.loop.fs_stat(todo_path) == nil then
        vim.loop.fs_open(todo_path, "w", 438)
    end

    -- open file in Neovim
    vim.cmd("edit " .. todo_path)
end
-- create colour gradient from hex values
function M.create_gradient(start, finish, steps)
    local r1, g1, b1 =
        tonumber("0x" .. start:sub(2, 3)), tonumber("0x" .. start:sub(4, 5)), tonumber("0x" .. start:sub(6, 7))
    local r2, g2, b2 =
        tonumber("0x" .. finish:sub(2, 3)), tonumber("0x" .. finish:sub(4, 5)), tonumber("0x" .. finish:sub(6, 7))

    local r_step = (r2 - r1) / steps
    local g_step = (g2 - g1) / steps
    local b_step = (b2 - b1) / steps

    local gradient = {}
    for i = 1, steps do
        local r = math.floor(r1 + r_step * i)
        local g = math.floor(g1 + g_step * i)
        local b = math.floor(b1 + b_step * i)
        table.insert(gradient, string.format("#%02x%02x%02x", r, g, b))
    end

    return gradient
end


function M.update_fenvim()
  local cmd = "cd ~/.config/nvim && git pull"
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then vim.notify(table.concat(data, "\n"), vim.log.levels.INFO, { title = "fenvim update" }) end
    end,
    on_stderr = function(_, data)
      if data then vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR, { title = "fenvim update error" }) end
    end,
  })
end

return M
