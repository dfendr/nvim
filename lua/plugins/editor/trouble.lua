local M = {}

function M.config()
    require("trouble").setup({
        auto_close = false,
        auto_open = false,
        auto_preview = true,
        focus = true,
        indent_guides = true,
        multiline = true,
        warn_no_results = true,
    })
end

return M
