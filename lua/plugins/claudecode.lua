local M = {
    "coder/claudecode.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>ia", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Diff" },
        { "<leader>ib", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add Buffer" },
        { "<leader>id", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Diff" },
        { "<leader>if", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus" },
        { "<leader>ii", "<cmd>ClaudeCode<cr>", desc = "Toggle" },
        { "<leader>is", "<cmd>ClaudeCodeSend<cr>", mode = "x", desc = "Send Selection" },
    },
}

function M.config()
    -- Spawn in the buffer's git root
    require("claudecode").setup({ git_repo_cwd = true })

    if vim.g.whichkeyAddGroup then
        vim.g.whichkeyAddGroup("<leader>i", "Claude")
    end
end

return M
