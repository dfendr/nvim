local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "HiPhish/nvim-ts-rainbow2",
        "nvim-treesitter/playground",
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
            "python",
            "c",
            "c_sharp",
            "bash",
            "rust",
            "lua",
            "javascript",
            "markdown",
            "typescript",
            "tsx",
            "css",
            "html",
            "sql",
            "vim",
            "regex",
        },
        sync_install = false,
        ignore_install = { "" }, -- List of parsers to ignore installing
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = { "text", "txt", "csv" }, -- list of language that will be disabled
            additional_vim_regex_highlighting = false,
        },
        rainbow = {
            enable = true,
            hlgroups = {
                "TSRainbowMagenta",
                "TSRainbowGray",
                "TSRainbowCyan",
                "TSRainbowGreen",
                "TSRainbowYellow",
                "TSRainbowOrange",
                "TSRainbowPink",
            },
            -- disable = { "jsx", "cpp" }, -- list of languages you want to disable plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = 1000, -- Do not enable for files with more than n lines, int
            -- colors = {"#518387", "#a86885", "#548287", "#6E9054", "#CD9E39", "#C87924" }, -- table of hex strings
            -- term colors = {}, -- table of colour name strings
        },
        indent = { enable = true, disable = { "yaml", "python" } },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
    })
end
return M
