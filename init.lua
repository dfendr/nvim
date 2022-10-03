require("user.impatient")
require("user.options")
require("user.keymaps")
require("user.utils")
require("user.comment")
require("user.neoscroll")
require("user.presence")
if vim.g.vscode then
    goto continue
end
require("user.autocommands")
require("user.autopairs")
require("user.todo-comments")
require("user.plugins")
require("user.colorscheme")
require("user.bufferline")
require("user.scope")
require("user.nvim-tree")
require("user.alpha")
require("user.notify")
require("user.lsp")
require("user.telescope")
require("user.treesitter")
require("user.ts-context")
require("user.cmp")
require("user.lualine")
require("user.gitsigns")
require("user.toggleterm")
require("user.illuminate")
require("user.indentblankline")
require("user.jaq")
require("user.renamer")
require("user.align")
require("user.image")
require("user.functions")
-- require("user.tabby")
require("user.dap")
require("user.symbols-outline")
require("user.project")
require("user.colorizer")
require("user.windows")
require("user.which-key")

::continue::
return
-- require("user.tabline")
-- require("user.transparent")
--require "user.sniprun"
-- require "user.shade"
--require "user.winbar" needs NAVIC highlight groups
-- TODO: 1. Get Session Manager
-- TODO: 2. Get clangd-format working properly 
-- TODO: 3. Get Debugger working (Python, Rust, C, Bash (MAYBE JAVA?))
-- TODO: 4. I think that's it. I think we're done. Celebrate. Use neovim <3
