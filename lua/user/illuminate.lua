-- -- vim.g.Illuminate_delay = 0
-- -- vim.g.Illuminate_highlightUnderCursor = 0
-- vim.g.Illuminate_ftblacklist = { "alpha", "NvimTree", "DressingSelect", "harpoon" }
-- -- vim.g.Illuminate_highlightUnderCursor = 0
-- vim.api.nvim_set_keymap("n", "<a-n>", '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', { noremap = true })
-- vim.api.nvim_set_keymap(
--   "n",
--   "<a-p>",
--   '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
--   { noremap = true }
-- )


local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
  return
end



illuminate.configure({
    delay = 100,
    filetypes_denylist = {
        "alpha",
        "NvimTree",
        "nvimtree",
        "Telescope",
        "harpoon",
    },
    under_cursor = true;
})
