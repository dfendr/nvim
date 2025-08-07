return {
    "j-hui/fidget.nvim",
    event = "BufReadPost",
    enabled = true,
    config = function()
        local function spinner_icon()
            return require("core.functions").daylight() and "star" or "moon"
        end

        local border_style = "none"
        local ok, ui_prefs = pcall(require, "core.prefs")
        if ok then
            border_style = ui_prefs.ui.fidget.border_style
        end

        require("fidget").setup({
            progress = {
                ignore_done_already = true,
                display = {
                    done_icon = "✔",
                    progress_icon = { pattern = spinner_icon(), period = 1 },
                },
            },
            notification = {
                window = {
                    normal_hl = "Comment",
                    winblend = 0,
                    border = border_style,
                    zindex = 45,
                    max_width = 0,
                    max_height = 0,
                    x_padding = 1,
                    y_padding = 0,
                    align = "bottom",
                    relative = "editor",
                },
            },
            integration = {
                ["nvim-tree"] = { enable = true },
            },
        })
    end,
}

