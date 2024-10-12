local M = {
    "rmagatti/auto-session",
    enabled = true,
    event = "VeryLazy",
    dependencies = {
        { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
    },
}

function M.config()
    local auto_session = require("auto-session")
    local telescope = require("telescope")

    local opts = {
        log_level = "error",
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = false,
        auto_save_enabled = true,
        auto_restore_enabled = false,
        auto_session_suppress_dirs = {
            os.getenv("HOME"),
        },
        auto_session_use_git_branch = nil,
        -- the configs below are lua only
        bypass_session_save_file_types = { "alpha" },
    }

    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"



    auto_session.setup(opts)
end

return M
