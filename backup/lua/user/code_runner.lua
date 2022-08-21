local status_ok, code_runner = pcall(require, "code_runner")
if not status_ok then
    return
end

code_runner.setup {
  mode = "term",
  startinsert = true,
	term = {
		position = "bot",
		size = 15,
	},
	filetype = {
		java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		python = "python3 -u",
		typescript = "deno run",
		rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
	},
	-- project = {
	-- 	["~/deno/example"] = {
	-- 		name = "ExapleDeno",
	-- 		description = "Project with deno using other command",
	-- 		file_name = "http/main.ts",
	-- 		command = "deno run --allow-net"
	-- 	},
	-- 	["~/cpp/example"] = {
	-- 		name = "ExapleCpp",
	-- 		description = "Project with make file",
	-- 		command = "make buid & cd buid/ & ./compiled_file"
	-- 	}
	-- },
}





vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })
