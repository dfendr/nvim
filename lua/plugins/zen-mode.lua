-- The previous config was dead: it required "zenmode" (wrong module name) and
-- assigned to .setup instead of calling it, so none of it ever applied.
return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
        window = { width = 120 },
        plugins = {
            options = { ruler = false, showcmd = false, laststatus = 0 },
            twilight = { enabled = true },
        },
    },
}
