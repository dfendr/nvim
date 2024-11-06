vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.textwidth = 79
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2
local status_ok, which_key = pcall(require, "which-key")
if status_ok then

    which_key.add(
  {
    { "<localleader>", buffer = 0, group = "VimTeX", nowait = true, remap = false },
    { "<localleader>P", "<cmd>PasteImage<cr>", buffer = 0, desc = "Paste Image", nowait = true, remap = false },
    { "<localleader>e", "<cmd>VimtexErrors<cr>", buffer = 0, desc = "Show Errors", nowait = true, remap = false },
    { "<localleader>i", "<cmd>VimtexInfo<cr>", buffer = 0, desc = "VimTeX Info", nowait = true, remap = false },
    { "<localleader>l", "<cmd>VimtexClean<cr>", buffer = 0, desc = "Clean Auxiliary Files", nowait = true, remap = false },
    { "<localleader>p", "<cmd>VimtexCompile<cr>", buffer = 0, desc = "Compile and Preview", nowait = true, remap = false },
    { "<localleader>r", "<cmd>VimtexReload<cr>", buffer = 0, desc = "Reload", nowait = true, remap = false },
    { "<localleader>s", "<cmd>VimtexStop<cr>", buffer = 0, desc = "Stop Compilation", nowait = true, remap = false },
    { "<localleader>t", "<cmd>VimtexTocToggle<cr>", buffer = 0, desc = "Toggle ToC", nowait = true, remap = false },
    { "<localleader>v", "<cmd>VimtexView<cr>", buffer = 0, desc = "View PDF", nowait = true, remap = false },
  }
    )

    local map = require("core.functions").map

    map("i", "<m-p>", "<cmd>PasteImage<Cr>")
end
