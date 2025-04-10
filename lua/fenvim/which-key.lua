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
                operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
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
    which_key.add({
        { "<leader>;", "<cmd>Alpha<cr>", desc = "Dashboard", nowait = true, remap = false },
        { "<leader>C", "<cmd>bdelete!<CR>", desc = "Close Buffer&Split", nowait = true, remap = false },
        { "<leader>D", "<cmd>DBUIToggle<cr>", desc = "Database Mode", nowait = true, remap = false },
        { "<leader>F", "<cmd>Telescope smart_open<cr>", desc = "Smart Search", nowait = true, remap = false },
        {
            "<leader>Q",
            '<cmd>lua require("core.functions").smart_exit()<CR>',
            desc = "Exit",
            nowait = true,
            remap = false,
        },
        { "<leader>R", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
        { "<leader>S", group = "Symbols", nowait = true, remap = false },

        { "<leader>SS", group = "Superscripts", nowait = true, remap = false },
        { "<leader>SS+", ":normal a⁺<Esc>", desc = "Insert superscript +", nowait = true, remap = false },
        { "<leader>SS-", ":normal a⁻<Esc>", desc = "Insert superscript -", nowait = true, remap = false },
        { "<leader>SS0", ":normal a⁰<Esc>", desc = "Insert superscript 0", nowait = true, remap = false },
        { "<leader>SS1", ":normal a¹<Esc>", desc = "Insert superscript 1", nowait = true, remap = false },
        { "<leader>SS2", ":normal a²<Esc>", desc = "Insert superscript 2", nowait = true, remap = false },
        { "<leader>SS3", ":normal a³<Esc>", desc = "Insert superscript 3", nowait = true, remap = false },
        { "<leader>SS4", ":normal a⁴<Esc>", desc = "Insert superscript 4", nowait = true, remap = false },
        { "<leader>SS5", ":normal a⁵<Esc>", desc = "Insert superscript 5", nowait = true, remap = false },
        { "<leader>SS6", ":normal a⁶<Esc>", desc = "Insert superscript 6", nowait = true, remap = false },
        { "<leader>SS7", ":normal a⁷<Esc>", desc = "Insert superscript 7", nowait = true, remap = false },
        { "<leader>SS8", ":normal a⁸<Esc>", desc = "Insert superscript 8", nowait = true, remap = false },
        { "<leader>SS9", ":normal a⁹<Esc>", desc = "Insert superscript 9", nowait = true, remap = false },
        { "<leader>Sc", ":normal a●<Esc>", desc = "Insert °", nowait = true, remap = false },
        { "<leader>Sd", ":normal a°<Esc>", desc = "Insert °", nowait = true, remap = false },
        { "<leader>Sf", "<cmd>IconPickerNormal<cr>", desc = "Find", nowait = true, remap = false },

        { "<leader>Sg", group = "Greek Symbols", nowait = true, remap = false },
        { "<leader>SgS", ":normal aΣ<Esc>", desc = "Insert Σ", nowait = true, remap = false },
        { "<leader>Sga", ":normal aα<Esc>", desc = "Insert α", nowait = true, remap = false },
        { "<leader>Sgb", ":normal aβ<Esc>", desc = "Insert β", nowait = true, remap = false },
        { "<leader>Sgc", ":normal aχ<Esc>", desc = "Insert χ", nowait = true, remap = false },
        { "<leader>Sgd", ":normal aδ<Esc>", desc = "Insert δ", nowait = true, remap = false },
        { "<leader>Sge", ":normal aε<Esc>", desc = "Insert ε", nowait = true, remap = false },
        { "<leader>Sgf", ":normal aφ<Esc>", desc = "Insert φ", nowait = true, remap = false },
        { "<leader>Sgg", ":normal aγ<Esc>", desc = "Insert γ", nowait = true, remap = false },
        { "<leader>Sgh", ":normal aη<Esc>", desc = "Insert η", nowait = true, remap = false },
        { "<leader>Sgi", ":normal aι<Esc>", desc = "Insert ι", nowait = true, remap = false },
        { "<leader>Sgk", ":normal aκ<Esc>", desc = "Insert κ", nowait = true, remap = false },
        { "<leader>Sgl", ":normal aλ<Esc>", desc = "Insert λ", nowait = true, remap = false },
        { "<leader>Sgm", ":normal aµ<Esc>", desc = "Insert µ", nowait = true, remap = false },
        { "<leader>Sgn", ":normal aν<Esc>", desc = "Insert ν", nowait = true, remap = false },
        { "<leader>Sgo", ":normal aο<Esc>", desc = "Insert ο", nowait = true, remap = false },
        { "<leader>Sgp", ":normal aπ<Esc>", desc = "Insert π", nowait = true, remap = false },
        { "<leader>Sgr", ":normal aρ<Esc>", desc = "Insert ρ", nowait = true, remap = false },
        { "<leader>Sgs", ":normal aσ<Esc>", desc = "Insert σ", nowait = true, remap = false },
        { "<leader>Sgt", ":normal aθ<Esc>", desc = "Insert θ", nowait = true, remap = false },
        { "<leader>Sgu", ":normal aτ<Esc>", desc = "Insert τ", nowait = true, remap = false },
        { "<leader>Sgv", ":normal aυ<Esc>", desc = "Insert υ", nowait = true, remap = false },
        { "<leader>Sgw", ":normal aω<Esc>", desc = "Insert ω", nowait = true, remap = false },
        { "<leader>Sgx", ":normal aξ<Esc>", desc = "Insert ξ", nowait = true, remap = false },
        { "<leader>Sgy", ":normal aψ<Esc>", desc = "Insert ψ", nowait = true, remap = false },
        { "<leader>Sgz", ":normal aζ<Esc>", desc = "Insert ζ", nowait = true, remap = false },

        { "<leader>Sl", group = "Logical", nowait = true, remap = false },
        { "<leader>Sla", ":normal a∧<Esc>", desc = "Insert ∧", nowait = true, remap = false },
        { "<leader>Sle", ":normal a∈<Esc>", desc = "Insert ∈", nowait = true, remap = false },
        { "<leader>Sln", ":normal a¬<Esc>", desc = "Insert ¬", nowait = true, remap = false },
        { "<leader>Sls", ":normal a<Esc>", desc = "Insert Σ", nowait = true, remap = false },
        { "<leader>Sp", ":normal aπ<Esc>", desc = "Insert π", nowait = true, remap = false },

        { "<leader>Ss", group = "Subscripts", nowait = true, remap = false },
        { "<leader>Ss+", ":normal a₊<Esc>", desc = "Insert subscript +", nowait = true, remap = false },
        { "<leader>Ss-", ":normal a₋<Esc>", desc = "Insert subscript -", nowait = true, remap = false },
        { "<leader>Ss0", ":normal a₀<Esc>", desc = "Insert subscript 0", nowait = true, remap = false },
        { "<leader>Ss1", ":normal a₁<Esc>", desc = "Insert subscript 1", nowait = true, remap = false },
        { "<leader>Ss2", ":normal a₂<Esc>", desc = "Insert subscript 2", nowait = true, remap = false },
        { "<leader>Ss3", ":normal a₃<Esc>", desc = "Insert subscript 3", nowait = true, remap = false },
        { "<leader>Ss4", ":normal a₄<Esc>", desc = "Insert subscript 4", nowait = true, remap = false },
        { "<leader>Ss5", ":normal a₅<Esc>", desc = "Insert subscript 5", nowait = true, remap = false },
        { "<leader>Ss6", ":normal a₆<Esc>", desc = "Insert subscript 6", nowait = true, remap = false },
        { "<leader>Ss7", ":normal a₇<Esc>", desc = "Insert subscript 7", nowait = true, remap = false },
        { "<leader>Ss8", ":normal a₈<Esc>", desc = "Insert subscript 8", nowait = true, remap = false },
        { "<leader>Ss9", ":normal a₉<Esc>", desc = "Insert subscript 9", nowait = true, remap = false },

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
        { "<leader>Tp", "<cmd>TSPlaygroundToggle<cr>", desc = "Playground", nowait = true, remap = false },
        { "<leader>Tr", "<cmd>TSToggle rainbow<cr>", desc = "Rainbow", nowait = true, remap = false },
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

        { "<leader>d", group = "Debug", nowait = true, remap = false },
        { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Out", nowait = true, remap = false },
        {
            "<leader>db",
            "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
            desc = "Breakpoint",
            nowait = true,
            remap = false,
        },
        { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue", nowait = true, remap = false },
        { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Into", nowait = true, remap = false },
        { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Last", nowait = true, remap = false },
        { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Over", nowait = true, remap = false },
        { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Repl", nowait = true, remap = false },
        { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "UI", nowait = true, remap = false },
        { "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", desc = "Exit", nowait = true, remap = false },
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
        { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find TODOs", nowait = true, remap = false },
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
        { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Projects", nowait = true, remap = false },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File", nowait = true, remap = false },
        {
            "<leader>fs",
            "<cmd>Telescope session-lens search_session<cr>",
            desc = "Find Session",
            nowait = true,
            remap = false,
        },
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
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
        { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
        { "<leader>lo", "<cmd>SymbolsOutline<cr>", desc = "Outline", nowait = true, remap = false },
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
        { "<leader>lt", "<cmd>TroubleToggle<cr>", desc = "Diagnostics", nowait = true, remap = false },
        {
            "<leader>lv",
            "<cmd>lua require('lsp_lines').toggle()<cr>",
            desc = "Virtual Text",
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

        { "<leader>r", group = "Quickrun", nowait = true, remap = false },
        {
            "<leader>rf",
            '<cmd>RunCode "float" float<cr>',
            desc = "Run (Floating Window)",
            nowait = true,
            remap = false,
        },
        { "<leader>rq", '<cmd>RunCode "toggle"quickfiwx<cr>', desc = "Run (Quickfix)", nowait = true, remap = false },
        { "<leader>rr", "<cmd>RunCode<cr>", desc = "Run File", nowait = true, remap = false },
        { "<leader>rt", '<cmd>RunCode "toggleterm"<cr>', desc = "Run (Terminal)", nowait = true, remap = false },

        { "<leader>s", group = "Session", nowait = true, remap = false },
        { "<leader>sd", "<cmd>Autosession delete<cr>", desc = "Delete Session", nowait = true, remap = false },
        { "<leader>sf", "<cmd>SearchSession<cr>", desc = "Find Session", nowait = true, remap = false },
        { "<leader>sl", "<cmd>SessionRestore<cr>", desc = "Load Last", nowait = true, remap = false },
        { "<leader>sr", "<cmd>Autosession search<cr>", desc = "Load Last Dir", nowait = true, remap = false },
        { "<leader>ss", "<cmd>SessionSave<cr>", desc = "Save", nowait = true, remap = false },

        { "<leader>t", group = "Terminal", nowait = true, remap = false },
        { "<leader>t1", ":1ToggleTerm<cr>", desc = "1", nowait = true, remap = false },
        { "<leader>t2", ":2ToggleTerm<cr>", desc = "2", nowait = true, remap = false },
        { "<leader>t3", ":3ToggleTerm<cr>", desc = "3", nowait = true, remap = false },
        { "<leader>t4", ":4ToggleTerm<cr>", desc = "4", nowait = true, remap = false },
        { "<leader>tb", "<cmd>lua _BTOP_TOGGLE()<cr>", desc = "Btop", nowait = true, remap = false },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", nowait = true, remap = false },
        { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node", nowait = true, remap = false },
        { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python", nowait = true, remap = false },
        { "<leader>ts", "<cmd>lua _SPT_TOGGLE()<cr>", desc = "Spotify-TUI", nowait = true, remap = false },
        {
            "<leader>tt",
            "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
            desc = "Horizontal",
            nowait = true,
            remap = false,
        },
        { "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "NCDU", nowait = true, remap = false },
        {
            "<leader>tv",
            "<cmd>ToggleTerm size=80 direction=vertical<cr>",
            desc = "Vertical",
            nowait = true,
            remap = false,
        },
        { "<leader>v", "<cmd>vsplit<cr>", desc = "vsplit", nowait = true, remap = false },
        { "<leader>w", "<cmd>w<CR>", desc = "Write", nowait = true, remap = false },
    })

    which_key.setup(setup)
end
return M
