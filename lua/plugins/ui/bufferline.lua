return {
    "akinsho/nvim-bufferline.lua",
    enabled = true,
    event = "BufAdd",
    dependencies = { "tiagovla/scope.nvim" },
    config = function()
        local bufferline = require("bufferline")
        bufferline.setup({
            options = {
                close_command = "bdelete! %d",
                right_mouse_command = "bdelete! %d",
                left_mouse_command = "buffer %d",
                indicator = { icon = "▎", style = "icon" },
                buffer_close_icon = "X",
                modified_icon = "*",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "left",
                        separator = true,
                    },
                    {
                        filetype = "neo-tree",
                        text = "EXPLORER",
                        text_align = "left",
                    },
                },
                color_icons = true,
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_close_icon = false,
                show_tab_indicators = true,
                separator_style = "thin",
                always_show_bufferline = false,
                sort_by = "insert_at_end",
            },
            highlights = {},
        })
    end,
}
