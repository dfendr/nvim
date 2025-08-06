return {
    -- auto resizing windows
    "anuvyklack/windows.nvim",
    dependencies = { "anuvyklack/middleclass" },
    event = "WinNew",
    config = true,
    opts = { ignore = {
        filetype = { "Outline" },
    } },
}
