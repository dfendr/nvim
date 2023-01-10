local M = {}

function M.config()
    local status_ok, jaq_nvim = pcall(require, "jaq-nvim")
    if not status_ok then
        return
    end

    -- % / $file • Current File
    -- # / $altFile • Alternate File
    -- $dir • Current Working Directory
    -- $filePath • Path to Current File
    -- $fileBase • Basename of File (no extension) (with path?)
    -- $moduleName • Python Module Name

    -- cmd = cmd:gsub("$baseName", vim.fn.expand("%:t:r"))
    -- $baseName • Basename of File (no extension)

    jaq_nvim.setup({
        -- Commands used with 'Jaq'
        cmds = {
            -- Default UI used (see `Usage` for options)
            default = "term",

            -- Uses external commands such as 'g++' and 'cargo'
            external = {
                awk = "awk -f $filePath",
                c = 'gcc -Wall -fsanitize=address -Wextra -pedantic -g -std=c99 "$fileBase.c" -o "$fileBase" && ."$fileBase"',
                cs = "cd $dir && dotnet run",
                cpp = "g++ % -o $fileBase && ./$fileBase",
                go = "go run %",
                javascript = "node %",
                lua = "luajit $filePath",
                -- java = 'cd $dir && javac "$filePath" && java $fileBase',
                -- markdown = "glow %",
                perl = "cd $dir && perl $filePath",
                python = "cd $dir && python3 $filePath",
                r = "cd $dir && Rscript $filePath",
                -- rust = "rustc % && ./$fileBase && rm $fileBase",
                rust = "cd $dir && cargo run",
                --rust = "cargo run",
                sh = "cd $dir && bash $filePath",
                -- sh = "bash %",
                typescript = "deno run %",
            },

            -- Uses internal commands such as 'source' and 'luafile'
            internal = {
                -- lua = "luafile %",
                -- vim = "source %",
            },
        },

        behavior = {
            -- Default type
            default = "float",

            -- Start in insert mode
            startinsert = false,

            -- Use `wincmd p` on startup
            wincmd = false,

            -- Auto-save files
            autosave = true,
        },

        -- UI settings
        ui = {
            -- Floating Window / FTerm settings
            float = {
                -- Floating window border (see ':h nvim_open_win')
                border = "single",

                -- Num from `0 - 1` for measurements
                height = 0.8,
                width = 0.8,
                x = 0.5,
                y = 0.5,

                -- Highlight group for floating window/border (see ':h winhl')
                border_hl = "FloatBorder",
                float_hl = "Normal",

                -- Floating Window Transparency (see ':h winblend')
                blend = 10,
            },

            terminal = {
                -- Position of terminal
                position = "vert",

                -- Open the terminal without line numbers
                line_no = false,

                -- Size of terminal
                size = 60,
            },
        },
    })

    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_set_keymap

    keymap("n", "<m-r>", ":silent only | Jaq<cr>", opts)
end
return M
