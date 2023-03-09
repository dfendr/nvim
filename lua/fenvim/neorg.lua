return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    lazy = true,
    ft = { "norg" },
    cmd = "Neorg",
    opts = {
        load = {
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
                },
            },
        },
    },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
}
