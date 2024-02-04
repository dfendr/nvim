local group = vim.api.nvim_create_augroup("LargeFileAutocmds", {})

vim.api.nvim_create_autocmd({"BufReadPre"}, {
    group = group,
    callback = function(ev)
        if ev.file then
            local status, size = pcall(function() return vim.loop.fs_stat(ev.file).size end)
            if status and size > 1024 * 1024 then -- large file
                vim.b.largefile_opened = true
                vim.b.old_eventignore = vim.o.eventignore
                vim.o.eventignore = 'FileType'
                vim.bo.swapfile = false
                vim.bo.bufhidden = 'unload'
                vim.bo.buftype = 'nowrite'
                vim.bo.undolevels = -1
                vim.wo.wrap = false
            end
        end
    end
})

vim.api.nvim_create_autocmd({"BufWinLeave", "BufHidden"}, {
    group = group,
    callback = function(ev)
        if vim.b.largefile_opened then
            vim.b.largefile_opened = false
            if vim.b.old_eventignore then
                vim.o.eventignore = vim.b.old_eventignore
            end
        end
    end
})

vim.api.nvim_create_autocmd({"BufEnter"}, {
    group = group,
    callback = function(ev)
        local byte_size = vim.api.nvim_buf_get_offset(ev.buf, vim.api.nvim_buf_line_count(ev.buf))
        if byte_size > 1024 * 1024 then
            if vim.g.loaded_matchparen then
                vim.cmd('NoMatchParen')
            end
        else
            if not vim.g.loaded_matchparen then
                vim.cmd('DoMatchParen')
            end
        end
    end
})
