return {
    "nvim-neorg/neorg",
    enabled = false,
    build = ":Neorg sync-parsers",
    ft = { "norg" },
    cmd = "Neorg",
    opts = {
        load = {
            ["core.keybinds"] = {
                config = {
                    default_keybinds = true,
                    neorg_leader = ",",
                },
            },
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.norg.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.integrations.telescope"] = {}, -- Telescope Integration
            ["core.norg.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        personal = "~/Repos/Personal/Notes/",
                        work = "~/Repos/Work/Notes/",
                    },
                    index = "index.norg",
                },
            },
        },
    },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
}
