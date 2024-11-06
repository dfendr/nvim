local M = {}
function M.config()
    require("code_runner").setup({
        mode = "float",
        filetype = {
            awk = "awk -f $file",
            arduino = "cd '$dir' && make",
            riscv = "cd '$dir' && java -jar ~/bin/rars.jar '$file'",
            c = "cd '$dir' && cc -Wall -fsanitize=address -Wno-nullability-completeness -Wextra -pedantic -g -std=c11 -Wall $fileName -o $fileNameWithoutExt && '$dir/$fileNameWithoutExt' && rm '$dir/$fileNameWithoutExt' && rm -rf '$dir/$fileNameWithoutExt.dSYM'",
            cpp = "cd '$dir' && g++ $fileName -o $fileNameWithoutExt && '$dir/$fileNameWithoutExt'",
            cs = "cd '$dir' && dotnet run",
            go = "cd '$dir' && go run $fileName",
            haskell = "cabal run",
            java = "cd '$dir' && javac $fileName && java $fileNameWithoutExt",
            javascript = "node %",
            jl = "cd '$dir' && julia %",
            kotlin = "cd '$dir' && kotlinc $fileName -include-runtime -d $fileNameWithoutExt.jar && java -jar $fileNameWithoutExt.jar",
            lisp = "clisp $file",
            lua = "luajit $file",
            perl = "cd '$dir' && perl $file",
            php = "cd '$dir' && php $file",
            python = "cd '$dir' && python3 '$file'",
            r = "cd '$dir' && Rscript $file",
            rust = "cd '$dir' && cargo run",
            sh = "cd '$dir' && bash $file",
            typescript = "cd '$dir' && bun run '$file'",
        },
        float = {
            border = require("core.prefs").ui.border_style,
        },
    })
end

return M
