local M = {
    "mfussenegger/nvim-dap",
    event = "BufReadPost",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "simrat39/rust-tools.nvim",
        "theHamsta/nvim-dap-virtual-text",
        "williamboman/mason.nvim",
        {
            "jayp0521/mason-nvim-dap.nvim",
            dependencies = "williamboman/mason.nvim",
            config = function()
                require("mason-nvim-dap").setup({
                    ensure_installed = {
                        "python",
                        "codelldb",
                        "javascript",
                        "cppdbg",
                        "node2",
                        "chrome",
                        "firefox",
                        "bash",
                        "coreclr",
                    },
                    automatic_setup = true,
                })
            end,
        },

        { "mfussenegger/nvim-dap-python", ft = { "python" } },
        {
            "mfussenegger/nvim-jdtls",
            ft = { "java" },
        },
        {
            { "mxsdev/nvim-dap-vscode-js", ft = { "typescript", "javascript" } },
        },
    },
}

function M.config()
    local dap_status_ok, dap = pcall(require, "dap")
    if not dap_status_ok then
        return
    end

    local dap_ui_status_ok, dapui = pcall(require, "dapui")
    if not dap_ui_status_ok then
        return
    end
    require("mason-nvim-dap").setup_handlers()
    -- dapui.setup()
    dapui.setup({
        icons = { expanded = "", collapsed = "", circular = "" },
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

    local icons = require("fenvim.ui.icons")

    vim.fn.sign_define(
        "DapBreakpoint",
        { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" }
    )

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
    end

    -- require("dap-vscode-js").setup({
    --     -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    --     -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
    --     debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    --     adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
    --     -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
    --     -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
    --     -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    -- })
    -- for _, language in ipairs({ "typescript", "javascript" }) do
    --     require("dap").configurations[language] = {
    --         -- Node.js
    --         {
    --             type = "pwa-node",
    --             request = "launch",
    --             name = "Launch file",
    --             program = "${file}",
    --             cwd = "${workspaceFolder}",
    --         },
    --         {
    --             type = "pwa-node",
    --             request = "attach",
    --             name = "Attach",
    --             processId = require("dap.utils").pick_process,
    --             cwd = "${workspaceFolder}",
    --         },
    --     }
    -- end
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

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "codelldb",
            -- command = "/Users/fen/.vscode/extensions/vadimcn.vscode-lldb-1.7.4/adapter/codelldb",
            args = { "--port", "${port}" },
        },
    }

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
end
return M
