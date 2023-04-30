-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- Relative number toggle, only in Normal mode
vim.api.nvim_command([[
augroup RelativeNumberToggle
autocmd InsertEnter * :set relativenumber
autocmd InsertLeave * :set norelativenumber
augroup END
]])

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPre", {
    pattern = "*",
    callback = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "<buffer>",
            once = true,
            callback = function()
                vim.cmd(
                    [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
                )
            end,
        })
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = {
        "qf",
        "help",
        "man",
        "notify",
        "lspinfo",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "PlenaryTestPopup",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Removing trailing whitesspace on save.
vim.api.nvim_exec(
    [[augroup RemoveTrailingWhitespace
  autocmd!
  autocmd BufWritePre * lua remove_trailing_whitespace()
augroup END]],
    false
)

-- Paired function to above autocmd
function remove_trailing_whitespace()
    local cursor_position = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_command("%s/\\s\\+$//e")
    vim.api.nvim_win_set_cursor(0, cursor_position)
end

-- These two stop vim from adding comment strings when
-- pressing enter on comment strings in Insert mode.
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")
