local M = {}
function M.config()
    local scrollbar = require("scrollbar")

    -- PERF: throttle scrollbar refresh
    -- Disable, throttle, since it was caused by comment TS
    -- local render = scrollbar.render
    -- scrollbar.render = require("util").throttle(300, render)

    local colors = require("gruvbox-baby.colors").config()
    scrollbar.setup({
        handle = {
            color = colors.bg_highlight,
        },
        excluded_filetypes = {
            "prompt",
            "TelescopePrompt",
            "noice",
            "notify",
            "NvimTree"
        },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
    })

vim.cmd("ScrollbarToggle")
end

return M
