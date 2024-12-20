local status_ok, rusttools = pcall(require, "rustaceanvim")
if not status_ok then
    print("rustaceanvim not installed!")
    return
end

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    which_key.add({
        { "<localleader>", buffer = 0, group = "Rust", nowait = true, remap = false },
        { "<localleader>R", "<cmd>RustLsp reloadWorkspace<Cr>", buffer = 0, desc = "Reload Workspace", nowait = true, remap = false, },
        { "<localleader>c", "<cmd>RustLsp openCargo<Cr>", buffer = 0, desc = "Open Cargo", nowait = true, remap = false, },
        { "<localleader>d", "<cmd>RustLsp debuggables<Cr>", buffer = 0, desc = "Debuggables", nowait = true, remap = false, },
        { "<localleader>m", "<cmd>RustLsp expandMacro<Cr>", buffer = 0, desc = "Expand Macro", nowait = true, remap = false, },
        { "<localleader>o", "<cmd>RustLsp openExternalDocs<Cr>", buffer = 0, desc = "Open External Docs", nowait = true, remap = false, },
        { "<localleader>p", "<cmd>RustLsp parentModule<Cr>", buffer = 0, desc = "Parent Module", nowait = true, remap = false, },
        { "<localleader>r", "<cmd>RustLsp runnables<Cr>", buffer = 0, desc = "Runnables", nowait = true, remap = false, },
        { "<localleader>t", "<cmd>lua _CARGO_TEST()<cr>", buffer = 0, desc = "Cargo Test", nowait = true, remap = false, },
        { "<localleader>v", "<cmd>RustLsp viewCrateGraph<Cr>", buffer = 0, desc = "View Crate Graph", nowait = true, remap = false, },
    })
end
