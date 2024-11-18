return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        {
            "s1n7ax/nvim-window-picker",
            version = "2.*",
            config = function()
                require("window-picker").setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        bo = {
                            filetype = { "neo-tree", "neo-tree-popup", "notify" },
                            buftype = { "terminal", "quickfix" },
                        },
                    },
                })
            end,
        },
    },
    cmd = "Neotree",

    opts = function(_, opts)
        local function on_move(data)
            local ok, Snacks = pcall(require, "snacks")
            if not Snacks then
                print('Warning: "snacks.nvim" plugin is not installed or loaded.')
                return
            end
            Snacks.rename.on_rename_file(data.source, data.destination)
        end
        local events = require("neo-tree.events")
        opts.event_handlers = opts.event_handlers or {}
        vim.list_extend(opts.event_handlers, {
            { event = events.FILE_MOVED, handler = on_move },
            { event = events.FILE_RENAMED, handler = on_move },
        })
    end,

    config = function()
        -- Check if snacks.nvim is installed and loaded

        local inputs = require("neo-tree.ui.inputs")
        -- Trash the target
        local function trash(state)
            local node = state.tree:get_node()
            if node.type == "message" then
                return
            end
            local _, name = require("neo-tree.utils").split_path(node.path)
            local msg = string.format("Are you sure you want to trash '%s'?", name)
            inputs.confirm(msg, function(confirmed)
                if not confirmed then
                    return
                end
                vim.api.nvim_command("silent !trash -F " .. node.path)
                require("neo-tree.sources.manager").refresh(state)
            end)
        end

        -- Trash the selections (visual mode)
        local function trash_visual(state, selected_nodes)
            local paths_to_trash = {}
            for _, node in ipairs(selected_nodes) do
                if node.type ~= "message" then
                    table.insert(paths_to_trash, node.path)
                end
            end
            local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
            inputs.confirm(msg, function(confirmed)
                if not confirmed then
                    return
                end
                for _, path in ipairs(paths_to_trash) do
                    vim.api.nvim_command("silent !trash -F " .. path)
                end
                require("neo-tree.sources.manager").refresh(state)
            end)
        end

        require("neo-tree").setup({
            close_if_last_window = true,
            enable_git_status = true,
            enable_diagnostics = true,
            open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
            sort_case_insensitive = true, -- used when sorting files and directories in the tree
            sort_function = nil, -- use a custom function for sorting files and directories in the tree
            -- sort_function = function (a,b)
            --       if a.type == b.type then
            --           return a.path > b.path
            --       else
            --           return a.type > b.type
            --       end
            --   end , -- this sorts files and directories descendantly
            default_component_configs = {

                indent = {
                    indent_size = 2,
                    padding = 1, -- extra padding on left hand side
                    -- indent guides
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
                container = {
                    enable_character_fade = true,
                },
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
                    -- disable any commands by setting them to nil
                    ["<cr>"] = "open",
                    -- disable fuzzy finder
                    ["/"] = "noop",
                    ["s"] = "system_open",
                    ["d"] = vim.fn.has("mac") == 1 and "trash" or "delete",
                    ["u"] = "navigate_up",
                    ["l"] = "open",
                    ["v"] = "open_vsplit",
                    ["h"] = "open_split",
                    ["t"] = "open_tabnew",
                    ["x"] = "cut_to_clipboard",
                    ["y"] = "copy_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["a"] = "add",
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
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
                hijack_netrw_behavior = "open_default",
                use_libuv_file_watcher = true,
            },
            commands = {
                trash = trash,
                trash_visual = trash_visual,
                system_open = function(state)
                    local node = state.tree:get_node()
                    local path = node:get_id()
                    if vim.fn.has("mac") == 1 then
                        vim.fn.jobstart({ "open", path }, { detach = true })
                    elseif vim.fn.has("unix") == 1 then
                        vim.fn.jobstart({ "xdg-open", path }, { detach = true })
                    elseif vim.fn.has("win32") == 1 then
                        -- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
                        local p
                        local lastSlashIndex = path:match("^.+()\\[^\\]*$") -- Match the last slash and everything before it
                        if lastSlashIndex then
                            p = path:sub(1, lastSlashIndex - 1) -- Extract substring before the last slash
                        else
                            p = path -- If no slash found, return original path
                        end
                        vim.cmd("silent !start explorer " .. p)
                    end
                end,
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

        -- keymap to toggle neo-tree
        -- vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { noremap = true, silent = true })
    end,
}
