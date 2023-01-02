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
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
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
vim.keymap.set("n", "<leader>Lh", toggle_hints)
-- vim.api.nvim_buf_add_user_command("RustToggleInlayHints", function()
--     toggle_hints()
-- end)

local mappings = {
    L = {
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
        H = { "<cmd>RustDisableInlayHints<Cr>", "Disable Hints" },
        -- S = { "<cmd>RustSSR<Cr>", "SSR" },
        -- h = { "<cmd>RustToggleInlayHints<Cr>", "Toggle Hints" },
        -- r = { "<cmd>lua _CARGO_RUN()<cr>", "Cargo Run" },
        -- j = { "<cmd>RustJoinLines<Cr>", "Join Lines" },
        -- s = { "<cmd>RustStartStandaloneServerForBuffer<Cr>", "Start Server Buf" },
        -- a = { "<cmd>RustHoverActions<Cr>", "Hover Actions" },
        -- a = { "<cmd>RustHoverRange<Cr>", "Hover Range" },
        -- j = { "<cmd>RustMoveItemDown<Cr>", "Move Item Down" },
        -- k = { "<cmd>RustMoveItemUp<Cr>", "Move Item Up" },
    },
}

which_key.register(mappings, opts)
