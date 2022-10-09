local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

-- dapui.setup()
dapui.setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7"),
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                -- "stacks",
                -- "watches",
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    },
})

local icons = require("user.icons")

vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close({})
end

require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
dap.configurations.lua = {
    {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
    },
}

dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

-- dap.adapters.codelldb = {
--     type = "server",
--     port = "${port}",
--     executable = {
--         -- CHANGE THIS to your path!
--         command = "~/.local/share/nvim/mason/packages/codelldb/extension/adapter",
--         args = { "--port", "${port}" },
--
--         -- On windows you may have to uncomment this:
--         -- detached = false,
--     },
-- }
--
--
-- dap.configurations.rust = {
--     {
--         name = "Launch file",
--         type = "codelldb",
--         request = "launch",
--         -- program = "${file}",
--         -- setupCommands = {
--         --     {
--         --         text = "-enable-pretty-printing",
--         --         description = "enable pretty printing",
--         --         ignoreFailures = false,
--         --     },
--         -- },
--         program = function()
--           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--         end,
--         cwd = "${workspaceFolder}",
--         stopOnEntry = true,
--     },
-- }

-- local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/"
-- local codelldb_path = extension_path .. "codelldb"
-- local liblldb_path = extension_path .. "extension/lldb/lib/liblldb.dylib"
dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        -- command = "/Users/fen/.vscode/extensions/vadimcn.vscode-lldb-1.7.4/adapter/codelldb",
        args = { "--port", "${port}" },
    },
}

-- dap.adapters.codelldb = {
--   type = 'server',
--   port = "${port}",
--   executable = {
--     -- CHANGE THIS to your path!
--     command = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/adapter/codelldb",
--     args = {"--port", "${port}"},
--
--     -- On windows you may have to uncomment this:
--     -- detached = false,
--   }

dap.configurations.c = {
    {
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        --program = '${fileDirname}/${fileBasenameNoExtension}',
        cwd = "${workspaceFolder}",
        terminal = "integrated",
    },
}

dap.configurations.cpp = dap.configurations.c
-- dap.configurations.cpp = dap.configurations.rust

-- dap.configurations.rust = {
--     {
--         type = 'codelldb',
--         request = 'launch',
--         program = function()
--             return vim.fn.input('Path to executable: ', vim.fn.getcwd()..'/', 'file')
--         end,
--         cwd = '${workspaceFolder}',
--         terminal = 'integrated',
--         sourceLanguages = { 'rust' }
--     }
-- }
