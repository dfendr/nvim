local M = {
    "rmagatti/auto-session",
    enabled = true,
    lazy = false,
    dependencies = {
        { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
    },
}

function M.config()
    local auto_session = require("auto-session")
    local telescope = require("telescope")

    local opts = {
        auto_restore = false,
        auto_restore_last_session = false,
        auto_save = true,
        bypass_save_filetypes = { "alpha" },
        enabled = false,
        log_level = "error",
        root_dir = "~/.local/share/nvim/sessions/",
        suppressed_dirs = { "$HOME" },
    }

    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

    auto_session.setup(opts)
end

return M
