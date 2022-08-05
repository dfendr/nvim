-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
--
-- vim.g.nvim_tree_icons = {
--   default = "",
--   symlink = "",
--   git = {
--     unstaged = "",
--     staged = "S",
--     unmerged = "",
--     renamed = "➜",
--     deleted = "",
--     untracked = "U",
--     ignored = "◌",
--   },
--   folder = {
--     default = "",
--     open = "",
--     empty = "",
--     empty_open = "",
--     symlink = "",
--   },
-- }

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  -- auto_close = true,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },

renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
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
            bookmark = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
                unstaged = "",
                staged = "S",
                unmerged = "",
                renamed = "➜",
                deleted = "",
                untracked = "U",
                ignored = "◌",
                },
              },
            },
            },
        view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "v", cb = tree_cb "vsplit" },
      },
    },
    number = false,
    relativenumber = false,
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = false,
      },
    },
  },
}


