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
            text_objects = false, -- help for text objects triggered after entering an operator
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
    show_help = true, -- show help message on the command line when the popup is visible
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
-- //TODO: Get Align mapped to whichkey
-- local xmappings = {
--
--     a = {
--         name = "Align",
--         c = {"<cmd>lua require(user.functions).align_by_char()<CR>", "Align by Char" },
--     -- q = { '<cmd>lua require("user.functions").smart_quit()<CR>', "Quit" },
-- },
-- }

local mappings = {

    [";"] = { "<cmd>Alpha<cr>", "Dashboard" },
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Action" },
    c = { "<cmd>bdelete!<CR>", "Close Buffer" },
    e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    h = { "<cmd>split<cr>", "split" },
    n = { "<cmd>enew<CR>", "New File" },
    N = { "<cmd>lua require('telescope').extensions.notify.notify()<cr>", "Notifications" },
    R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    w = { "<cmd>w<CR>", "Write" },
    -- h = { "<cmd>nohlsearch<CR>", "No HL" },
    q = { '<cmd>lua require("user.functions").smart_quit()<CR>', "Quit" },
    ["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
    v = { "<cmd>vsplit<cr>", "vsplit" },
    b = {
        name = "Buffers",
        j = { "<cmd>BufferLinePick<cr>", "Jump" },
        f = { "<cmd>Telescope buffers<cr>", "Find" },
        b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
        n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
        -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
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

    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    o = {
        name = "Options",
        c = { "<cmd>lua vim.g.cmp_active=false<cr>", "Completion off" },
        C = { "<cmd>lua vim.g.cmp_active=true<cr>", "Completion on" },
        w = { '<cmd>lua require("user.functions").toggle_option("wrap")<cr>', "Wrap" },
        r = { '<cmd>lua require("user.functions").toggle_option("relativenumber")<cr>', "Relative" },
        l = { '<cmd>lua require("user.functions").toggle_option("cursorline")<cr>', "Cursorline" },
        s = { "<cmd>source %<cr>", "Source Current Buffer" },
        S = { '<cmd>lua require("user.functions").toggle_option("spell")<cr>', "Spell" },
        t = { '<cmd>lua require("user.functions").toggle_tabline()<cr>', "Tabline" },
        O = { "<cmd>e ~/.config/nvim/lua/user/options.lua<cr>", "Open Options" },
    },
    f = {
        name = "Find",
        b = { "<cmd>Telescope buffers<cr>", "Buffers" },
        B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope commands<cr>", "Commands" },
        C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>Telescope find_files<cr>", "Find files" },
        h = { "<cmd>Telescope help_tags<cr>", "Help" },
        H = { "<cmd>Telescope highlights<cr>", "Highlights" },
        i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
        l = { "<cmd>Telescope resume<cr>", "Last Search" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        R = { "<cmd>Telescope registers<cr>", "Registers" },
        s = { "<cmd>SearchSession<cr>", "Find Session" },
        T = { "<cmd>TodoTelescope<cr>", "Find TODOs" },
        t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        w = { "<cmd>Telescope grep_string<cr>", "Find Word" },
    },
    S = {
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
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
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
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Diff",
        },
    },

    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        c = { "<cmd>lua require('user.lsp').server_capabilities()<cr>", "Get Capabilities" },
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
        t = { '<cmd>lua require("user.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
        u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
    },

    r = {
        -- name = "Session",
        -- s = { "<cmd>SaveSession<cr>", "Save" },
        -- l = { "<cmd>LoadLastSession!<cr>", "Load Last" },
        -- d = { "<cmd>LoadCurrentDirSession!<cr>", "Load Last Dir" },
        -- f = { "<cmd>Telescope sessions save_current=false<cr>", "Find Session" },
        name = "Quickrun",
        r = { "<cmd>Jaq<cr>", "Run File" },
        f = { "<cmd>Jaq float<cr>", "Run (Floating Window)" },
        t = { "<cmd>Jaq terminal<cr>", "Run (Terminal)" },
        q = { "<cmd>Jaq quickfix<cr>", "Run (Quickfix)" },
        -- m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
        -- r = { "<cmd>SnipReset<cr>", "Reset" },
        -- t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
        -- x = { "<cmd>SnipTerminate<cr>", "Terminate" },
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
        --h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        t = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
    },

    T = {
        name = "Treesitter",
        h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
        p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
        r = { "<cmd>TSToggle rainbow<cr>", "Rainbow" },
        c = { "<cmd>ColorizerToggle<cr>", "Toggle Colorizer" },
        g = { "<cmd>so $VIMRUNTIME/syntax/hitest.vim<cr>", "View Highlight Groups" },
    },

    z = {
        name = "Zen",
        z = { "<cmd>ZenMode<cr>", "Zen" },
        t = { "<cmd>Twilight<cr>", "Twilight" },
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

local vopts = {
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
-- which_key.register(xmappings, xopts)
--which_key.register(m_mappings, m_opts)
