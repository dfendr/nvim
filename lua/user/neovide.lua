vim.cmd([[
" Terminal Colors {{{
if has('nvim')
  let g:terminal_color_1  = "#D12D00"
  let g:terminal_color_2  = "#427B00"
  let g:terminal_color_3  = "#B68200"
  let g:terminal_color_4  = "#006fd1"
  let g:terminal_color_5  = "#a53bce"
  let g:terminal_color_6  = "#119c97"
  let g:terminal_color_9  = "#E74D23"
  let g:terminal_color_10 = "#7dc030"
  let g:terminal_color_11 = "#ffc233"
  let g:terminal_color_12 = "#5aa2e0"
  let g:terminal_color_13 = "#b968d9"
  let g:terminal_color_14 = "#15c1bb"

  if &background == "light"
    let g:terminal_color_0  = "#323434"
    let g:terminal_color_7  = "#e4e2d8"
    let g:terminal_color_8  = "#4f4a36"
    let g:terminal_color_15 = "#f4f3ef"
  else " &background == 'dark'
    let g:terminal_color_0  = "#1e2d38"
    let g:terminal_color_7  = "#acc1d3"
    let g:terminal_color_8  = "#253846"
    let g:terminal_color_15 = "#b9cbda"
  endif
else
  let g:terminal_ansi_colors = repeat([0], 16)
  let g:terminal_ansi_colors[1]  = "#D12D00"
  let g:terminal_ansi_colors[2]  = "#427B00"
  let g:terminal_ansi_colors[3]  = "#B68200"
  let g:terminal_ansi_colors[4]  = "#006fd1"
  let g:terminal_ansi_colors[5]  = "#a53bce"
  let g:terminal_ansi_colors[6]  = "#119c97"
  let g:terminal_ansi_colors[9]  = "#E74D23"
  let g:terminal_ansi_colors[10] = "#7dc030"
  let g:terminal_ansi_colors[11] = "#ffc233"
  let g:terminal_ansi_colors[12] = "#5aa2e0"
  let g:terminal_ansi_colors[13] = "#b968d9"
  let g:terminal_ansi_colors[14] = "#15c1bb"

  if &background == "light"
    let g:terminal_ansi_colors[0]  = "#323434"
    let g:terminal_ansi_colors[7]  = "#e4e2d8"
    let g:terminal_ansi_colors[8]  = "#4f4a36"
    let g:terminal_ansi_colors[15] = "#f4f3ef"
  else " &background == 'dark'
    let g:terminal_ansi_colors[0]  = "#1e2d38"
    let g:terminal_ansi_colors[7]  = "#acc1d3"
    let g:terminal_ansi_colors[8]  = "#253846"
    let g:terminal_ansi_colors[15] = "#b9cbda"
  endif
endif
" }}}
]])

vim.cmd([[
" let g:neovide_fullscreen = v:true
let g:neovide_remember_window_size = v:false
let g:neovide_profiler = v:false
let g:neovide_refresh_rate = 120
let g:neovide_refresh_rate_idle = 5
let g:neovide_confirm_quit = v:true


" set t_Co=256
let g:neovide_cursor_antialiasing = v:true
let g:neovide_cursor_unfocused_outline_width = 0.125
]])
-- Font
vim.opt.guifont = { "Fira Code", ":h13:Retina" }
if vim.fn.has("mac") == 1 then
    vim.cmd("  let g:neovide_input_use_logo          = v:true")
    vim.cmd("  let g:neovide_input_macos_alt_is_meta = v:true")
    vim.cmd([[ let g:neovide_transparency            = 0.98
               let g:transparency                    = 0.95
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
