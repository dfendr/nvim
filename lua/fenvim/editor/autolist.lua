local M = {}
function M.config()
    local status_ok, autolist = pcall(require, "autolist")
    if not status_ok then
        return
    end

    autolist.setup({
        enabled = true,
        create_enter_mapping = true,
        new_entry_on_o = true,
        list_cap = 50,
        colon = {
            indent_raw = true,
            indent = true,
            preferred = "-",
        },
        invert = {
            mapping = "<c-r>",
            normal_mapping = "",
            toggles_checkbox = true,
            ul_marker = "-",
            ol_incrementable = "1",
            ol_delim = ".",
        },
        lists = {
            preloaded = {
                generic = {
                    "unordered",
                    "digit",
                    "ascii",
                },
                latex = {
                    "latex_item",
                },
            },
            filetypes = {
                generic = {
                    "markdown",
                    "text",
                },
                latex = {
                    "tex",
                    "plaintex",
                },
            },
        },
        recal_hooks = {
            "invert",
            "new",
        },
        checkbox = {
            left = "%[",
            right = "%]",
            fill = "x",
        },
    })

    autolist.create_mapping_hook("i", "<CR>", autolist.new)
    autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
    autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
    autolist.create_mapping_hook("n", "o", autolist.new)
    autolist.create_mapping_hook("n", "O", autolist.new_before)
    autolist.create_mapping_hook("n", ">>", autolist.indent)
    autolist.create_mapping_hook("n", "<<", autolist.indent)
    autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
    autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
    vim.api.nvim_create_autocmd("TextChanged", {
        pattern = "*",
        callback = function()
            vim.cmd.normal({ autolist.force_recalculate(nil, nil), bang = false })
        end,
    })
end

return M
