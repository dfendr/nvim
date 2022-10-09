local options = {
    -- :help options
    backup = false, -- creates a backup file
    clipboard = { "unnamedplus", "unnamed" }, -- allows neovim to access the system clipboard
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    completeopt = { "menuone", "noselect" }, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    ignorecase = true, -- ignore case in search patterns
    smartcase = true, -- ^ unless search pattern contains upper case characters
    mouse = "a", -- enable mouse in all modes
    pumheight = 10, -- max number of autocompletion options that will show
    showmode = false, -- No need to show --INSERT--, cursor will let me know.
    --showtabline = 2,                            -- Always show tabs (top menu bar I think?)
    expandtab = true, -- Insert spaces instead of tabs
    tabstop = 4, -- 4 spaces instead of a tab
    shiftwidth = 4, -- 4 space indentations
    swapfile = false, -- no swapfile
    timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true, -- persistent undo
    updatetime = 300, -- if nothing is typed in 300 ms, swap file updated (unneeded bc of no swapfile?)
    splitbelow = true, -- force all horizontal splits go below current window
    splitright = true, -- force all vertical splits go to right of current window
    writebackup = false, -- if file is being edited elsewhere, don't allow editing
    smartindent = true, -- Smart indenting (:help smartindent)
    cursorline = true, -- Highlight current line
    termguicolors = true,
    relativenumber = false, -- Show relative numbers (on in normal mode due to AutoCmd below)
    number = true, -- Show line numbers on side.
    numberwidth = 2, -- Sets sidenumber width to 2 instead of default 4
    signcolumn = "yes", -- TESTING, might be cool to just have the LSP signs replace the numbers.
    wrap = false, -- No wrap, lines are as long as they are, baby!
    scrolloff = 14, -- Minimal number of lines viewable above/below cursor on scroll.
    sidescrolloff = 8, -- Minimal number of lines viewable left/right cursor on sidescroll.
    --guifont = "monospace:h17", -- Font used in neovim GUI app.
    colorcolumn = "80", -- Column @ 80 for cleanliness reminder.
    ttyfast = true, -- Quicken that terminal, baby! Faster sending of characters (I think)
    ruler = true, -- Measures line/col
    title = true,
}

-- Now enable the options
for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Whitespace chars
 vim.opt.listchars= "tab:▷ ,trail:·,extends:◣,precedes:◢,nbsp:⋅,space:⋅"
--vim.opt.listchars:append "eol:↴"
--vim.opt.listchars:append "eol:﬌"


vim.opt.shortmess:append("c") -- keeps search from being "noisy", e.g.suppresses messages
vim.cmd("set whichwrap+=<,>,[,],h,l") -- Wraps movement e.g. hold l to pass through a line -> continues to next line

-- Format Option Settings, r -
--vim.cmd "set fo-=r "

-- Relative number toggle, only in Normal mode
vim.api.nvim_command([[
augroup RelativeNumberToggle
autocmd InsertEnter * :set relativenumber
autocmd InsertLeave * :set norelativenumber
augroup END
]])


vim.cmd("autocmd BufEnter * set formatoptions-=cro") -- These two stop vim from adding comment strings when
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro") -- pressing enter on comment strings in Insert mode.

-- Removing trailing whitesspace on save.
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
