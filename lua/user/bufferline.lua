local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

--TODO: Take a look at the highlight groups. This config is a mess.

bufferline.setup({
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
        --         --- name_formatter can be used to change the buffer's label in the bufferline.
        --         --- Please note some names can/will break the
        --         --- bufferline so use this at your discretion knowing that it has
        --         --- some limitations that will *NOT* be fixed.
        --         name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
        --             -- remove extension from markdown files for example
        --             if buf.name:match('%.md') then
        --                 return vim.fn.fnamemodify(buf.name, ':t:r')
        --             end
        --         end,
        --         max_name_length = 18,
        --         max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        --         tab_size = 18,
        diagnostics = "nvim_lsp",
        --         diagnostics_update_in_insert = false,
        --         -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        --         diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --             return "("..count..")"
        --         end,
        --         -- NOTE: this will be called a lot so don't do any heavy processing here
        --         custom_filter = function(buf_number, buf_numbers)
        --             -- filter out filetypes you don't want to see
        --             if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        --                 return true
        --             end
        --             -- filter out by buffer name
        --             if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        --                 return true
        --             end
        --             -- filter out based on arbitrary rules
        --             -- e.g. filter out vim wiki buffer from tabline in your work repo
        --             if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        --                 return true
        --             end
        --             -- filter out by it's index number in list (don't show first buffer)
        --             if buf_numbers[1] ~= buf_number then
        --                 return true
        --             end
        --         end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true,
            },
        },

        color_icons = true, -- whether or not to add the filetype icon highlights
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_buffer_default_icon = true, -- whether or not an unrecognised filetype should show a default icon
        show_close_icon = false,
        show_tab_indicators = true,
        --         persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        --         -- can also be a table containing 2 custom separators
        --         -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = "thin", --[[ | "thin" | { 'any', 'any' }, ]]
        --         enforce_regular_tabs = false | true,
        always_show_bufferline = true, -- only show when two tabs up
        sort_by = "insert_at_end",
        --             -- add custom logic
        --             return buffer_a.modified > buffer_b.modified
        --         end

        --     }
        -- }
        -- },
    },

    highlights = {
        fill = {
            fg = { attribute = "fg", highlight = "#ff0000" },
            bg = { attribute = "bg", highlight = "#FFFFFF" },
        },
        -- background = {
        --     fg = { attribute = "fg", highlight = "TabLine" },
        --     bg = { attribute = "bg", highlight = "TabLine" },
        -- },
        buffer_selected = {
            fg = { attribute = "fg", highlight = "#ff0000" },
            -- --   bg = {attribute='bg',highlight='#0000ff'},
            -- --   gui = 'none'
        },
        buffer_visible = {
            fg = { attribute = "fg", highlight = "Comment", italic = false }, -- doesn't seem to work
            -- bg = { attribute = "bg", highlight = "CursorColumn" },
        },
        --
        -- close_button = {
        --     fg = { attribute = "fg", highlight = "Comment" },
        --     bg = { attribute = "bg", highlight = "TabLineSel" },
        -- },
        -- close_button_visible = {
        --     fg = { attribute = "fg", highlight = "CursorLine" },
        --     bg = { attribute = "bg", highlight = "TabLineSel" },
        -- },
        -- close_button_selected = {
        --   fg = {attribute='fg',highlight='CursorColumnSel'},
        --   bg ={attribute='bg',highlight='CursorColumnSel'}
        --   },
        --
        tab_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        -- tab = {
        --     fg = { attribute = "fg", highlight = "CursorColumn" },
        --     bg = { attribute = "bg", highlight = "CursorColumn" },
        -- },
        -- tab_close = {
        --     -- fg = {attribute='fg',highlight='LspDiagnosticsDefaultError'},
        --     fg = { attribute = "fg", highlight = "CursorColumnSel" },
        --     bg = { attribute = "bg", highlight = "Normal" },
        -- },
        --
        -- duplicate_selected = {
        --     fg = { attribute = "fg", highlight = "CursorLine", italic = true},
        --     bg = { attribute = "bg", highlight = "CursorColumnSel" },
        -- },
        -- duplicate_visible = {
        --     fg = { attribute = "fg", highlight = "CursorLine", italic = true },
        --     bg = { attribute = "bg", highlight = "CursorColumn" },
        -- },
        -- duplicate = {
        --     fg = { attribute = "fg", highlight = "CursorLine", italic = true },
        --     bg = { attribute = "bg", highlight = "CursorColumn" },
        -- },
        --
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
            fg = { attribute = "bg", highlight = "#FFFFFF" },
            bg = { attribute = "bg", highlight = "#FFFFFF" },
        },
        separator_visible = {
            fg = { attribute = "bg", highlight = "#FFFFFF" },
            bg = { attribute = "bg", highlight = "#FFFFFF" },
        },
        indicator_selected = {
            fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
    },
})
-- BufferLineIndicatorSelected = { fg = c.git.change },
-- BufferLineFill = { bg = c.black },

-- vim.cmd([[highlight! link BufferlineFill LineNr]])
-- vim.cmd [[highlight! link BufferlineIndicatorSelected TermCursor]]
