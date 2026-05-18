local M = {}

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
    local config_path = vim.uv.fs_realpath(vim.fn.stdpath("config"))
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

function M.map(mode, key, cmd, opts, desc, bufnr)
    local options = vim.tbl_extend("force", opts or {}, { desc = desc, buffer = bufnr })
    vim.keymap.set(mode, key, cmd, options)
end

function M.toggle_inlay_hints()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
end

function M.show_lsp_info()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if not clients or vim.tbl_isempty(clients) then
        vim.notify("No LSP clients attached to this buffer", vim.log.levels.INFO, { title = "LSP Info" })
        return
    end

    local lines = { "# Active LSP clients", "" }
    local capability_labels = {
        completionProvider = "completion",
        hoverProvider = "hover",
        definitionProvider = "definitions",
        referencesProvider = "references",
        renameProvider = "rename",
        codeActionProvider = "code actions",
        documentFormattingProvider = "formatting",
        documentSymbolProvider = "doc symbols",
        signatureHelpProvider = "signature help",
    }

    for _, client in ipairs(clients) do
        table.insert(lines, string.format("• %s (id %d)", client.name, client.id))

        local root_dir = client.config and client.config.root_dir
        if root_dir and root_dir ~= "" then
            table.insert(lines, "  root: " .. root_dir)
        end

        local folders = {}
        if client.workspace_folders then
            for _, folder in ipairs(client.workspace_folders) do
                table.insert(folders, folder.name or vim.uri_to_fname(folder.uri))
            end
        end
        if #folders > 0 then
            table.insert(lines, "  workspace: " .. table.concat(folders, ", "))
        end

        local capabilities = {}
        for key, label in pairs(capability_labels) do
            if client.server_capabilities and client.server_capabilities[key] then
                table.insert(capabilities, label)
            end
        end
        if #capabilities > 0 then
            table.insert(lines, "  capabilities: " .. table.concat(capabilities, ", "))
        end

        table.insert(lines, "")
    end

    vim.lsp.util.open_floating_preview(lines, "markdown", { border = "rounded" })
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

function M.daylight()
    if tonumber(os.date("%H")) < 17 and 9 <= tonumber(os.date("%H")) then
        return true
    else
        return false
    end
end

function M.open_todo()
    local home_dir = os.getenv("HOME")
    local todo_path = home_dir .. "/todo.md"

    -- Create file if doesn't exist
    if vim.uv.fs_stat(todo_path) == nil then
        vim.uv.fs_open(todo_path, "w", 438)
    end

    -- open file in Neovim
    vim.cmd("edit " .. todo_path)
end
return M
