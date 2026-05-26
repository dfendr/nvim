local M = { "folke/which-key.nvim", event = "VeryLazy" }

---Set up plugin-specific groups cleanly with the plugin config.
---@param key string
---@param label string
vim.g.whichkeyAddGroup = function(key, label)
    -- delayed, to ensure whichkey spec is loaded & not interfere with whichkey's lazy-loading
    vim.defer_fn(function()
        local ok, whichkey = pcall(require, "which-key")
        if not ok then
            return
        end
        whichkey.add({ { key, group = label, mode = { "n", "x" } } })
    end, 1500)
end

--------------------------------------------------------------------------------

function M.config()
    local which_key = require("which-key")
    local setup = {
        icons = { mappings = false },
        plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
                enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                motions = false, -- adds help for motions
                text_objects = true, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
        },
        win = {
            -- don't allow the popup to overlap with the cursor
            -- no_overlap = true,
            border = require("core.prefs").ui.which_key.border_style,
        },

        -- win = {
        --     no_overlap = true,
        --     }
    }
    local mappings = {
        { "<leader>;", "<cmd>Alpha<cr>", desc = "Dashboard", nowait = true, remap = false },
        { "<leader>C", "<cmd>bdelete!<CR>", desc = "Close Buffer&Split", nowait = true, remap = false },
        { "<leader>D", "<cmd>DBUIToggle<cr>", desc = "Database Mode", nowait = true, remap = false },
        {
            "<leader>Q",
            '<cmd>lua require("core.functions").smart_exit()<CR>',
            desc = "Exit",
            nowait = true,
            remap = false,
        },
        { "<leader>R", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },

        { "<leader>T", group = "Treesitter", nowait = true, remap = false },
        {
            "<leader>TT",
            "<cmd>lua require('core.functions').toggle_treesitter_global()<CR>",
            desc = "Toggle TS Highlighting",
            nowait = true,
            remap = false,
        },
        {
            "<leader>Tg",
            "<cmd>so $VIMRUNTIME/syntax/hitest.vim<cr>",
            desc = "View Highlight Groups",
            nowait = true,
            remap = false,
        },
        { "<leader>Th", "<cmd>Inspect<cr>", desc = "Inspect Highlight Groups", nowait = true, remap = false },
        {
            "<leader>Tt",
            "<cmd>lua require('core.functions').toggle_treesitter_local()<CR>",
            desc = "Toggle Local TS Highlighting",
            nowait = true,
            remap = false,
        },

        { "<leader>W", "<cmd>wa<CR>", desc = "Save All Buffers", nowait = true, remap = false },

        { "<leader>b", group = "Buffers", nowait = true, remap = false },
        { "<leader>bC", "<cmd>Bonly<cr>", desc = "Close All Other Buffers", nowait = true, remap = false },
        {
            "<leader>bD",
            "<cmd>BufferLineSortByDirectory<cr>",
            desc = "Sort by directory",
            nowait = true,
            remap = false,
        },
        { "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", desc = "Sort by language", nowait = true, remap = false },
        { "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous", nowait = true, remap = false },
        {
            "<leader>be",
            "<cmd>BufferLinePickClose<cr>",
            desc = "Pick which buffer to close",
            nowait = true,
            remap = false,
        },
        { "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Find", nowait = true, remap = false },
        { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close All to the Left", nowait = true, remap = false },
        { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Jump", nowait = true, remap = false },
        {
            "<leader>bl",
            "<cmd>BufferLineCloseRight<cr>",
            desc = "Close all to the right",
            nowait = true,
            remap = false,
        },
        { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "Next", nowait = true, remap = false },
        { "<leader>c", "<cmd>b#<bar>bd#<CR>", desc = "Close Buffer", nowait = true, remap = false },

        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer", nowait = true, remap = false },

        { "<leader>f", group = "Find", nowait = true, remap = false },
        { "<leader>fB", "<cmd>Telescope git_branches<cr>", desc = "Branch", nowait = true, remap = false },
        { "<leader>fC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
        {
            "<leader>fD",
            "<cmd>Telescope lsp_document_symbols<cr>",
            desc = "Document Symbols",
            nowait = true,
            remap = false,
        },
        { "<leader>fH", "<cmd>Telescope helpgrep<cr>", desc = "Grep Help", nowait = true, remap = false },
        { "<leader>fM", "<cmd>Telescope marks<cr>", desc = "Marks", nowait = true, remap = false },
        { "<leader>fP", "<cmd>Telescope lazy<cr>", desc = "Find Plugins", nowait = true, remap = false },
        {
            "<leader>fR",
            ":cd ~/Repos<CR> :Telescope find_files <CR>",
            desc = "Search Repo Files",
            nowait = true,
            remap = false,
        },
        {
            "<leader>fS",
            "<cmd>execute 'cd ' . fnamemodify(expand('$MYVIMRC'), ':p:h')<CR> :Telescope live_grep <CR>",
            desc = "Search Settings",
            nowait = true,
            remap = false,
        },
        { "<leader>f1", "<cmd>TodoTelescope<cr>", desc = "Find TODOs (#1 to mark off)", nowait = true, remap = false },
        {
            "<leader>fT",
            '<cmd>lua require("telescope.builtin").live_grep({ prompt_title = "Live Grep (all, incl. ignored)", additional_args = function() return {"--hidden", "--no-ignore"} end })<cr>',
            desc = "Find Text (all, incl. ignored)",
            nowait = true,
            remap = false,
        },
        { "<leader>fW", "<cmd>Telescope grep_string<cr>", desc = "Find Word", nowait = true, remap = false },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers", nowait = true, remap = false },
        { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
        {
            "<leader>fd",
            "<cmd>Telescope diagnostics bufnr=0<cr>",
            desc = "Cur. Buffer Diagnostics",
            nowait = true,
            remap = false,
        },
        { "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Browser", nowait = true, remap = false },
        {
            "<leader>fF",
            '<cmd>lua require("telescope.builtin").find_files({ prompt_title = "Find Files (all, incl. ignored)", hidden = true, no_ignore = true })<cr>',
            desc = "Find Files (all, incl. ignored)",
            nowait = true,
            remap = false,
        },
        {
            "<leader>ff",
            '<cmd>lua require("telescope.builtin").find_files({hidden = true})<cr>',
            desc = "Find Files",
            nowait = true,
            remap = false,
        },
        { "<leader>fg", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups", nowait = true, remap = false },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help", nowait = true, remap = false },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
        { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search", nowait = true, remap = false },
        { "<leader>fm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File", nowait = true, remap = false },
        { "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Find Text", nowait = true, remap = false },
        { "<leader>fv", "<cmd>Telescope vim_options<cr>", desc = "Vim Options", nowait = true, remap = false },
        {
            "<leader>fw",
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            desc = "Workspace Symbols",
            nowait = true,
            remap = false,
        },

        { "<leader>g", group = "Git", nowait = true, remap = false },
        { "<leader>gB", "<cmd>Telescope git_branches<cr>", desc = "Checkout Branch", nowait = true, remap = false },
        { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "CloseDiff", nowait = true, remap = false },
        { "<leader>gG", "<cmd>lua _GITUI_TOGGLE()<CR>", desc = "GitUI", nowait = true, remap = false },
        {
            "<leader>gR",
            "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
            desc = "Reset Buffer",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gb",
            "<cmd>Gitsigns toggle_current_line_blame<CR>",
            desc = "Toggle Git Blame",
            nowait = true,
            remap = false,
        },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
        { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff", nowait = true, remap = false },
        { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "LazyGit", nowait = true, remap = false },
        { "<leader>gi", "<cmd>Gitignore<cr>", desc = "Generate gitignore", nowait = true, remap = false },
        {
            "<leader>gj",
            "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
            desc = "Next Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gk",
            "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
            desc = "Prev Hunk",
            nowait = true,
            remap = false,
        },
        { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
        {
            "<leader>gp",
            "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
            desc = "Preview Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gr",
            "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
            desc = "Reset Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gs",
            "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
            desc = "Stage Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gu",
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            desc = "Undo Stage Hunk",
            nowait = true,
            remap = false,
        },
        { "<leader>h", "<cmd>split<cr>", desc = "split", nowait = true, remap = false },

        { "<leader>l", group = "LSP", nowait = true, remap = false },
        { "<leader>lC", "<cmd>ConformInfo<CR>", desc = "Formatting Info", nowait = true, remap = false },
        { "<leader>lF", "<cmd>LspToggleAutoFormat<cr>", desc = "Toggle Autoformat", nowait = true, remap = false },
        { "<leader>lH", "<cmd>IlluminateToggle<cr>", desc = "Toggle Doc HL", nowait = true, remap = false },
        { "<leader>lI", "<cmd>Mason<cr>", desc = "LSP Installer Info", nowait = true, remap = false },
        {
            "<leader>lS",
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            desc = "Workspace Symbols",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lT",
            '<cmd>lua require("core.functions").toggle_diagnostics()<cr>',
            desc = "Toggle Diagnostics",
            nowait = true,
            remap = false,
        },
        {
            "<leader>la",
            "<cmd>lua require('actions-preview').code_actions()<cr>",
            desc = "Code Action",
            nowait = true,
            remap = false,
        },
        { "<leader>ld", "<cmd>Neogen<cr>", desc = "Generate Annotation", nowait = true, remap = false },
        { "<leader>lf", "<cmd>FormatBuffer<cr>", desc = "Format Buffer", nowait = true, remap = false },
        {
            "<leader>lh",
            "<cmd>lua require('core.functions').toggle_inlay_hints()<CR>",
            desc = "Toggle Inlay Hints",
            nowait = true,
            remap = false,
        },
        {
            "<leader>li",
            '<cmd>lua require("core.functions").show_lsp_info()<cr>',
            desc = "Info",
            nowait = true,
            remap = false,
        },
        { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
        { "<leader>lo", "<cmd>Outline<cr>", desc = "Outline", nowait = true, remap = false },
        {
            "<leader>lq",
            "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
            desc = "Quickfix",
            nowait = true,
            remap = false,
        },
        {
            "<leader>ls",
            "<cmd>Telescope lsp_document_symbols<cr>",
            desc = "Document Symbols",
            nowait = true,
            remap = false,
        },
        { "<leader>lt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics", nowait = true, remap = false },
        {
            "<leader>lv",
            function()
                local cfg = vim.diagnostic.config()
                vim.diagnostic.config({
                    virtual_lines = not cfg.virtual_lines,
                    virtual_text = cfg.virtual_lines and true or false,
                })
            end,
            desc = "Toggle Virtual Lines",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lw",
            "<cmd>Telescope diagnostics<cr>",
            desc = "Workspace Diagnostics",
            nowait = true,
            remap = false,
        },

        { "<leader>n", group = "New...", nowait = true, remap = false },
        { "<leader>nn", "<cmd>enew<CR>", desc = "New File", nowait = true, remap = false },
        {
            "<leader>ns",
            "<cmd> lua require('scratch').scratch()<cr>",
            desc = "Create Scratch Buffer",
            nowait = true,
            remap = false,
        },

        { "<leader>o", group = "Options", nowait = true, remap = false },
        {
            "<leader>od",
            "<cmd>lua require('core.functions').convert_to_dos()<CR>",
            desc = "Convert to DOS Formatting",
            nowait = true,
            remap = false,
        },
        { "<leader>oH", "<cmd>HexToggle<cr>", desc = "Toggle Hex Editor", nowait = true, remap = false },
        { "<leader>og", "<cmd>GuessIndent<cr>", desc = "Guess Indentation", nowait = true, remap = false },
        { "<leader>ok", "<cmd>Screenkey<cr>", desc = "Toggle Show Keypresses", nowait = true, remap = false },
        {
            "<leader>oo",
            '<cmd>lua require("core.functions").open_explorer()<cr>',
            desc = "Open in File Explorer",
            nowait = true,
            remap = false,
        },
        { "<leader>os", "<cmd>ScrollbarToggle<cr>", desc = "Toggle Scrollbar", nowait = true, remap = false },
        { "<leader>ot", "<cmd>Twilight<cr>", desc = "Twilight", nowait = true, remap = false },
        {
            "<leader>ou",
            "<cmd>lua require('core.functions').convert_to_unix()<CR>",
            desc = "Convert to Unix Formatting",
            nowait = true,
            remap = false,
        },
        {
            "<leader>oW",
            "<cmd>WindowsToggleAutowidth<cr>",
            desc = "Toggle Window Autowidth",
            nowait = true,
            remap = false,
        },
        { "<leader>oz", "<cmd>ZenMode<cr>", desc = "Zen", nowait = true, remap = false },

        { "<leader>p", group = "Package Manager", nowait = true, remap = false },
        { "<leader>pS", "<cmd>Lazy profile<cr>", desc = "Status", nowait = true, remap = false },
        { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install", nowait = true, remap = false },
        { "<leader>po", "<cmd>Lazy<cr>", desc = "Open", nowait = true, remap = false },
        { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync", nowait = true, remap = false },
        { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update", nowait = true, remap = false },
        {
            "<leader>q",
            '<cmd>lua require("core.functions").smart_close()<CR>',
            desc = "Close Window",
            nowait = true,
            remap = false,
        },

        { "<leader>v", "<cmd>vsplit<cr>", desc = "vsplit", nowait = true, remap = false },
        { "<leader>w", "<cmd>w<CR>", desc = "Write", nowait = true, remap = false },
    }

    vim.list_extend(mappings, require("plugins.keymaps.symbols"))
    which_key.add(mappings)

    which_key.setup(setup)
end
return M
