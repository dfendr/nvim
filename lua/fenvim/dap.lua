local M = {
    "mfussenegger/nvim-dap",
    event = "BufReadPost",
    dependencies = {
        "jbyuki/one-small-step-for-vimkind",
        "rcarriga/nvim-dap-ui",
        "simrat39/rust-tools.nvim",
        "theHamsta/nvim-dap-virtual-text",
        "williamboman/mason.nvim",
        {
            "jay-babu/mason-nvim-dap.nvim",
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
                    automatic_installation = true,
                    automatic_setup = true,
                    handlers = {},
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

    dap.set_log_level("TRACE")

    local dap_ui_status_ok, dapui = pcall(require, "dapui")
    if not dap_ui_status_ok then
        return
    end

    -- autosetup of adapters listed above
    require("mason-nvim-dap").setup()
    dapui.setup({
        icons = { expanded = "", collapsed = "", circular = "" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "o", "<2-LeftMouse>" },
            open = "<CR>",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = true,
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
            border = require("core.prefs").ui.border_style,
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

    local dir = vim.fs.normalize(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python/")
    require("dap-python").setup(dir)
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
            args = { "--port", "${port}" },
        },
    }

    dap.adapters.coreclr = {
        type = "executable",
        command = vim.fs.normalize(vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg"),
        -- command = "/usr/local/bin/netcoredbg/netcoredbg",

        args = { "--interpreter=vscode" },
    }

    -- Neotest Test runner looks at this table
    dap.adapters.netcoredbg = vim.deepcopy(dap.adapters.coreclr)

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

    dap.configurations.c = {
        {
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            terminal = "integrated",
        },
    }

    dap.configurations.cpp = dap.configurations.c

    vim.g.dotnet_build_project = function()
        local default_path = vim.fn.getcwd() .. "/"
        if vim.g["dotnet_last_proj_path"] ~= nil then
            default_path = vim.g["dotnet_last_proj_path"]
        end
        local path = vim.fn.input("Path to your *proj file", default_path, "file")
        vim.g["dotnet_last_proj_path"] = path
        local cmd = "dotnet build -c Debug " .. path .. " > /dev/null"
        print("")
        print("Cmd to execute: " .. cmd)
        local f = os.execute(cmd)
        if f == 0 then
            print("\nBuild: ✔️ ")
        else
            print("\nBuild: ❌ (code: " .. f .. ")")
        end
    end

    vim.g.dotnet_get_dll_path = function()
        local request = function()
            return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end

        if vim.g["dotnet_last_dll_path"] == nil then
            vim.g["dotnet_last_dll_path"] = request()
        else
            if
                vim.fn.confirm(
                    "Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"],
                    "&yes\n&no",
                    2
                ) == 1
            then
                vim.g["dotnet_last_dll_path"] = request()
            end
        end
        return vim.g["dotnet_last_dll_path"]
    end

    dap.configurations.cs = {
        {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
                if vim.fn.confirm("Should I recompile first?", "&yes\n&no", 2) == 1 then
                    vim.g.dotnet_build_project()
                end
                return vim.g.dotnet_get_dll_path()
            end,
        },
    }

    require("dap.ext.vscode").load_launchjs(nil, { coreclr = { "cs" } })
end

return M
