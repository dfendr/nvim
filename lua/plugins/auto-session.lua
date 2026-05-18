local M = {
    "rmagatti/auto-session",
    enabled = true,
    lazy = false,
    dependencies = {
        { "nvim-telescope/telescope.nvim", branch = "0.1.x" },
    },
    keys = {
        { "<leader>sd", "<cmd>Autosession delete<cr>", desc = "Delete Session" },
        { "<leader>sf", "<cmd>SessionSearch<cr>", desc = "Find Session" },
        { "<leader>sl", "<cmd>SessionRestore<cr>", desc = "Load Last" },
        { "<leader>sr", "<cmd>Autosession search<cr>", desc = "Load Last Dir" },
        { "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save" },
    },
}

function M.config()
    local auto_session = require("auto-session")
    local telescope = require("telescope")

    if vim.g.whichkeyAddGroup then
        vim.g.whichkeyAddGroup("<leader>s", "Session")
    end

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

    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

    auto_session.setup(opts)
end

return M
