local cmdline = true
local M = {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {

        "onsails/lspkind.nvim",
        "windwp/nvim-autopairs",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "f3fora/cmp-spell",
        "SergioRibera/cmp-dotenv",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        { "hrsh7th/cmp-cmdline", enabled = cmdline },
        { "dmitmel/cmp-cmdline-history", enabled = cmdline },
        "hrsh7th/cmp-path",
        {
            "allaman/emoji.nvim",
            ft = "markdown",
            dependencies = {
                --  for nvim-cmp integration
                "hrsh7th/nvim-cmp",
            },
            opts = {
                enable_cmp_integration = true,
            },
        },
    },

    enabled = true,
}

function M.config()
    vim.o.completeopt = "menuone,noselect"

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { require("core.functions").get_snippet_path() } })
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
        return
    end
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

    local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    local kind_icons = require("fenvim.ui.icons").kind

    local prefs = require("core.prefs").ui.cmp

    local luasnip = require("luasnip")
    luasnip.config.setup({
        history = true,
        region_check_events = "InsertEnter",
        delete_check_events = "TextChanged,InsertLeave",
    })
    cmp.setup({
        completion = {
            completeopt = "menu,menuone,noinsert",
        },
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },

        mapping = cmp.mapping.preset.insert({
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-k>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
            ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ["<C-e>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if luasnip.expandable() then
                    luasnip.expand({})
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif check_backspace() then
                    fallback()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
        }),
        formatting = {
            fields = { "abbr", "kind", "menu" },
            format = function(entry, vim_item)
                vim_item.menu_hl_group = "CmpItemKind" .. vim_item.kind
                vim_item.menu = vim_item.kind
                vim_item.abbr = vim_item.abbr:sub(1, 30)
                vim_item.kind = kind_icons[vim_item.kind]
                return vim_item
            end,
        },
        sources = {
            { name = "nvim_lsp_signature_help" },
            {
                name = "dotenv",
                enable_in_context = function()
                    local filetypes = { "rs", "lua", "sh", "zsh" }
                    for _, v in pairs(filetypes) do
                        if vim.bo.filetype == v then
                            return true
                        end
                    end
                    return false
                end,
            },
            {
                name = "spell",
                option = { keep_all_entries = false },
                enable_in_context = function()
                    return vim.bo.filetype == "md"
                end,
            },
            { name = "neorg" },
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "luasnip" },
            { name = "path" },
            { name = "emoji" },
            -- { name = "nvim_lua" },
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        experimental = {
            ghost_text = false,
            -- native_menu = true,
        },
        window = {

            completion = cmp.config.window.bordered({
                border = prefs.completion_border,
                winhighlight = prefs.winhighlight,
            }),
            documentation = cmp.config.window.bordered({
                border = prefs.documentation_border,
                winhighlight = prefs.winhighlight,
            }),
        },
        -- view = { entries = { follow_cursor = true } },
    })

    if cmdline then
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                -- { name = "noice_popupmenu" },
                { name = "path" },
                { name = "cmdline" },
                -- { name = "cmdline_history" },
            }),
        })
    end

    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end

return M
