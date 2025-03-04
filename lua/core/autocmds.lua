-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = "checktime" })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

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
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*",
    callback = function(event)
        local cursor_position = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_command("%s/\\s\\+$//e")
        vim.api.nvim_win_set_cursor(0, cursor_position)
    end,
})

-- These two stop vim from adding comment strings when
-- pressing enter on comment strings in Insert mode.
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, "auto-cursorline")
        end
    end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
            vim.wo.cursorline = false
        end
    end,
})


-- Fix conceallevel for json & help files
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "json", "jsonc" },
    callback = function()
        vim.wo.spell = false
        vim.wo.conceallevel = 0
    end,
})

-- Big File Mode
local group = vim.api.nvim_create_augroup("LargeFileAutocmds", {})

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
    group = group,
    callback = function(ev)
        if ev.file then
            local status, size = pcall(function()
                return vim.loop.fs_stat(ev.file).size
            end)
            if status and size > 1024 * 1024 then -- large file
                vim.b.largefile_opened = true
                vim.b.old_eventignore = vim.o.eventignore
                vim.o.eventignore = "FileType"
                vim.treesitter.stop(0)
                vim.bo.syntax = "OFF"
                vim.bo.swapfile = false
                vim.bo.bufhidden = "unload"
                vim.bo.buftype = "nowrite"
                vim.bo.undolevels = -1
                vim.wo.wrap = false
            end
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufWinLeave", "BufHidden" }, {
    group = group,
    callback = function(ev)
        if vim.b.largefile_opened then
            vim.b.largefile_opened = false
            if vim.b.old_eventignore then
                vim.o.eventignore = vim.b.old_eventignore
            end
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = group,
    callback = function(ev)
        local byte_size = vim.api.nvim_buf_get_offset(ev.buf, vim.api.nvim_buf_line_count(ev.buf))
        if byte_size > 1024 * 1024 then
            if vim.fn.exists(":NoMatchParen") == 1 then
                vim.cmd("NoMatchParen")
            end
        else
            if vim.fn.exists(":DoMatchParen") == 1 then
                vim.cmd("DoMatchParen")
            end
        end
    end,
})
-------------------------------------------------------------------------------
