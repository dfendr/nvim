local status_ok, rusttools = pcall(require, "rustaceanvim")
if not status_ok then
    print("rustaceanvim not installed!")
    return
end


-- NOTE: Temporarily disabling CMP to learn rust better.
-- require('cmp').setup.buffer { enabled = false }

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<localleader>",
        buffer = 0, -- Local Buffer
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    local mappings = {
        name = "Rust",
        r = { "<cmd>RustLsp runnables<Cr>", "Runnables" },
        t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
        m = { "<cmd>RustLsp expandMacro<Cr>", "Expand Macro" },
        c = { "<cmd>RustLsp openCargo<Cr>", "Open Cargo" },
        p = { "<cmd>RustLsp parentModule<Cr>", "Parent Module" },
        d = { "<cmd>RustLsp debuggables<Cr>", "Debuggables" },
        v = { "<cmd>RustLsp viewCrateGraph<Cr>", "View Crate Graph" },
        R = { "<cmd>RustLsp reloadWorkspace<Cr>", "Reload Workspace" },
        o = { "<cmd>RustLsp openExternalDocs<Cr>", "Open External Docs" },
    }

    local map = require("core.functions").map

    which_key.register(mappings, opts)
end
