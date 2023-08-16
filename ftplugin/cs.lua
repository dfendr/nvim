-- vim.opt.colorcolumn = "120" -- Column @ 80 for cleanliness reminder.

vim.cmd("setlocal colorcolumn=120")

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    print("Error: Failed to load the dap module.")
else
    require("dap.ext.vscode").load_launchjs(nil, { coreclr = { "cs" } })
end
