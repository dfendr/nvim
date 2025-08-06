return {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    enabled = true,
    config = function()
        local scrollbar = require("scrollbar")

        local ok, colors_mod = pcall(require, "fenbox.colors")
        if not ok then
            return
        end
        local colors = colors_mod.config()

        scrollbar.setup({
            handle = {
                color = colors.bg_highlight,
            },
            excluded_filetypes = {
                "prompt",
                "TelescopePrompt",
                "noice",
                "notify",
                "NvimTree",
            },
            marks = {
                Search = { color = colors.orange },
                Error = { color = colors.error },
                Warn  = { color = colors.warning },
                Info  = { color = colors.info },
                Hint  = { color = colors.hint },
                Misc  = { color = colors.purple },
            },
        })

        vim.cmd("ScrollbarToggle")
    end,
}

