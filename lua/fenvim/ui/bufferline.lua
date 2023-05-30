local M = {}
function M.config()
    local status_ok, bufferline = pcall(require, "bufferline")
    if not status_ok then
        return
    end

    local opts = {
        options = {
            --         mode = "buffers", -- set to "tabs" to only show tabpages instead
            --         numbers = "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
            close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
            right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
            left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
            --         middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
            indicator = {
                icon = "▎", -- this should be omitted if indicator style is not 'icon'
                style = "icon",
            },
            buffer_close_icon = "X",
            -- buffer_close_icon = "",
            modified_icon = "*",
            close_icon = "",
            left_trunc_marker = "",
            right_trunc_marker = "",
            diagnostics = "nvim_lsp",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "left",
                    separator = true,
                },
                {
                    filetype = "neo-tree",
                    text = "EXPLORER",
                    text_align = "left",
                    -- separator = true,
                },
            },

            color_icons = true, -- whether or not to add the filetype icon highlights
            show_buffer_icons = true, -- disable filetype icons for buffers
            show_buffer_close_icons = true,
            -- get_element_icon = function(element)
            --     return require("bufferline").get_element_icon(element.name, { default = true })
            -- end,
            show_close_icon = false,
            show_tab_indicators = true,
            --         persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            --         -- can also be a table containing 2 custom separators
            --         -- [focused and unfocused]. eg: { '|', '|' }
            separator_style = "thin", --[[ | "thin" | { 'any', 'any' }, ]]
            --         enforce_regular_tabs = false | true,
            always_show_bufferline = false, -- only show when two tabs up
            sort_by = "insert_at_end",
            --             -- add custom logic
            --             return buffer_a.modified > buffer_b.modified
            --         end

            --     }
            -- }
            -- },
        },

        highlights = {
            buffer_selected = {
                fg = "#E7D7AD",
                -- --   bg = {attribute='bg',highlight='#0000ff'},
                -- --   gui = 'none'
            },
            buffer_visible = {
                fg = { attribute = "fg", highlight = "Comment", italic = false }, -- doesn't seem to work
                -- bg = { attribute = "bg", highlight = "CursorColumn" },
            },
            tab_selected = {
                fg = { attribute = "fg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
            modified = {
                fg = { attribute = "fg", highlight = "Comment" },
                -- bg = { attribute = "bg", highlight = "CursorColumn" },
            },
            modified_selected = {
                fg = { attribute = "fg", highlight = "Normal" },
                -- bg = { attribute = "bg", highlight = "Normal" },
            },
            modified_visible = {
                --     fg = { attribute = "fg", highlight = "CursorLine" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
            --
            separator = {
                fg = { attribute = "bg", highlight = "Normal" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
            separator_selected = {
                fg = "#FFFFFF",
                bg = "#FFFFFF",
            },
            separator_visible = {
                fg = "#FFFFFF",
                bg = "#FFFFFF",
            },
            indicator_selected = {
                fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
                bg = { attribute = "bg", highlight = "Normal" },
            },
        },
    }

    if vim.api.nvim_exec2("colo", { output = true }) == "fenbox" then
        opts.highlights.fill = { bg = "#171919" }
    end

    bufferline.setup(opts)
end
return M
