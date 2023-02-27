local M = {}
function M.config()
    require("code_runner").setup({
        -- put here the commands by filetype
        mode = "float",
        filetype = {
            awk = "awk -f $file",
            c = 'gcc -Wall -fsanitize=address -Wextra -pedantic -g -std=c99 "$fileBase.c" -o "$fileName" && ."$fileName"',
            cs = "cd $dir && dotnet run",
            cpp = "g++ % -o $fileName && ./$fileName",
            go = "go run %",
            javascript = "node %",
            jl = "cd $dir && julia %",
            lua = "luajit $file",
            -- java = 'cd $dir && javac "$filePath" && java $fileBase',
            -- markdown = "glow %",
            perl = "cd $dir && perl $file",
            python = "cd $dir && python3 $file",
            r = "cd $dir && Rscript $file",
            -- rust = "rustc % && ./$fileBase && rm $fileBase",
            rust = "cd $dir && cargo run",
            haskell = "cabal run",
            --rust = "cargo run",
            sh = "cd $dir && bash $file",
            -- sh = "bash %",
            typescript = "deno run %",
        },
        float = {
            border = "rounded",
        },
    })
end

return M
