local M = {
    "nvim-telescope/telescope.nvim",
    -- tag = "0.1.6",
    branch = "master",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
        "nvim-telescope/telescope-media-files.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-dap.nvim",
        "BurntSushi/ripgrep",
        "tsakirist/telescope-lazy.nvim",
        "catgoose/telescope-helpgrep.nvim",
    },
}

function M.config()
    local status_ok, telescope = pcall(require, "telescope")
    if not status_ok then
        return
    end

    local actions = require("telescope.actions")
    local icons = require("plugins.ui.icons")

    telescope.setup({
        defaults = {

            prompt_prefix = icons.ui.Telescope .. " ",
            selection_caret = " ",
            path_display = { "filename_first" },
            file_ignore_patterns = {
                ".git/",
                "target/",
                "vendor/*",
                "%.lock",
                "__pycache__/*",
                "%.sqlite3",
                "%.ipynb",
                "node_modules/*",
                "%.svg",
                "%.otf",
                "%.ttf",
                "%.webp",
                ".dart_tool/",
                ".github/",
                ".gradle/",
                ".idea/",
                ".settings/",
                ".vscode/",
                "__pycache__/",
                "build/",
                "env/",
                "gradle/",
                "node_modules/",
                "%.pdb",
                "%.dll",
                "%.class",
                "%.exe",
                "%.cache",
                "%.ico",
                "%.pdf",
                "%.dylib",
                "%.jar",
                "%.docx",
                "%.met",
                "smalljre_*/*",
                ".vale/",
                "%.burp",
                "%.mp4",
                "%.mkv",
                "%.rar",
                "%.zip",
                "%.7z",
                "%.tar",
                "%.bz2",
                "%.epub",
                "%.flac",
                "%.tar.gz",
            },

            mappings = {
                i = {
                    -- ["<C-n>"] = actions.cycle_history_next,
                    -- ["<C-p>"] = actions.cycle_history_prev,

                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,

                    ["<C-b>"] = actions.results_scrolling_up,
                    ["<C-f>"] = actions.results_scrolling_down,

                    -- ["<C-c>"] = actions.close,

                    ["<CR>"] = actions.select_default,
                    ["<C-s>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,

                    ["<C-c>"] = require("telescope.actions").delete_buffer,

                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,

                    -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                    ["<Tab>"] = actions.close,
                    ["<S-Tab>"] = actions.close,
                    -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-l>"] = actions.complete_tag,
                    ["<C-h>"] = actions.which_key, -- keys from pressing <C-h>
                    ["<esc>"] = actions.close,
                },

                n = {
                    ["<esc>"] = actions.close,
                    ["<CR>"] = actions.select_default,
                    ["<C-x>"] = actions.select_horizontal,
                    ["<C-v>"] = actions.select_vertical,
                    ["<C-t>"] = actions.select_tab,
                    ["<C-b>"] = actions.results_scrolling_up,
                    ["<C-f>"] = actions.results_scrolling_down,

                    ["<Tab>"] = actions.close,
                    ["<S-Tab>"] = actions.close,
                    -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                    -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                    ["<C-n>"] = actions.move_selection_next,
                    ["<C-p>"] = actions.move_selection_previous,
                    ["j"] = actions.move_selection_next,
                    ["k"] = actions.move_selection_previous,
                    ["H"] = actions.move_to_top,
                    ["M"] = actions.move_to_middle,
                    ["L"] = actions.move_to_bottom,
                    ["q"] = actions.close,
                    ["dd"] = require("telescope.actions").delete_buffer,
                    ["s"] = actions.select_horizontal,
                    ["v"] = actions.select_vertical,
                    ["t"] = actions.select_tab,

                    ["<Down>"] = actions.move_selection_next,
                    ["<Up>"] = actions.move_selection_previous,
                    ["gg"] = actions.move_to_top,
                    ["G"] = actions.move_to_bottom,

                    ["<C-u>"] = actions.preview_scrolling_up,
                    ["<C-d>"] = actions.preview_scrolling_down,

                    ["<PageUp>"] = actions.results_scrolling_up,
                    ["<PageDown>"] = actions.results_scrolling_down,

                    ["?"] = actions.which_key,
                },
            },
        },
        pickers = {

            live_grep = {
                theme = "dropdown",
                additional_args = function(opts)
                    return { "--hidden" }
                end,
            },
            grep_string = {
                theme = "dropdown",
                grep_open_files = true,
            },
            find_files = {
                theme = "dropdown",
                find_command = { "rg", "--files", "--iglob", "!.git", "--hidden" },
                enable_preview = true,
                path_display = { "filename_first" },
            },
            buffers = {
                theme = "dropdown",
                enable_preview = false,
                initial_mode = "insert",
            },
            oldfiles = {
                theme = "dropdown",
                enable_preview = true,
                initial_mode = "insert",
                path_display = { "filename_first" },
            },

            planets = {
                show_pluto = true,
                show_moon = true,
            },
            colorscheme = {
                enable_preview = true,
            },
            lsp_references = {
                theme = "dropdown",
                initial_mode = "normal",
            },
            lsp_definitions = {
                theme = "dropdown",
                initial_mode = "normal",
            },
            lsp_declarations = {
                theme = "dropdown",
                initial_mode = "normal",
            },
            lsp_implementations = {
                theme = "dropdown",
                initial_mode = "normal",
            },
            man_pages = {
                sections = { "ALL" },
                -- initial_mode = "normal",
                -- man_cmd = { "apropos", "." }, -- Does this work on Linux also?
            },
        },
        extensions = {
            file_browser = {
                theme = "ivy",
                -- disables netrw and use telescope-file-browser in its place
                hijack_netrw = true,
                mappings = {
                    ["i"] = {
                        -- your custom insert mode mappings
                    },
                    ["n"] = {
                        -- your custom normal mode mappings
                    },
                },
            },
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case",
            },
            media_files = {
                -- filetypes whitelist
                filetypes = { "png", "webp", "jpg", "jpeg" },
                find_cmd = "rg", -- find command (defaults to `fd`)
            },
            helpgrep = {
                ignore_paths = {
                    vim.fn.stdpath("state") .. "/lazy/readme",
                },
            },
        },
    })

    telescope.load_extension("media_files")
    telescope.load_extension("file_browser")
    telescope.load_extension("fzf")
    telescope.load_extension("lazy")
    telescope.load_extension("helpgrep")
end

return M
