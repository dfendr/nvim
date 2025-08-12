local M = {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    version = "1.*",
    enabled = true,
    dependencies = {
        "moyiz/blink-emoji.nvim",
        "Kaiser-Yang/blink-cmp-dictionary",
        "L3MON4D3/LuaSnip", -- for snippets
        "rafamadriz/friendly-snippets", -- friendly snippets
        { "saghen/blink.compat", version = "2.*", opts = {} },
    },
    opts = function()
        local kind_icons = require("plugins.ui.icons").kind
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
                return vim.bo.buftype ~= "prompt"
                    and vim.b.completion ~= false
                    -- Disable in LSP rename prompts
                    and not vim.list_contains({ "DressingInput" }, vim.bo.filetype)
            end,

            keymap = {
                preset = "default",
                ["<C-j>"] = { "scroll_documentation_up", "fallback" },
                ["<C-k>"] = { "scroll_documentation_down", "fallback" },
                ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
                ["<C-e>"] = { "hide", "fallback" },
            },

            snippets = {
                preset = "luasnip",
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
                    auto_show = function(ctx)
                        return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
                    end,
                    border = prefs.completion_border,
                    draw = {
                        treesitter = { "lsp" },
                        columns = {
                            { "label", "label_description", gap = 2 },
                            { "kind_icon", "kind", gap = 1 },
                        },
                    },
                },
            },

            signature = {
                window = { border = prefs.signature_border },
            },

            cmdline = {
                keymap = { preset = "inherit" },
                completion = {
                    menu = {
                        auto_show = function()
                            return vim.fn.getcmdtype() == ":"
                        end,
                    },
                },
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    sql = { "snippets", "dadbod", "buffer" },
                },
                providers = {
                    -- built-in snippets provider can be tuned here if needed (e.g., score_offset)
                    dadbod = {
                        name = "Dadbod",
                        module = "vim_dadbod_completion.blink",
                    },

                    -- https://github.com/moyiz/blink-emoji.nvim
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15,
                        opts = { insert = true },
                    },

                    -- https://github.com/Kaiser-Yang/blink-cmp-dictionary
                    dictionary = {
                        module = "blink-cmp-dictionary",
                        name = "Dict",
                        score_offset = 20,
                        enabled = true,
                        max_items = 8,
                        min_keyword_length = 3,
                        opts = {
                            dictionary_directories = {
                                vim.fn.expand("~/github/dotfiles-latest/dictionaries"),
                            },
                        },
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

