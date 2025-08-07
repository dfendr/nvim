local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {

        {
            "nvim-treesitter/nvim-treesitter-context",
            enabled = require("core.prefs").ui.context,
            config = function()
                require("treesitter-context").setup({
                    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                    max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
                    min_window_height = 20, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                    line_numbers = true,
                    multiline_threshold = 20, -- Maximum number of lines to show for a single context
                    trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                    mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
                    -- Separator between context and content. Should be a single character string, like '-'.
                    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                    separator = nil,
                    zindex = 20, -- The Z-index of the context window
                    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
                })
            end,
        },
    },
    -- lazy = true,
    event = "BufReadPre",
}

function M.config()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "bash",
            "comment",
            "c",
            "c_sharp",
            "css",
            "html",
            "javascript",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "rust",
            "sql",
            "typescript",
            "vim",
        },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        highlight = {
            enable = true,
            disable = function(_, bufnr) -- Disable in files with more than 5K
                return vim.api.nvim_buf_line_count(bufnr) > 5000
            end,
            additional_vim_regex_highlighting = false,
        },

        indent = {
            enable = true,
            disable = { "c", "php", "yaml", "python", "dart", "markdown", "markdown_inline" },
        },
    })
end
return M
