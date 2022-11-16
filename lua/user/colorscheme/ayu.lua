
require('ayu').setup({
    mirage = true,
--   overrides = function()
--     if vim.o.background == 'dark' then
--       return { NormalNC = {bg = '#0f151e', fg = '#808080'} }
--     else
--       return { NormalNC = {bg = '#f0f0f0', fg = '#808080'} }
--     end
--   end
})

local colorscheme = "ayu"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

