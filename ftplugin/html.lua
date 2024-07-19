local status_ok, which_key = pcall(require, "which-key")
if status_ok then

    which_key.add({
    { "<localleader>", buffer = 0, group = "Markdown", nowait = true, remap = false },
    { "<localleader>P", ":BrowserPreview<CR>", buffer = 0, desc = "BrowserSync Preview On", nowait = true, remap = false },
    { "<localleader>P", ":BrowserStop<CR>", buffer = 0, desc = "BrowserSync Preview Off", nowait = true, remap = false },
    })

end
