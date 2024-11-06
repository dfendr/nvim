return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        {
            's1n7ax/nvim-window-picker',
            version = '2.*',
            config = function()
                require("window-picker").setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        bo = {
                            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                            buftype = { 'terminal', "quickfix" },
                        },
                    },
                })
            end,
        },
    },
    cmd = "Neotree",
    config = function()
        vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

        require("neo-tree").setup({
            close_if_last_window = true,
            enable_git_status = true,
            enable_diagnostics = true,
            default_component_configs = {
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                },
                git_status = {
                    symbols = {
                        added = "+",
                        modified = "~",
                        deleted = "✖",
                        untracked = "",
                        ignored = "",
                        unstaged = "󰄱",
                        staged = "",
                        conflict = "",
                    },
                },
            },
            window = {
                position = "left",
                width = 30,
                mappings = {
                    ["<space>"] = "toggle_node",
                    ["<cr>"] = "open",
                    ["o"] = "open",
                    ["h"] = "navigate_up",
                    ["l"] = "focus_preview",
                    ["s"] = "open_vsplit",
                    ["t"] = "open_tabnew",
                    ["x"] = "cut_to_clipboard",
                    ["y"] = "copy_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["a"] = "add",
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["R"] = "refresh",
                    ["C"] = "close_node",
                    ["q"] = "close_window",
                    ["z"] = "close_all_nodes",
                },
            },
            filesystem = {
                follow_current_file = { enabled = true },
                filtered_items = {
                    hide_dotfiles = true,
                    hide_gitignored = true,
                },
                hijack_netrw_behavior = "open_default",
                use_libuv_file_watcher = true,
            },
            buffers = {
                follow_current_file = { enabled = true },
                group_empty_dirs = true,
                show_unloaded = true,
            },
            git_status = {
                window = { position = "float" },
            },
        })

        -- optional keymap to toggle neo-tree
        vim.keymap.set("n", "\\", "<cmd>Neotree toggle<CR>", { noremap = true, silent = true })
    end,
}

