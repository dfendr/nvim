local ensure_installed = {
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
}

local indent_disabled = {
    c = true,
    php = true,
    yaml = true,
    python = true,
    dart = true,
    markdown = true,
    markdown_inline = true,
}

local M = {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = "BufReadPre",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-context",
            enabled = require("core.prefs").ui.context,
            config = function()
                require("treesitter-context").setup({
                    enable = true,
                    max_lines = 2,
                    min_window_height = 20,
                    line_numbers = true,
                    multiline_threshold = 20,
                    trim_scope = "outer",
                    mode = "cursor",
                    separator = nil,
                    zindex = 20,
                    on_attach = nil,
                })
            end,
        },
    },
}

function M.config()
    local ts = require("nvim-treesitter")
    ts.install(ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_attach", { clear = true }),
        callback = function(ev)
            local buf = ev.buf
            if vim.api.nvim_buf_line_count(buf) > 5000 then
                return
            end
            local ft = vim.bo[buf].filetype
            local lang = vim.treesitter.language.get_lang(ft) or ft
            if not pcall(vim.treesitter.language.add, lang) then
                pcall(ts.install, lang)
                return
            end
            pcall(vim.treesitter.start, buf, lang)
            if not indent_disabled[ft] then
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
        end,
    })
end

return M
