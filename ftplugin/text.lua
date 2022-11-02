vim.cmd("let loaded_matchparen = 1")
-- vim.cmd("set noloadplugins") -- Still doesn't match --noplugin behaviour...
--TODO: Set this to only turn on on large files.

--TODO: Turn this into an autocmd that turns on when entering txt,
--and turns off when leaving
vim.cmd("set eventignore=all -buffer")

-- vim.cmd([[
-- :autocmd WinEnter <buffer> set eventignore=all
-- :autocmd WinLeave <buffer> set eventignore=\"\"
-- ]])

local options = {}

for k, v in pairs(options) do
    vim.opt[k] = v
end
