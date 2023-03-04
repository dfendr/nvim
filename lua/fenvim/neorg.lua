return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.norg.dirman"] = { -- Manages Neorg workspaces
                ["core.integrations.telescope"] = {}, -- Telescope Integration
                config = {
                    workspaces = {
                        personal = "~/Repos/Personal/obsidian-vault/",
                        work = "~/Repos/Work/Notes/",
                    },
                },
            },
        },
    },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
}
