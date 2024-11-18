local M = {
    "saghen/blink.cmp",
    lazy = false,
    version = "v0.*",
    dependencies = {
        "L3MON4D3/LuaSnip", -- for snippets
        "rafamadriz/friendly-snippets", -- pre-configured snippets
    },
    opts = function()
        local kind_icons = require("fenvim.ui.icons").kind
        local prefs = require("core.prefs").ui.cmp

        return {
            -- replicate key bindings
            keymap = {
                preset = "default", -- use default preset as base
                ["<C-j>"] = { "scroll_documentation_up", "fallback" },
                ["<C-k>"] = { "scroll_documentation_down", "fallback" },
                ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-e>"] = { "hide", "fallback" },
            },
            -- appearance: dynamically use kind icons
            highlight = {
                use_nvim_cmp_as_default = true,
            },

            kind_icons = kind_icons,
            nerd_font_variant = "mono",
            -- snippet configuration
            trigger = { signature_help = { enabled = true } },
            accept = {
                auto_brackets = { enabled = true },
                expand_snippet = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            sources = {
                completion = {
                    enabled_providers = { "lsp", "path", "snippets", "buffer", "dadbod" },
                },
            },
            -- windows configuration
            windows = {
                autocomplete = {
                    border = prefs.completion_border,
                    auto_show = true,
                    selection = "preselect",
                },
                documentation = {
                    border = prefs.documentation_border,
                    auto_show = true,
                    auto_show_delay_ms = 500,
                },
            },
        }
    end,
    config = function(_, opts)
        local blink_cmp = require("blink.cmp")
        blink_cmp.setup(opts)

        -- configure luasnip
        local luasnip = require("luasnip")
        luasnip.config.setup({
            history = true,
            region_check_events = "InsertEnter",
            delete_check_events = "TextChanged,InsertLeave",
        })
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = { require("core.functions").get_snippet_path() } })
    end,
}

return M
