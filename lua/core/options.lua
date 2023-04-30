vim.g.mapleader = " "
vim.g.maplocalleader = " "
local options = {
    autoread = true, -- automatically update files if updated elsewhere.
    autochdir = false, -- automatically change nvim path to current buffer
    backup = false, -- creates a backup file
    clipboard = { "unnamedplus", "unnamed" }, -- allows neovim to access the system clipboard
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    colorcolumn = "80", -- Column @ 80 for cleanliness reminder.
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    cursorcolumn = false, -- Highlight current col
    cursorline = true, -- Highlight current line
    expandtab = true, -- Insert spaces instead of tabs
    fileencoding = "utf-8", -- the encoding written to a file
    guifont = "monospace:h17", -- Font used in neovim GUI app.
    ignorecase = true, -- ignore case in search patterns
    laststatus = 3, -- Global statusline
    listchars = {
        extends = "◣",
        lead = "⋅",
        precedes = "◢",
        space = "⋅",
        tab = "» ",
        trail = "·",
        -- nbsp = "⋅",
    },
    mouse = "a", -- enable mouse in all modes
   -- netrw_banner = 0, -- disable that anoying Netrw banner
   -- netrw_browser_split = 4, -- open in a prior window
   -- netrw_altv = 1, -- open splits to the right
   -- netrw_liststyle = 3, -- treeview
    number = true, -- Show line numbers on side.
    numberwidth = 2, -- Sets sidenumber width to 2 instead of default 4
    pumheight = 10, -- max number of autocompletion options that will show
    relativenumber = true, -- Show relative numbers (on in normal mode due to AutoCmd below)
    ruler = true, -- Measures line/col
    scrolloff = 0, -- Minimal number of lines viewable above/below cursor on scroll.
    shellcmdflag = "-ic", -- Run commands from "!" mode in interactive mode (sources custom functions)
    showmode = false, -- No need to show --INSERT--, cursor will let me know.
    signcolumn = "yes", -- TESTING, might be cool to just have the LSP signs replace the numbers.
    sidescrolloff = 2, -- Minimal number of lines viewable left/right cursor on sidescroll.
    smartcase = true, -- ^ unless search pattern contains upper case characters
    smartindent = true, -- Smart indenting (:help smartindent)
    splitbelow = true, -- force all horizontal splits go below current window
    splitright = true, -- force all vertical splits go to right of current window
    swapfile = false, -- no swapfile
    tabstop = 4, -- 4 spaces instead of a tab
    termguicolors = false, -- Theme sets terminal colors.
    title = true,
    timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
    ttyfast = true, -- Quicken that terminal, baby! Faster sending of characters (I think)
    undofile = true, -- persistent undo
    updatetime = 300, -- if nothing is typed in 300 ms, swap file updated (unneeded bc of no swapfile?)
    wrap = false, -- No wrap, lines are as long as they are, baby!
    writebackup = false, -- if file is being edited elsewhere, don't allow editing
}

-- Now enable the options
for k, v in pairs(options) do
    vim.opt[k] = v
end


-- Whitespace chars
-- vim.opt.listchars = "tab:▷ ,trail:·,extends:◣,precedes:◢,nbsp:⋅,space:⋅"
--vim.opt.listchars:append "eol:↴"
--vim.opt.listchars:append "eol:﬌"

vim.opt.shortmess:append("c") -- keeps search from being "noisy", e.g.suppresses messages
vim.cmd("set whichwrap+=<,>,[,],h,l") -- Wraps movement e.g. hold l to pass through a line -> continues to next line


--NOTE: SEMANTIC HIGHLIGHT ERRORS? ENABLE THIS
-- Disable semantic highlights.
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
end
