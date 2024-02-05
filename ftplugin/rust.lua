local status_ok, rusttools = pcall(require, "rustaceanvim")
if not status_ok then
    print("rustaceanvim not installed!")
    return
end


-- vim.g.rustaceanvim = {
--     tools = { -- rust-tools options
--         -- callback to execute once rust-analyzer is done initializing the workspace
--         -- runnables = { use_telescope = true },
--
--         -- how to execute terminal commands
--
--         on_initialized = function(_)
--             -- require("fenvim.lsp.lsp-signature").config()
--             vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
--                 pattern = { "*.rs" },
--                 callback = function()
--                     vim.lsp.codelens.refresh()
--                 end,
--             })
--         end,
--
--         executor = require("rustaceanvim/executors").toggleterm,
--         single_file_support = true,
--
--         -- automatically call rustreloadworkspace when writing to a cargo.toml file.
--         reload_workspace_from_cargo_toml = true,
--
--         -- these apply to the default rustsetinlayhints command
--         inlay_hints = {
--             -- default: true
--             auto = true,
--
--             -- Only show inlay hints for the current line
--             only_current_line = true,
--
--             -- Event which triggers a refersh of the inlay hints.
--             -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
--             -- not that this may cause higher CPU usage.
--             -- This option is only respected when only_current_line and
--             -- autoSetHints both are true.
--             only_current_line_autocmd = "CursorHold",
--
--             -- whether to show parameter hints with the inlay hints or not
--             -- default: true
--             show_parameter_hints = true,
--
--             locationLinks = false,
--
--             -- prefix for parameter hints
--             -- default: "<-"
--             parameter_hints_prefix = "<- ",
--
--             -- prefix for all the other hints (type, chaining)
--             -- default: "=>"
--             other_hints_prefix = "=> ",
--
--             -- whether to align to the lenght of the longest line in the file
--             max_len_align = false,
--
--             -- padding from the left if max_len_align is true
--             max_len_align_padding = 1,
--
--             -- whether to align to the extreme right or not
--             right_align = false,
--
--             -- padding from the right if right_align is true
--             right_align_padding = 7,
--
--             -- The color of the hints
--             highlight = "Comment",
--         },
--
--         -- options same as lsp hover / vim.lsp.util.open_floating_preview()
--         hover_actions = {
--
--             -- the border that is used for the hover window
--             -- see vim.api.nvim_open_win()
--             border = {
--                 { "╭", "FloatBorder" },
--                 { "─", "FloatBorder" },
--                 { "╮", "FloatBorder" },
--                 { "│", "FloatBorder" },
--                 { "╯", "FloatBorder" },
--                 { "─", "FloatBorder" },
--                 { "╰", "FloatBorder" },
--                 { "│", "FloatBorder" },
--             },
--
--             -- whether the hover action window gets automatically focused
--             -- default: false
--             auto_focus = false,
--         },
--     },
--
--     -- all the opts to send to nvim-lspconfig
--     -- these override the defaults set by rust-tools.nvim
--     -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
--
--     server = {
--         -- standalone file support
--         -- setting it to false may improve startup time
--
--         -- Should go under capabilities
--         -- signatureHelpProvider = {
--         --     triggerCharacters = { "(", ",", "<" },
--         -- },
--
--         on_attach = require("fenvim.lsp.handlers").on_attach,
--         capabilities = require("fenvim.lsp.handlers").capabilities,
--         standalone = true,
--         settings = {
--             ["rust-analyzer"] = {
--                 trace = { server = "verbose" },
--                 inlayHints = { locationLinks = false },
--                 lens = { enable = true },
--                 cargo = {
--                     allFeatures = true,
--                 },
--                 completion = {
--                     postfix = {
--                         enable = false,
--                     },
--                 },
--                 checkOnSave = {
--                     command = "clippy",
--                     extraArgs = {
--                         "--",
--                         "-W",
--                         "clippy::all",
--                         -- "-W",
--                         -- "clippy::pedantic",
--                         "-W",
--                         "clippy::unwrap_used",
--                         -- "-A",
--                         -- "clippy::must_use",
--                     },
--                 },
--             },
--         },
--     }, -- rust-analyer options
-- }

-- NOTE: Temporarily disabling CMP to learn rust better.
-- require('cmp').setup.buffer { enabled = false }

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<localleader>",
        buffer = 0, -- Local Buffer
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    local mappings = {
        name = "Rust",
        r = { "<cmd>RustLsp runnables<Cr>", "Runnables" },
        t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
        m = { "<cmd>RustLsp expandMacro<Cr>", "Expand Macro" },
        c = { "<cmd>RustLsp openCargo<Cr>", "Open Cargo" },
        p = { "<cmd>RustLsp parentModule<Cr>", "Parent Module" },
        d = { "<cmd>RustLsp debuggables<cr>", "Debuggables" },
        v = { "<cmd>RustLsp viewCrateGraph<Cr>", "View Crate Graph" },
        R = { "<cmd>RustLsp reloadWorkspace<Cr>", "Reload Workspace" },
        o = { "<cmd>RustLsp openExternalDocs<Cr>", "Open External Docs" },
    }

    local map = require("core.functions").map

    which_key.register(mappings, opts)
end
