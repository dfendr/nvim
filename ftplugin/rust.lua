local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local status_ok, rusttools = pcall(require, "rust-tools")
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

local hints = false
local function toggle_hints()
    hints = not hints
    if hints then
        rusttools.inlay_hints.enable()
    else
        rusttools.inlay_hints.disable()
    end
end
--
-- NOTE: Temporarily disabling CMP to learn rust better.
-- require('cmp').setup.buffer { enabled = false }

local mappings = {
    name = "Rust",
    r = { "<cmd>RustRunnables<Cr>", "Runnables" },
    t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
    m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
    c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
    p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
    d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
    v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
    R = {
        "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
        "Reload Workspace",
    },
    o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
}

which_key.register(mappings, opts)
