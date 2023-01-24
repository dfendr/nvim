
vim.cmd([[
" Terminal Colors {{{
if has('nvim')
  let g:terminal_color_1  = "#CC241D"
  let g:terminal_color_2  = "#91971D"
  let g:terminal_color_3  = "#CC881A"
  let g:terminal_color_4  = "#458588"
  let g:terminal_color_5  = "#D3869b"
  let g:terminal_color_6  = "#83a598"
  let g:terminal_color_9  = "#FB4934"
  let g:terminal_color_10 = "#b8bb26"
  let g:terminal_color_11 = "#fabd2f"
  let g:terminal_color_12 = "#367274"
  let g:terminal_color_13 = "#D4879C"
  let g:terminal_color_14 = "#458588"

  if &background == "light"
    let g:terminal_color_0  = "#323434"
    let g:terminal_color_7  = "#e4e2d8"
    let g:terminal_color_8  = "#5C6A77"
    " let g:terminal_color_8  = "#776a5c"

    let g:terminal_color_15 = "#f4f3ef"
  else " &background == 'dark'
    let g:terminal_color_0  = "#323434"
    let g:terminal_color_7  = "#E7D7AD"
    let g:terminal_color_8  = "#665c54"
    let g:terminal_color_15 = "#E7D7AD"
  endif
else
  let g:terminal_ansi_colors = repeat([0], 16)
  let g:terminal_ansi_colors[1]  = "#CC241D"
  let g:terminal_ansi_colors[2]  = "#B8BB26"
  let g:terminal_ansi_colors[3]  = "#EEbd35"
  let g:terminal_ansi_colors[4]  = "#83a598"
  let g:terminal_ansi_colors[5]  = "#D3869b"
  let g:terminal_ansi_colors[6]  = "#458588"
  let g:terminal_ansi_colors[9]  = "#FB4934"
  let g:terminal_ansi_colors[10] = "#b8bb26"
  let g:terminal_ansi_colors[11] = "#fabd2f"
  let g:terminal_ansi_colors[12] = "#7fa2ac"
  let g:terminal_ansi_colors[13] = "#D4879C"
  let g:terminal_ansi_colors[14] = "#458588"

  if &background == "light"
    let g:terminal_ansi_colors[0]  = "#282828"
    let g:terminal_ansi_colors[7]  = "#fbf1c7"
    let g:terminal_ansi_colors[8]  = "#4f4a36"
    let g:terminal_ansi_colors[15] = "#f4f3ef"
  else " &background == 'dark'
    let g:terminal_ansi_colors[0]  = "#1d2021"
    let g:terminal_ansi_colors[7]  = "#E7D7AD"
    let g:terminal_ansi_colors[8]  = "#32302f"
    let g:terminal_ansi_colors[15] = "#E7D7AD"
  endif
endif
" }}}
]])

vim.cmd([[
" let g:neovide_fullscreen = v:true
let g:neovide_remember_window_size = v:false
let g:neovide_profiler = v:false
let g:neovide_refresh_rate = 120
let g:neovide_refresh_rate_idle = 10
let g:neovide_confirm_quit = v:true


" set t_Co=256
let g:neovide_cursor_antialiasing = v:true
let g:neovide_cursor_unfocused_outline_width = 0.125
]])
-- Font
vim.opt.guifont = { "FiraCode Nerd Font", ":h12" }
-- vim.opt.guifont = {"Hack:h14:i:#e-subpixelantialias:#h-none"}


if vim.fn.has("mac") == 1 then
    vim.cmd("  let g:neovide_input_use_logo          = v:true")
    vim.cmd("  let g:neovide_input_macos_alt_is_meta = v:true")
    vim.cmd([[ let g:neovide_transparency            = 0.98
               let g:transparency                    = 0.98
               let g:neovide_floating_blur_amount_x  = 1.0
               let g:neovide_floating_blur_amount_y  = 1.0
               let g:neovide_cursor_vfx_mode = "pixiedust"
               let g:neovide_cursor_vfx_particle_density = 7.0
               let g:neovide_input_use_logo = 1
                            ]])
end

-- Allow copy paste in neovim
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
