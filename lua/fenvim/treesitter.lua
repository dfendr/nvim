local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    --commit = "f2778bd", // Dart bug not present here :\
    dependencies = {
        { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPost" },
        "nvim-treesitter/nvim-treesitter-context",
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    lazy = false,
    event = "BufReadPost",
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
        ignore_install = { "perl" }, -- List of parsers to ignore installing
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = { "text", "txt", "csv" }, -- list of language that will be disabled
            additional_vim_regex_highlighting = false,
        },

        indent = { enable = true, disable = { "yaml", "python", "dart" } },
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
