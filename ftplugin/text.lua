vim.cmd("let loaded_matchparen = 1")
local options = {

}

for k, v in pairs(options) do
    vim.opt[k] = v
end
