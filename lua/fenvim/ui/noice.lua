local M = {}

function M.config()
    require("noice").setup({
        lsp = {
            progress = {
                enabled = false,
                -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
                -- See the section on formatting for more details on how to customize.
                --- @type NoiceFormat|string
                format = "lsp_progress",
                --- @type NoiceFormat|string
                format_done = "lsp_progress_done",
                throttle = 1000 / 10, -- frequency to update lsp progress message
                view = "notify",
                -- view = "mini",
            },
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = false,
            },
            hover = {
                enabled = false,
                view = nil, -- when nil, use defaults from documentation
                ---@type NoiceViewOptions
                opts = {}, -- merged with defaults from documentation
            },
            signature = {
                enabled = false,
                auto_open = {
                    enabled = false,
                    trigger = false, -- Automatically show signature help when typing a trigger character from the LSP
                    luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                    throttle = 50, -- Debounce lsp signature help request by 50ms
                },
            },
        },
        smart_move = { enabled = true },
        health = { checker = true },
        presets = {
            bottom_search = true,
            command_palette = false,
            long_message_to_split = true,
            inc_rename = true,
            lsp_doc_border = true,
        },
    })
end
return M
