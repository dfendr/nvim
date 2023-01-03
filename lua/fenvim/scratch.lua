local M = {
    "LintaoAmons/scratch.nvim",
    cmd = "Scratch",
}

function M.config()
    local status_ok, scratch = pcall(require, "scratch")
    if not status_ok then
        return
    end

    scratch.setup({
        scratch_file_dir = vim.env.HOME .. "/scratch.nvim", -- Where the scratch files will be saved
        filetypes = { "md", "py", "c", "lua", "js", "ts", "json" }, -- filetypes to select from
    })
end

return M
