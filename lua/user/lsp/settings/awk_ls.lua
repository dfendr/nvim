return {
    cmd = { "awk-language-server" },
    filetypes = { "awk" },
    single_file_support = true,
    handlers = {
        ["workspace/workspaceFolders"] = function()
            return { {
                uri = "file://" .. vim.fn.getcwd(),
                name = "current_dir",
            } }
        end,
    },
}
