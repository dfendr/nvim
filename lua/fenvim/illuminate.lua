return {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
        require("illuminate").configure({
            delay = 100,
            filetypes_denylist = {
                "alpha",
                "NvimTree",
                "nvimtree",
                "Telescope",
                "harpoon",
            },
            under_cursor = true,
        })

        local status_ok, map = pcall(function()
            return require("core.functions").map
        end)
        if status_ok then
            map("n", "]]", function() require("illuminate").goto_next_reference(false) end, { silent = true, noremap = true, nowait = true }, "Next Reference")
            map("n", "[[", function() require("illuminate").goto_prev_reference(false) end, { silent = true, noremap = true, nowait = true }, "Prev Reference")
        end
    end,
    keys = {
        {
            "]]",
            function()
                require("illuminate").goto_next_reference(false)
            end,
            desc = "Next Reference",
        },
        {
            "[[",
            function()
                require("illuminate").goto_prev_reference(false)
            end,
            desc = "Prev Reference",
        },
    },
}
