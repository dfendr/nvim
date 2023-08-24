local M = { "folke/which-key.nvim" }
function M.config()
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
        return
    end

    local setup = {
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
            border = require("core.prefs").ui.which_key.border_style,
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

        [" "] = { "<cmd>nohl<cr>", "Clear Highlighting" },
        ["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
        [";"] = { "<cmd>Alpha<cr>", "Dashboard" },
        b = {
            name = "Buffers",
            b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
            C = { "<cmd>Bonly<cr>", "Close All Other Buffers" },
            D = { "<cmd>BufferLineSortByDirectory<cr>", "Sort by directory" },
            e = { "<cmd>BufferLinePickClose<cr>", "Pick which buffer to close" },
            f = { "<cmd>Telescope buffers<cr>", "Find" },
            h = { "<cmd>BufferLineCloseLeft<cr>", "Close All to the Left" },
            j = { "<cmd>BufferLinePick<cr>", "Jump" },
            l = { "<cmd>BufferLineCloseRight<cr>", "Close all to the right" },
            L = { "<cmd>BufferLineSortByExtension<cr>", "Sort by language" },
            n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
        },
        c = { "<cmd>b#<bar>bd#<CR>", "Close Buffer" },
        C = { "<cmd>bdelete!<CR>", "Close Buffer&Split" },
        d = {
            name = "Debug",
            b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
            c = { "<cmd>DapContinue<cr>", "Continue" },
            i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
            l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
            O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
            o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
            r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
            u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
            x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
        },
        e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
        f = {
            name = "Find",
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
            c = { "<cmd>Telescope commands<cr>", "Commands" },
            d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Cur. Buffer Diagnostics" },
            e = { "<cmd>Telescope file_browser<cr>", "File Browser" },
            f = { '<cmd>lua require("telescope.builtin").find_files({hidden = true})<cr>', "Find files" },
            h = { "<cmd>Telescope help_tags<cr>", "Help" },
            H = { "<cmd>Telescope highlights<cr>", "Highlights" },
            k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
            l = { "<cmd>Telescope resume<cr>", "Last Search" },
            m = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
            M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
            p = { "<cmd>Telescope lazy<cr>", "Find Plugins" },
            R = { ":cd ~/Repos<CR> :Telescope find_files <CR>", "Search Repo Files" },
            r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
            S = {
                "<cmd>execute 'cd ' . fnamemodify(expand('$MYVIMRC'), ':p:h')<CR> :Telescope live_grep <CR>",
                "Search Settings",
            },
            s = { "<cmd>SearchSession<cr>", "Find Session" },
            t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
            T = { "<cmd>TodoTelescope<cr>", "Find TODOs" },
            v = { "<cmd>Telescope vim_options<cr>", "Vim Options" },
            w = { "<cmd>Telescope grep_string<cr>", "Find Word" },
        },
        g = {
            name = "Git",
            b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle Git Blame" },
            B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            d = { "<cmd>DiffviewOpen<cr>", "Diff" },
            G = { "<cmd>lua _GITUI_TOGGLE()<CR>", "GitUI" },
            g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "LazyGit" },
            i = { "<cmd>Gitignore<cr>", "Generate gitignore" },
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
        },
        h = { "<cmd>split<cr>", "split" },
        N = { N = { "<cmd>Neorg workspace home<cr>", "Neorg Workspace" } },
        n = {
            name = "New...",
            n = { "<cmd>enew<CR>", "New File" },
            s = { "<cmd> lua require('scratch').scratch()<cr>", "Create Scratch Buffer" },
        },
        o = {
            name = "Options",
            b = { '<cmd>lua require("utils.functions").toggle_tabline()<cr>', "Toggle Bufferline" },
            c = { "<cmd>lua vim.g.cmp_active=false<cr>", "Completion off" },
            C = { "<cmd>lua vim.g.cmp_active=true<cr>", "Completion on" },
            d = { "<cmd>lua require('utils.functions').convert_to_dos()<CR>", "Convert to DOS Formatting" },
            h = { "<cmd>HexToggle<cr>", "Toggle Hex Editor" },
            l = { '<cmd>lua require("utils.functions").toggle_option("cursorline")<cr>', "Cursorline" },
            m = {
                name = "Misc/Goofs",
                r = { "<cmd> CellularAutomaton make_it_rain<CR>", "Make it Rain" },
                l = { "<cmd> CellularAutomaton game_of_life<CR>", "Game of Life" },
                s = { "<cmd> CellularAutomaton slide<CR>", "Slide" },
            },
            O = { "<cmd>e $MYVIMRC | :cd %:p:h <CR>", "Open Options" },
            o = { '<cmd>lua require("utils.functions").open_explorer()<cr>exit<cr>', "Open in File Explorer" },
            r = { '<cmd>lua require("utils.functions").toggle_option("relativenumber")<cr>', "Relative" },
            s = { "<cmd>ScrollbarToggle<cr>", "Toggle Scrollbar" },
            S = { '<cmd>lua require("utils.functions").toggle_option("spell")<cr>', "Spell" },
            t = { "<cmd>Twilight<cr>", "Twilight" },
            u = { "<cmd>lua require('utils.functions').convert_to_unix()<CR>", "Convert to Unix Formatting" },
            v = { "<cmd>:lua Toggle_venn()<CR>", "Toggle Drawing Mode (Venn)" },
            w = { "<cmd>WindowsToggleAutowidth<cr>", "Toggle Window Autowidth" },
            W = { '<cmd>lua require("utils.functions").toggle_option("wrap")<cr>', "Wrap" },
            z = { "<cmd>ZenMode<cr>", "Zen" },
        },
        q = { '<cmd>lua require("utils.functions").smart_close()<CR>', "Close Window" },
        Q = { '<cmd>lua require("utils.functions").smart_exit()<CR>', "Exit" },
        R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        r = {
            name = "Quickrun",
            f = { '<cmd>RunCode "float" float<cr>', "Run (Floating Window)" },
            q = { '<cmd>RunCode "toggle"quickfiwx<cr>', "Run (Quickfix)" },
            r = { "<cmd>RunCode<cr>", "Run File" },
            t = { '<cmd>RunCode "toggleterm"<cr>', "Run (Terminal)" },
        },
        S = {
            name = "Symbols",
            d = { ":normal a°<Esc>", "Insert °" },
            c = { ":normal a●<Esc>", "Insert °" },
            p = { ":normal aπ<Esc>", "Insert π" },
            u = { ":normal aµ<Esc>", "Insert µ" },
            m = { ":normal a♂<Esc>", "Insert ♂" },
            f = { ":normal a♀<Esc>", "Insert ♀" },
            s = {
                name = "Subscripts",
                ["0"] = { ":normal a₀<Esc>", "Insert subscript 0" },
                ["1"] = { ":normal a₁<Esc>", "Insert subscript 1" },
                ["2"] = { ":normal a₂<Esc>", "Insert subscript 2" },
                ["3"] = { ":normal a₃<Esc>", "Insert subscript 3" },
                ["4"] = { ":normal a₄<Esc>", "Insert subscript 4" },
                ["5"] = { ":normal a₅<Esc>", "Insert subscript 5" },
                ["6"] = { ":normal a₆<Esc>", "Insert subscript 6" },
                ["7"] = { ":normal a₇<Esc>", "Insert subscript 7" },
                ["8"] = { ":normal a₈<Esc>", "Insert subscript 8" },
                ["9"] = { ":normal a₉<Esc>", "Insert subscript 9" },
            },
            S = {
                name = "Superscripts",
                ["0"] = { ":normal a⁰<Esc>", "Insert superscript 0" },
                ["1"] = { ":normal a¹<Esc>", "Insert superscript 1" },
                ["2"] = { ":normal a²<Esc>", "Insert superscript 2" },
                ["3"] = { ":normal a³<Esc>", "Insert superscript 3" },
                ["4"] = { ":normal a⁴<Esc>", "Insert superscript 4" },
                ["5"] = { ":normal a⁵<Esc>", "Insert superscript 5" },
                ["6"] = { ":normal a⁶<Esc>", "Insert superscript 6" },
                ["7"] = { ":normal a⁷<Esc>", "Insert superscript 7" },
                ["8"] = { ":normal a⁸<Esc>", "Insert superscript 8" },
                ["9"] = { ":normal a⁹<Esc>", "Insert superscript 9" },
            },
            g = {
                name = "Greek Symbols",
                a = { ":normal aα<Esc>", "Insert α" },
                b = { ":normal aβ<Esc>", "Insert β" },
                c = { ":normal aχ<Esc>", "Insert χ" },
                d = { ":normal aδ<Esc>", "Insert δ" },
                e = { ":normal aε<Esc>", "Insert ε" },
                f = { ":normal aφ<Esc>", "Insert φ" },
                g = { ":normal aγ<Esc>", "Insert γ" },
                h = { ":normal aη<Esc>", "Insert η" },
                i = { ":normal aι<Esc>", "Insert ι" },
                k = { ":normal aκ<Esc>", "Insert κ" },
                l = { ":normal aλ<Esc>", "Insert λ" },
                m = { ":normal aµ<Esc>", "Insert µ" },
                n = { ":normal aν<Esc>", "Insert ν" },
                o = { ":normal aο<Esc>", "Insert ο" },
                p = { ":normal aπ<Esc>", "Insert π" },
                r = { ":normal aρ<Esc>", "Insert ρ" },
                s = { ":normal aσ<Esc>", "Insert σ" },
                S = { ":normal aΣ<Esc>", "Insert Σ" },
                t = { ":normal aθ<Esc>", "Insert θ" },
                u = { ":normal aτ<Esc>", "Insert τ" },
                v = { ":normal aυ<Esc>", "Insert υ" },
                w = { ":normal aω<Esc>", "Insert ω" },
                x = { ":normal aξ<Esc>", "Insert ξ" },
                y = { ":normal aψ<Esc>", "Insert ψ" },
                z = { ":normal aζ<Esc>", "Insert ζ" },
            },
        },
        s = {
            name = "Session",
            d = { "<cmd>Autosession delete<cr>", "Delete Session" },
            f = { "<cmd>SearchSession<cr>", "Find Session" },
            l = { "<cmd>SessionRestore<cr>", "Load Last" },
            r = { "<cmd>Autosession search<cr>", "Load Last Dir" },
            s = { "<cmd>SessionSave<cr>", "Save" },
        },
        t = {
            name = "Terminal",
            ["1"] = { ":1ToggleTerm<cr>", "1" },
            ["2"] = { ":2ToggleTerm<cr>", "2" },
            ["3"] = { ":3ToggleTerm<cr>", "3" },
            ["4"] = { ":4ToggleTerm<cr>", "4" },
            b = { "<cmd>lua _BTOP_TOGGLE()<cr>", "Btop" },
            f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
            n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
            p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
            s = { "<cmd>lua _SPT_TOGGLE()<cr>", "Spotify-TUI" },
            t = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
            u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
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
        v = { "<cmd>vsplit<cr>", "vsplit" },
        w = { "<cmd>w<CR>", "Write" },
        l = {
            name = "LSP",
            -- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            a = { "<cmd>lua require('actions-preview').code_action()<cr>", "Code Action" },
            d = { "<cmd>Neogen<cr>", "Generate Annotation" },
            F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
            f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
            H = { "<cmd>IlluminateToggle<cr>", "Toggle Doc HL" },
            i = { "<cmd>LspInfo<cr>", "Info" },
            I = { "<cmd>Mason<cr>", "LSP Installer Info" },
            j = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", "Next Diagnostic" },
            k = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", "Prev Diagnostic" },
            l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
            o = { "<cmd>SymbolsOutline<cr>", "Outline" },
            q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
            R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
            r = {
                name = "Replace",
                f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
                r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
                R = { '<cmd>lua require("renamer").rename({empty = true})<cr>', "Rename" },
                w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
            },
            s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
            S = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols" },
            t = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
            T = { '<cmd>lua require("utils.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
            u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
            v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
            w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
        },
        p = {
            name = "Package Manager",
            i = { "<cmd>Lazy install<cr>", "Install" },
            o = { "<cmd>Lazy<cr>", "Open" },
            S = { "<cmd>Lazy profile<cr>", "Status" },
            s = { "<cmd>Lazy sync<cr>", "Sync" },
            u = { "<cmd>Lazy update<cr>", "Update" },
        },
        z = { name = "Zen" },
    }

    -- If inc_rename installed, change rename command.
    local ok, _ = pcall(require, "inc_rename")
    if ok then
        mappings.R = { ":IncRename ", "Rename" }
    end

    -- If actions-preview is installed, change the code action command.
    local ok, _ = pcall(require, "actions-preview")
    if ok then
        mappings.l.a = { "<cmd>lua require('actions-preview').code_actions()<cr>", "Code Action" }
    end

    -- other mappings here ...

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
