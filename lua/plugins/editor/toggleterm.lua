local M = {}

function M.config()
    local status_ok, toggleterm = pcall(require, "toggleterm")
    if not status_ok then
        return
    end

    toggleterm.setup({
        size = 20,
        open_mapping = [[<m-0>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
            winblend = 0,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
    })

    function _G.set_terminal_keymaps()
        local opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, "t", "<m-h>", [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<m-j>", [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<m-k>", [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, "t", "<m-l>", [[<C-\><C-n><C-W>l]], opts)
    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    local Terminal = require("toggleterm.terminal").Terminal

    function _GITUI_TOGGLE()
        local gitui = Terminal:new({
            cmd = "gitui",
            hidden = true,
            direction = "float",
            float_opts = {
                border = "none",
                width = 100000,
                height = 100000,
            },
            on_open = function(_)
                vim.cmd("startinsert!")
                -- vim.cmd "set laststatus=0"
            end,
            on_close = function(_)
                -- vim.cmd "set laststatus=3"
            end,
            count = 99,
        })
        gitui:toggle()
    end

    function _LAZYGIT_TOGGLE()
        local lazygit = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
            float_opts = {
                border = "none",
                width = 100000,
                height = 100000,
            },
            on_open = function(_)
                vim.cmd("startinsert!")
                -- vim.cmd "set laststatus=0"
            end,
            on_close = function(_)
                -- vim.cmd "set laststatus=3"
            end,
            count = 99,
        })
        lazygit:toggle()
    end

    function _SLIDES_TOGGLE()
        local slides = Terminal:new({
            cmd = "slides " .. vim.fn.expand("%:p"),
            hidden = true,
            direction = "float",
            float_opts = {
                border = "none",
                width = 100000,
                height = 100000,
            },
            on_open = function(_)
                vim.cmd("startinsert!")
                -- vim.cmd "set laststatus=0"
            end,
            on_close = function(_)
                -- vim.cmd "set laststatus=3"
            end,
            count = 99,
        })
        slides:toggle()
    end

    function __TOGGLE()
        local slides = Terminal:new({
            cmd = "slides " .. vim.fn.expand("%:p"),
            hidden = true,
            direction = "float",
            float_opts = {
                border = "none",
                width = 100000,
                height = 100000,
            },
            on_open = function(_)
                vim.cmd("startinsert!")
                -- vim.cmd "set laststatus=0"
            end,
            on_close = function(_)
                -- vim.cmd "set laststatus=3"
            end,
            count = 99,
        })
        slides:toggle()
    end

    function _SPT_TOGGLE()
        local spotify = Terminal:new({
            cmd = "spt",
            hidden = true,
            direction = "float",
            float_opts = {
                border = "none",
                width = 100000,
                height = 100000,
            },
            on_open = function(_)
                vim.cmd("startinsert!")
                -- vim.cmd "set laststatus=0"
            end,
            on_close = function(_)
                -- vim.cmd "set laststatus=3"
            end,
            count = 99,
        })
        spotify:toggle()
    end

    function _NODE_TOGGLE()
        local node = Terminal:new({ cmd = "node", hidden = true })
        node:toggle()
    end

    function _NCDU_TOGGLE()
        local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
        ncdu:toggle()
    end

    function _BTOP_TOGGLE()
        local btop = Terminal:new({ cmd = "btop", hidden = true,
            float_opts = {
                border = "none",
                width = 100000,
                height = 100000,
            },
        })
        btop:toggle()
    end

    function _PYTHON_TOGGLE()
        local python = Terminal:new({ cmd = "python3", hidden = true })
        python:toggle()
    end

    function _CARGO_RUN()
        local cargo_run = Terminal:new({ cmd = "cargo run", hidden = true })
        cargo_run:toggle()
    end

    function _CARGO_TEST()
        local cargo_test = Terminal:new({ cmd = "cargo test", hidden = true })
        cargo_test:toggle()
    end

    local float_term = Terminal:new({
        direction = "float",
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "n",
                "<m-1>",
                "<cmd>1ToggleTerm direction=float<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "t",
                "<m-1>",
                "<cmd>1ToggleTerm direction=float<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "i",
                "<m-1>",
                "<cmd>1ToggleTerm direction=float<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-2>", "<nop>", { noremap = true, silent = true })
            vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-3>", "<nop>", { noremap = true, silent = true })
        end,
        count = 1,
    })

    function _FLOAT_TERM()
        float_term:toggle()
    end

    vim.api.nvim_set_keymap("n", "<m-1>", "<cmd>lua _FLOAT_TERM()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("i", "<m-1>", "<cmd>lua _FLOAT_TERM()<CR>", { noremap = true, silent = true })

    local vertical_term = Terminal:new({
        direction = "vertical",
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "n",
                "<m-2>",
                "<cmd>2ToggleTerm size=60 direction=vertical<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "t",
                "<m-2>",
                "<cmd>2ToggleTerm size=60 direction=vertical<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "i",
                "<m-2>",
                "<cmd>2ToggleTerm size=60 direction=vertical<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-3>", "<nop>", { noremap = true, silent = true })
        end,
        count = 2,
    })

    function _VERTICAL_TERM()
        vertical_term:toggle(60)
    end

    vim.api.nvim_set_keymap("n", "<m-2>", "<cmd>lua _VERTICAL_TERM()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("i", "<m-2>", "<cmd>lua _VERTICAL_TERM()<CR>", { noremap = true, silent = true })

    local horizontal_term = Terminal:new({
        direction = "horizontal",
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "n",
                "<m-3>",
                "<cmd>3ToggleTerm size=10 direction=horizontal<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "t",
                "<m-3>",
                "<cmd>3ToggleTerm size=10 direction=horizontal<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(
                term.bufnr,
                "i",
                "<m-3>",
                "<cmd>3ToggleTerm size=10 direction=horizontal<cr>",
                { noremap = true, silent = true }
            )
            vim.api.nvim_buf_set_keymap(term.bufnr, "", "<m-2>", "<nop>", { noremap = true, silent = true })
        end,
        count = 3,
    })

    function _HORIZONTAL_TERM()
        horizontal_term:toggle(10)
    end

    vim.api.nvim_set_keymap("n", "<m-3>", "<cmd>lua _HORIZONTAL_TERM()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("i", "<m-3>", "<cmd>lua _HORIZONTAL_TERM()<CR>", { noremap = true, silent = true })
end

return M
