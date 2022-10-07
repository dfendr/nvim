vim.cmd("let loaded_matchparen = 1")
vim.cmd("set noloadplugins") -- Still doesn't match --noplugin behaviour...
local options = {}

for k, v in pairs(options) do
    vim.opt[k] = v
end
