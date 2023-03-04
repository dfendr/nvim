local M = {}
function M.config()
    require("code_runner").setup({
        -- put here the commands by filetype
        mode = "float",
        filetype = {
            awk = "awk -f $file",
            java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
            c = "cd $dir && cc -Wall -fsanitize=address -Wno-nullability-completeness -Wextra -pedantic -g -std=c99 $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
            cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
            cs = "cd $dir && dotnet run",
            go = "go run %",
            javascript = "node %",
            jl = "cd $dir && julia %",
            lua = "luajit $file",
            perl = "cd $dir && perl $file",
            python = "cd $dir && python3 $file",
            r = "cd $dir && Rscript $file",
            rust = "cd $dir && cargo run",
            haskell = "cabal run",
            sh = "cd $dir && bash $file",
            typescript = "deno run %",
        },
        float = {
            border = "rounded",
        },
    })
end

return M
