local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    local opts = {
        mode = "n",      -- NORMAL mode
        prefix = "<localleader>",
        buffer = 0,      -- Local Buffer
        silent = true,   -- use `silent` when creating keymaps
        noremap = true,  -- use `noremap` when creating keymaps
        nowait = true,   -- use `nowait` when creating keymaps
    }

    local mappings = {
        name = "VimTeX",
        c = { "<cmd>VimtexCompile<cr>", "Compile LaTeX" },
        i = { "<cmd>VimtexInfo<cr>", "VimTeX Info" },
        t = { "<cmd>VimtexTocToggle<cr>", "Toggle ToC" },
        v = { "<cmd>VimtexView<cr>", "View PDF" },
        r = { "<cmd>VimtexReload<cr>", "Reload" },
        s = { "<cmd>VimtexStop<cr>", "Stop Compilation" },
        e = { "<cmd>VimtexErrors<cr>", "Show Errors" },
        l = { "<cmd>VimtexClean<cr>", "Clean Auxiliary Files" },
    }

    which_key.register(mappings, opts)
end
