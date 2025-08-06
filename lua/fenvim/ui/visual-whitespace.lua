return
    {
        "mcauley-penney/visual-whitespace.nvim",
        opts = {
            space_char = "·",
            tab_char = "→",
            nl_char = "↲",
            cr_char = "←",
            enabled = true,
            excluded = {
                filetypes = {},
                buftypes = {},
            },
        },
        config = function(_, opts)
            local normal = vim.api.nvim_get_hl(0, { name = "CursorLineNr", link = false })
            local visual = vim.api.nvim_get_hl(0, { name = "Visual", link = false })
            opts.highlight = {
                fg = string.format("#%06x", normal.fg),
                bg = string.format("#%06x", visual.bg),
            }

            require("visual-whitespace").setup(opts)
        end,
    },
