local M = {}

local merge_tb = vim.tbl_deep_extend

vim.cmd([[
  function Test()
    %SnipRun
    call feedkeys("\<esc>`.")
  endfunction

  function TestI()
    let b:caret = winsaveview()
    %SnipRun
    call winrestview(b:caret)
  endfunction
]])

M.load_override = function(default_table, plugin_name)
    local user_table = M.load_config().plugins.override[plugin_name] or {}
    user_table = type(user_table) == "table" and user_table or user_table()
    return merge_tb("force", default_table, user_table) or {}
end

function M.sniprun_enable()
    vim.cmd([[
    %SnipRun

    augroup _sniprun
     autocmd!
     autocmd TextChanged * call Test()
     autocmd TextChangedI * call TestI()
    augroup end
  ]])
    vim.notify("Enabled SnipRun")
end

function M.disable_sniprun()
    M.remove_augroup("_sniprun")
    vim.cmd([[
    SnipClose
    SnipTerminate
    ]])
    vim.notify("Disabled SnipRun")
end

function M.toggle_sniprun()
    if vim.fn.exists("#_sniprun#TextChanged") == 0 then
        M.sniprun_enable()
    else
        M.disable_sniprun()
    end
end

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

vim.cmd([[ command! SnipRunToggle execute 'lua require("user.functions").toggle_sniprun()' ]])

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

local diagnostics_active = true
function M.toggle_diagnostics()
    diagnostics_active = not diagnostics_active
    if diagnostics_active then
        vim.diagnostic.show()
    else
        vim.diagnostic.hide()
    end
end

function M.isempty(s)
    return s == nil or s == ""
end

function M.get_buf_option(opt)
    local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
    if not status_ok then
        return nil
    else
        return buf_option
    end
end


function M.smart_quit()
    local bufnr = vim.api.nvim_get_current_buf()
    local buf_windows = vim.call("win_findbuf", bufnr)
    local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
    if modified and #buf_windows == 1 then
        vim.ui.input({
            prompt = "You have unsaved changes. Quit anyway? (y/n) ",
        }, function(input)
            if input == "y" then
                vim.cmd("q!")
            end
        end)
    else
        vim.cmd("q!")
    end
end

function M.wrap_in_quotes(string)
    return '"' .. string .. '"'
end

function M.open_explorer()
    if vim.fn.has("mac") == 1 then
        return vim.cmd("TermExec cmd='open \"%:p:h\"'")
    elseif vim.fn.has("win32") == 1 then
        return vim.cmd("TermExec cmd='start \"%:p:h\"'")
        -- return vim.cmd("TermExec cmd='start .' dir=\"%:p:h\"")
    else
        return vim.cmd("TermExec cmd='nautilus\"%:p:h\"'")
    end
end

function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd([[setlocal ve=all]])
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
    else
        vim.cmd([[setlocal ve=]])
        vim.cmd([[mapclear <buffer>]])
        vim.b.venn_enabled = nil
    end
end

function M.lsp_rename()
    local curr_name = vim.fn.expand("<cword>")
    local value = vim.fn.input("LSP Rename: ", curr_name)
    local lsp_params = vim.lsp.util.make_position_params()

    if not value or #value == 0 or curr_name == value then
        return
    end

    -- request lsp rename
    lsp_params.newName = value
    vim.lsp.buf_request(0, "textDocument/rename", lsp_params, function(_, res, ctx, _)
        if not res then
            return
        end

        -- apply renames
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

        -- print renames
        local changed_files_count = 0
        local changed_instances_count = 0

        if res.documentChanges then
            for _, changed_file in pairs(res.documentChanges) do
                changed_files_count = changed_files_count + 1
                changed_instances_count = changed_instances_count + #changed_file.edits
            end
        elseif res.changes then
            for _, changed_file in pairs(res.changes) do
                changed_instances_count = changed_instances_count + #changed_file
                changed_files_count = changed_files_count + 1
            end
        end

        -- compose the right print message
        print(
            string.format(
                "renamed %s instance%s in %s file%s. %s",
                changed_instances_count,
                changed_instances_count == 1 and "" or "s",
                changed_files_count,
                changed_files_count == 1 and "" or "s",
                changed_files_count > 1 and "To save them run ':wa'" or ""
            )
        )
    end)
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
    local r1, g1, b1 = string.match(colour1, "#([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])")
    local r2, g2, b2 = string.match(colour2, "#([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])")
    local r3 = tonumber(r1, 16) * (100 - percentage) / 100.0 + tonumber(r2, 16) * percentage / 100.0
    local g3 = tonumber(g1, 16) * (100 - percentage) / 100.0 + tonumber(g2, 16) * percentage / 100.0
    local b3 = tonumber(b1, 16) * (100 - percentage) / 100.0 + tonumber(b2, 16) * percentage / 100.0
    return "#" .. M.Dec2Hex(r3) .. M.Dec2Hex(g3) .. M.Dec2Hex(b3)
end

return M
