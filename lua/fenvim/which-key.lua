local M = { "folke/which-key.nvim" }
function M.config()
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
        return
    end

    local setup = {
        plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
                enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                motions = false, -- adds help for motions
                text_objects = true, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = "Comment" },
        key_labels = {
            -- override the label used to display some keys. It doesn't effect WK in any other way.
            -- For example:
            ["<space>"] = "SPC",
            ["<cr>"] = "RET",
            ["<tab>"] = "TAB",
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
            border = "rounded", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0,
        },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "left", -- align columns left, center or right
        },
        ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = false, -- show help message on the command line when the popup is visible
        show_keys = false,
        triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
        },
    }
    local xmappings = {
        S = {
            "<cmd> lua require('silicon').visualise_api({show_buf = true, to_clip = true})<cr>",
            "Screenshot Buffer,",
        },
        s = {
            "<cmd> lua require('silicon').visualise_api({show_buf = false, to_clip = true})<cr>",
            "Screenshot V-Selection",
        },
    }

    local mappings = {

        [";"] = { "<cmd>Alpha<cr>", "Dashboard" },
        [" "] = { "<cmd>nohl<cr>", "Clear Highlighting" },
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Action" },
        C = { "<cmd>bdelete!<CR>", "Close Buffer&Split" },
        c = { "<cmd>b#<bar>bd#<CR>", "Close Buffer" },
        e = {
            "<cmd>NvimTreeToggle<cr>",
            "Explorer",
        },
        h = { "<cmd>split<cr>", "split" },
        N = { "<cmd>lua require('telescope').extensions.notify.notify()<cr>", "Notifications" },

        P = { "<cmd> lua require('telescope').extensions.yank_history.yank_history({})<cr>", "Paste from Yanky" },
        R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        w = { "<cmd>w<CR>", "Write" },
        q = { '<cmd>lua require("utils.functions").smart_quit()<CR>', "Quit" },
        ["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
        v = { "<cmd>vsplit<cr>", "vsplit" },
        b = {
            name = "Buffers",
            j = { "<cmd>BufferLinePick<cr>", "Jump" },
            f = { "<cmd>Telescope buffers<cr>", "Find" },
            b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
            n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
            e = {
                "<cmd>BufferLinePickClose<cr>",
                "Pick which buffer to close",
            },
            h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
            l = {
                "<cmd>BufferLineCloseRight<cr>",
                "Close all to the right",
            },
            D = {
                "<cmd>BufferLineSortByDirectory<cr>",
                "Sort by directory",
            },
            L = {
                "<cmd>BufferLineSortByExtension<cr>",
                "Sort by language",
            },
        },

        n = {
            name = "New...",
            n = { "<cmd>enew<CR>", "New File" },
            s = { "<cmd> lua require('scratch').scratch()<cr>", "Create Scratch Buffer" },
        },

        p = {
            name = "Package Manager",
            o = { "<cmd>Lazy<cr>", "Open" },
            i = { "<cmd>Lazy install<cr>", "Install" },
            s = { "<cmd>Lazy sync<cr>", "Sync" },
            S = { "<cmd>Lazy profile<cr>", "Status" },
            u = { "<cmd>Lazy update<cr>", "Update" },
        },
        o = {
            name = "Options",
            b = { '<cmd>lua require("utils.functions").toggle_tabline()<cr>', "Toggle Bufferline" },
            c = { "<cmd>lua vim.g.cmp_active=false<cr>", "Completion off" },
            C = { "<cmd>lua vim.g.cmp_active=true<cr>", "Completion on" },
            h = { "<cmd>HexToggle<cr>", "Toggle Hex Editor" },
            W = { '<cmd>lua require("utils.functions").toggle_option("wrap")<cr>', "Wrap" },
            w = { "<cmd>WindowsToggleAutowidth<cr>", "Toggle Window Autowidth" },
            r = { '<cmd>lua require("utils.functions").toggle_option("relativenumber")<cr>', "Relative" },
            l = { '<cmd>lua require("utils.functions").toggle_option("cursorline")<cr>', "Cursorline" },
            s = { "<cmd>ScrollbarToggle<cr>", "Toggle Scrollbar" },
            m = {
                name = "Misc/Goofs",
                r = { "<cmd> CellularAutomaton make_it_rain<CR>", "Make it Rain" },
                l = { "<cmd> CellularAutomaton game_of_life<CR>", "Game of Life" },
                s = { "<cmd> CellularAutomaton slide<CR>", "Slide" },
            },
            S = { '<cmd>lua require("utils.functions").toggle_option("spell")<cr>', "Spell" },
            o = { '<cmd>lua require("utils.functions").open_explorer()<cr>exit<cr>', "Open in File Explorer" },
            O = { "<cmd>e $MYVIMRC | :cd %:p:h <CR>", "Open Options" },
            v = { "<cmd>:lua Toggle_venn()<CR>", "Toggle Drawing Mode (Venn)" },
            z = { "<cmd>ZenMode<cr>", "Zen" },
            t = { "<cmd>Twilight<cr>", "Twilight" },
        },
        f = {
            name = "Find",
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope commands<cr>", "Commands" },
            C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
            f = { '<cmd>lua require("telescope.builtin").find_files({hidden = true})<cr>', "Find files" },
            h = { "<cmd>Telescope help_tags<cr>", "Help" },
            H = { "<cmd>Telescope highlights<cr>", "Highlights" },
            i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
            l = { "<cmd>Telescope resume<cr>", "Last Search" },
            M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
            p = { "<cmd>Telescope lazy<cr>", "Find Plugins" },
            r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },

            R = { ":cd ~/Repos<CR> :Telescope find_files <CR>", "Search Repo Files" },
            s = { "<cmd>SearchSession<cr>", "Find Session" },
            S = {
                "<cmd>execute 'cd ' . fnamemodify(expand('$MYVIMRC'), ':p:h')<CR> :Telescope live_grep <CR>",
                "Search Settings",
            },
            T = { "<cmd>TodoTelescope<cr>", "Find TODOs" },
            t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
            k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
            w = { "<cmd>Telescope grep_string<cr>", "Find Word" },
            v = { "<cmd>Telescope vim_options<cr>", "Vim Options" },
        },
        s = {
            name = "Session",
            s = { "<cmd>SaveSession<cr>", "Save" },
            l = { "<cmd>LoadLastSession!<cr>", "Load Last" },
            r = { "<cmd>Autosession search<cr>", "Load Last Dir" },
            d = { "<cmd>Autosession delete<cr>", "Delete Session" },
            f = { "<cmd>SearchSession<cr>", "Find Session" },
        },

        d = {
            name = "Debug",
            b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
            c = { "<cmd>DapContinue<cr>", "Continue" },
            i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
            o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
            O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
            r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
            l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
            u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
            x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
        },

        g = {
            name = "Git",
            b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle Git Blame" },
            g = { "<cmd>lua _GITUI_TOGGLE()<CR>", "GitUI" },
            G = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "LazyGit" },
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            l = { "<cmd>GitBlameToggle<cr>", "Blame" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = {
                "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                "Undo Stage Hunk",
            },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            d = {
                "<cmd>Gitsigns diffthis HEAD<cr>",
                "Diff",
            },
        },

        l = {
            name = "LSP",
            a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            c = { "<cmd>Neogen<cr>", "Generate Annotation" },
            C = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },
            d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
            w = {
                "<cmd>Telescope lsp_workspace_diagnostics<cr>",
                "Workspace Diagnostics",
            },
            f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
            F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
            i = { "<cmd>LspInfo<cr>", "Info" },
            h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
            H = { "<cmd>IlluminateToggle<cr>", "Toggle Doc HL" },
            I = { "<cmd>Mason<cr>", "LSP Installer Info" },
            j = {
                "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
                "Next Diagnostic",
            },
            k = {
                "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
                "Prev Diagnostic",
            },
            v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
            l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
            o = { "<cmd>SymbolsOutline<cr>", "Outline" },
            q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
            r = {
                name = "Replace",
                R = { '<cmd>lua require("renamer").rename({empty = true})<cr>', "Rename" },
                r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
                w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
                f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
            },
            R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
            s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
            S = {
                "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                "Workspace Symbols",
            },
            t = { '<cmd>lua require("utils.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
            u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
        },

        r = {
            name = "Quickrun",
            r = { "<cmd>RunCode<cr>", "Run File" },
            f = { '<cmd>RunCode "float" float<cr>', "Run (Floating Window)" },
            t = { '<cmd>RunCode "toggleterm"<cr>', "Run (Terminal)" },
            q = { '<cmd>RunCode "toggle"quickfiwx<cr>', "Run (Quickfix)" },
        },

        t = {
            name = "Terminal",
            ["1"] = { ":1ToggleTerm<cr>", "1" },
            ["2"] = { ":2ToggleTerm<cr>", "2" },
            ["3"] = { ":3ToggleTerm<cr>", "3" },
            ["4"] = { ":4ToggleTerm<cr>", "4" },
            n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
            u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
            b = { "<cmd>lua _BTOP_TOGGLE()<cr>", "Btop" },
            p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
            s = { "<cmd>lua _SPT_TOGGLE()<cr>", "Spotify-TUI" },
            f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
            t = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
            v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
        },

        T = {
            name = "Treesitter",
            h = { "<cmd>Inspect<cr>", "Inspect Highlight Groups" },
            p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
            r = { "<cmd>TSToggle rainbow<cr>", "Rainbow" },
            c = { "<cmd>ColorizerToggle<cr>", "Toggle Colorizer" },
            g = { "<cmd>so $VIMRUNTIME/syntax/hitest.vim<cr>", "View Highlight Groups" },
        },

        z = {
            name = "Zen",
        },
    }

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    local m_opts = {
        mode = "n", -- NORMAL mode
        prefix = "m",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    local v_opts = {
        mode = "v", -- VISUAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    local xopts = {
        mode = "x", -- VISUAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    which_key.setup(setup)
    which_key.register(mappings, opts)
    which_key.register(xmappings, xopts)
    --which_key.register(m_mappings, m_opts)
end
return M
