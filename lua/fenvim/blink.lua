local M = {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    version = "1.0",
    enabled = true,
    dependencies = {
        "moyiz/blink-emoji.nvim",
        "Kaiser-Yang/blink-cmp-dictionary",
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
                return vim.bo.buftype ~= "prompt"
                    and vim.b.completion ~= false
                    -- Disable in LSP rename prompts
                    and not vim.list_contains({ "DressingInput" }, vim.bo.filetype)
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
                preset = "luasnip",
                -- This comes from the luasnip extra, if you don't add it, won't be able to
                -- jump forward or backward in luasnip snippets
                -- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
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
            cmdline = {},
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    sql = {
                        sql = { "snippets", "dadbod", "buffer" },
                    },
                },
                providers = {
                    snippets = {
                        name = "snippets",
                        -- score_offset = 25
                    },

                    dadbod = {
                        name = "Dadbod",
                        module = "vim_dadbod_completion.blink",
                    },

                    -- https://github.com/moyiz/blink-emoji.nvim
                    emoji = {
                        module = "blink-emoji",
                        name = "Emoji",
                        score_offset = 15, -- the higher the number, the higher the priority
                        opts = { insert = true }, -- Insert emoji (default) or complete its name
                    },
                    -- https://github.com/Kaiser-Yang/blink-cmp-dictionary
                    -- In macOS to get started with a dictionary:
                    -- cp /usr/share/dict/words ~/github/dotfiles-latest/dictionaries/words.txt
                    --
                    -- NOTE: For the word definitions make sure "wn" is installed
                    -- brew install wordnet
                    dictionary = {
                        module = "blink-cmp-dictionary",
                        name = "Dict",
                        score_offset = 20, -- the higher the number, the higher the priority
                        -- https://github.com/Kaiser-Yang/blink-cmp-dictionary/issues/2
                        enabled = true,
                        max_items = 8,
                        min_keyword_length = 3,
                        opts = {
                            -- -- The dictionary by default now uses fzf, make sure to have it
                            -- -- installed
                            -- -- https://github.com/Kaiser-Yang/blink-cmp-dictionary/issues/2
                            --
                            -- Do not specify a file, just the path, and in the path you need to
                            -- have your .txt files
                            dictionary_directories = { vim.fn.expand("~/github/dotfiles-latest/dictionaries") },
                            -- --  NOTE: To disable the definitions uncomment this section below
                            -- separate_output = function(output)
                            --   local items = {}
                            --   for line in output:gmatch("[^\r\n]+") do
                            --     table.insert(items, {
                            --       label = line,
                            --       insert_text = line,
                            --       documentation = nil,
                            --     })
                            --   end
                            --   return items
                            -- end,
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
