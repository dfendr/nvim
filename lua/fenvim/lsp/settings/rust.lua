-- Rust Tools Settings
-- automatically set inlay hints (type hints)

-- local path = "~/.local/share/nvim/mason/packages/codelldb/extension/lldb/lib/liblldb"
-- Dynamically updated by Mason.nvim now
local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/"
local codelldb_path = extension_path .. "codelldb"
local liblldb_path = extension_path .. "extension/lldb/lib/liblldb.dylib"

vim.g.rustaceanvim = {
    tools = { -- rust-tools options
        -- callback to execute once rust-analyzer is done initializing the workspace
        -- runnables = { use_telescope = true },

        -- how to execute terminal commands

        on_initialized = function(_)
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                pattern = { "*.rs" },
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
            })
        end,

        executor = require("rust-tools/executors").toggleterm,
        single_file_support = true,

        -- automatically call rustreloadworkspace when writing to a cargo.toml file.
        reload_workspace_from_cargo_toml = true,

        -- these apply to the default rustsetinlayhints command
        inlay_hints = {
            -- default: true
            auto = true,

            -- Only show inlay hints for the current line
            only_current_line = true,

            -- Event which triggers a refresh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",

            -- whether to show parameter hints with the inlay hints or not
            -- default: true
            show_parameter_hints = true,

            locationLinks = false,

            -- prefix for parameter hints
            -- default: "<-"
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            -- default: "=>"
            other_hints_prefix = "=> ",

            -- whether to align to the lenght of the longest line in the file
            max_len_align = false,

            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,

            -- whether to align to the extreme right or not
            right_align = false,

            -- padding from the right if right_align is true
            right_align_padding = 7,

            -- The color of the hints
            highlight = "Comment",
        },

        -- options same as lsp hover / vim.lsp.util.open_floating_preview()
        hover_actions = {

            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
            },

            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = false,
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer

    server = {
        -- standalone file support
        -- setting it to false may improve startup time

        -- Should go under capabilities
        -- signatureHelpProvider = {
        --     triggerCharacters = { "(", ",", "<" },
        -- },

        on_attach = require("fenvim.lsp.handlers").on_attach,
        capabilities = require("fenvim.lsp.handlers").capabilities,
        standalone = true,
        settings = {
            ["rust-analyzer"] = {
                trace = { server = "verbose" },
                inlayHints = { locationLinks = false },
                lens = { enable = true },
                cargo = {
                    allFeatures = true,
                },
                completion = {
                    postfix = {
                        enable = false,
                    },
                },
                checkOnSave = {
                    command = "clippy",
                    extraArgs = {
                        "--",
                        "-W",
                        "clippy::all",
                        "-W",
                        "clippy::pedantic",
                        "-W",
                        "clippy::unwrap_used",
                        "-A",
                        "clippy::must_use",
                    },
                },
            },
        },
    }, -- rust-analyer options
}


-- require("rust-tools").setup(opts)
