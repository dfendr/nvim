local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end


local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<localleader>",
    buffer = 0, -- Local Buffer
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
        name = "HTML",
        p = { ':BrowserPreview<CR>', "BrowserSync Preview On" },
        P = { ':BrowserStop<CR>', "BrowserSync Preview Off" },
}

which_key.register(mappings, opts)
