local M = {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    enabled = true,
}

M.config = function()
    require("oil").setup()
    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
end

return M
