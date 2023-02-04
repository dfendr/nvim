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
        filetypes = { "md", "py", "json", "lua", "js", "ts", "c" }, -- filetypes to select from
    })
end

return M
