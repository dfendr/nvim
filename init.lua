require("user.impatient")
require("user.options")
require("user.keymaps")
require("user.utils")
require("user.comment")
require("user.nvim-surround")
require("user.align")
require("user.neoscroll")
if vim.g.vscode then
    goto continue
end
require("user.presence")
require("user.autocommands")
require("user.autopairs")
require("user.auto-session")
require("user.todo-comments")
require("user.plugins")
require("user.colorscheme")
require("user.bufferline")
require("user.scope")
require("user.nvim-tree")
-- require("user.neo-tree") //TODO: Configure and switch to neo-tree
require("user.alpha")
require("user.notify")
require("user.lsp")
require("user.telescope")
require("user.treesitter")
require("user.toggleterm")
require("user.ts-context")
require("user.cmp")
require("user.lualine")
require("user.fidget")
require("user.gitsigns")
require("user.illuminate")
require("user.indentblankline")
require("user.jaq")
require("user.renamer")
require("user.boole")
require("user.image")
require("user.functions")
require("user.dap")
require("user.symbols-outline")
require("user.project")
require("user.colorizer")
require("user.windows")
require("user.autolist")
require("user.scratch")
-- :^)
require("user.venn")
require("user.silicon")
require("user.which-key")
if vim.g.neovide then
    require("user.neovide")
end

::continue::
return
-- require("user.align")
-- require("user.tabby")
-- require("user.tabline")
-- require("user.transparent")
--require "user.sniprun"
-- require "user.shade"
--require "user.winbar" needs NAVIC highlight groups

-- TODO: 1. Swap to Lazy.nvim from Packer.nvim
-- TODO: 2. Add Treesitter/LSP indicator for Lualine
-- TODO: 3. Spaces indicator (only if tabs or spaces!=4)
-- TODO: 4. Create Large File autocommand that disables events n treesitter.
-- TODO: 5. Organize Lua files (?)
-- TODO: 6. Get C#/Java working
