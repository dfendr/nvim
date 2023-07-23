local M = {
    "ray-x/web-tools.nvim",
    ft = {"html"}
}

function M.config()
    require("web-tools").setup({
        keymaps = {
            rename = nil, -- by default use same setup of lspconfig
            repeat_rename = nil, -- . to repeat
        },
        hurl = { -- hurl default
            show_headers = false, -- do not show http headers
            floating = false, -- use floating windows (need guihua.lua)
            formatters = { -- format the result by filetype
                json = { "jq" },
                html = { "prettier", "--parser", "html" },
            },
        },
    })
end

return M
