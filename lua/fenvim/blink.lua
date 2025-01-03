local M = {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    version = "v0.*",
    dependencies = {
        "L3MON4D3/LuaSnip", -- for snippets
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets", -- friendly snippets
        { "saghen/blink.compat", version = "*", opts = { impersonate_nvim_cmp = true } },
    },
    opts = function()
        local kind_icons = require("fenvim.ui.icons").kind
        local prefs = require("core.prefs").ui.blink_cmp

        return {
            appearance = {
                kind_icons = kind_icons,
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },
            enabled = function()
                -- disable completion during `/` or `?` buffer search
                local mode = vim.api.nvim_get_mode().mode
                if mode == "c" then
                    local cmdtype = vim.fn.getcmdtype()
                    if cmdtype == "/" or cmdtype == "?" then
                        return false
                    end
                end
                return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
            end,
            keymap = {
                preset = "default", -- default keymap
                ["<C-j>"] = { "scroll_documentation_up", "fallback" },
                ["<C-k>"] = { "scroll_documentation_down", "fallback" },
                ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-e>"] = { "hide", "fallback" },
            },
            snippets = {
                expand = function(snippet)
                    require("luasnip").lsp_expand(snippet)
                end,

                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction)
                    require("luasnip").jump(direction)
                end,
            },
            completion = {
                documentation = {
                    window = { border = prefs.documentation_border },
                    auto_show = true,
                    auto_show_delay_ms = 100,
                    treesitter_highlighting = true,
                },
                keyword = {
                    range = "prefix",
                },
                menu = {
                    border = prefs.completion_border,
                    draw = {
                        treesitter = { "lsp" },
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind", gap = 1 },
                        },
                    },
                },
            },
            signature = {
                window = { border = prefs.signature_border },
            },
            sources = {
                default = { "lsp", "luasnip", "path", "snippets", "buffer", "dadbod" },
                cmdline = {},
                providers = {
                    luasnip = {
                        name = "luasnip",
                        module = "blink.compat.source",
                        score_offset = -3,
                        opts = {
                            use_show_condition = false,
                            show_autosnippets = true,
                        },
                    },
                    dadbod = {
                        name = "Dadbod",
                        module = "vim_dadbod_completion.blink",
                    },
                },
            },
        }
    end,
    config = function(_, opts)
        local blink_cmp = require("blink.cmp")
        blink_cmp.setup(opts)

        local luasnip = require("luasnip")
        luasnip.config.setup({
            history = true,
            region_check_events = "InsertEnter",
            delete_check_events = "TextChanged,InsertLeave",
        })

        -- Load friendly snippets
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/snippets" },
        })
    end,
}

return M
