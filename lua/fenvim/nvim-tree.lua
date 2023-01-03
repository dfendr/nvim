local M = {
    "nvim-tree/nvim-tree.lua",
    -- cmd = "NvimTreeToggle",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
}

function M.config()
    local status_ok, nvim_tree = pcall(require, "nvim-tree")
    if not status_ok then
        return
    end

    local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
    if not config_status_ok then
        return
    end

    local icons = require("fenvim.ui.icons")

    local tree_cb = nvim_tree_config.nvim_tree_callback

    nvim_tree.setup({
        hijack_directories = {
            enable = false,
        },
        -- update_to_buf_dir = {
        --   enable = false,
        -- },
        -- disable_netrw = true,
        -- hijack_netrw = true,
        -- open_on_setup = false,
        ignore_ft_on_setup = {
            "startify",
            "dashboard",
            "alpha",
        },
        filters = {
            custom = { ".git" },
            exclude = { ".gitignore" },
        },
        -- auto_close = true,
        -- open_on_tab = false,
        -- hijack_cursor = false,
        update_cwd = true,
        -- update_to_buf_dir = {
        --   enable = true,
        --   auto_open = true,
        -- },
        -- --   error
        -- --   info
        -- --   question
        -- --   warning
        -- --   lightbulb
        renderer = {
            add_trailing = false,
            group_empty = false,
            highlight_git = false,
            highlight_opened_files = "all",
            root_folder_modifier = ":t",
            indent_markers = {
                enable = false,
                icons = {
                    corner = "└ ",
                    edge = "│ ",
                    none = "  ",
                },
            },
            icons = {
                webdev_colors = true,
                git_placement = "before",
                padding = " ",
                symlink_arrow = " ➛ ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        arrow_open = icons.ui.arrowopen,
                        arrow_closed = icons.ui.arrowclosed,
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "",
                        staged = "s",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "u",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
        diagnostics = {
            enable = true,
            icons = {
                hint = icons.diagnostics.hint,
                info = icons.diagnostics.information,
                warning = icons.diagnostics.warning,
                error = icons.diagnostics.error,
            },
        },
        remove_keymaps = {
            "<C-k>",
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            update_root = true,
            ignore_list = {},
        },
        -- system_open = {
        --   cmd = nil,
        --   args = {},
        -- },
        -- filters = {
        --   dotfiles = false,
        --   custom = {},
        -- },
        git = {
            enable = true,
            ignore = true,
            timeout = 500,
        },
        view = {
            width = 30,
            -- height = 30,
            hide_root_folder = false,
            side = "left",
            adaptive_size = false,
            --auto_resize = true,
            float = {
                enable = false, -- Not ready yet, causes errors on toggle (8/18/22)
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 40,
                    height = 40,
                    row = 1,
                    col = 1,
                },
            },
            mappings = {
                custom_only = false,
                list = {
                    { key = { "l", "<cr>", "o" }, cb = tree_cb("edit") },
                    { key = "h", cb = tree_cb("close_node") },
                    { key = "v", cb = tree_cb("vsplit") },
                    { key = "b", cb = tree_cb("split") }, -- heuristic "Below"
                    { key = "t", cb = tree_cb("tabnew") },
                    { key = "gh", cb = tree_cb("toggle_file_info") },
                },
            },
            number = false,
            relativenumber = false,
        },
    })
end
return M
