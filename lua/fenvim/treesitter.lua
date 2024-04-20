local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    --commit = "f2778bd", // Dart bug not present here :\
    dependencies = {
        { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPost" },
        { "yorickpeterse/nvim-tree-pairs", event = "BufReadPost", config = true },

        {
            "nvim-treesitter/nvim-treesitter-context",
            enabled = require("core.prefs").ui.context,
        },
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    -- lazy = true,
    -- event = "BufReadPre",
}

function M.config()
    local status_ok, configs = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
        return
    end

    configs.setup({
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
        sync_install = true,
        auto_install = true,
        ignore_install = {}, -- List of parsers to ignore installing
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = function(_, bufnr) -- Disable in files with more than 5K
                return vim.api.nvim_buf_line_count(bufnr) > 5000
            end,
            additional_vim_regex_highlighting = false,
        },

        indent = { enable = true, disable = { "c", "yaml", "python", "dart", "markdown", "markdown_inline" } },
    })

    -- setup  TS comment context plugin
    require("ts_context_commentstring").setup({})

    -- Setup Rainbow delimiters
    local rainbow_delimiters = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
        strategy = {
            [""] = rainbow_delimiters.strategy["global"],
            vim = rainbow_delimiters.strategy["local"],
        },
        query = {
            [""] = "rainbow-delimiters",
            -- lua = "rainbow-blocks",
        },
        highlight = {
            "TSRainbowMagenta",
            "TSRainbowGray",
            "TSRainbowCyan",
            "TSRainbowYellow",
            "TSRainbowOrange",
            "TSRainbowPink",
            "TSRainbowGreen",
        },
    }
end
return M
