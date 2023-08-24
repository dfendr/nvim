local M = {
    "postfen/clipboard-image.nvim",
    enabled = true,
    ft = { "md", "markdown" },
    lazy = true,
    -- Dependency on: pngpaste
    -- install with `brew install pngpaste`
}
function M.config()
    require("clipboard-image").setup({
        -- Default configuration for all filetype
        default = {
            img_dir = { "%:p:h", "img" },
            img_dir_txt = "img",
            img_name = function()
                return os.date("%Y-%m-%d-%H-%M-%S")
            end, -- Example result: "2021-04-13-10-04-18"
            affix = "<\n  %s\n>", -- Multi lines affix
        },
    })
end

return M
