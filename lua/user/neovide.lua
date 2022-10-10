--TODO: Start Neovide config
vim.cmd([[
" let g:neovide_fullscreen = v:true
let g:neovide_remember_window_size = v:true
let g:neovide_profiler = v:false
let g:neovide_refresh_rate = 120
let g:neovide_refresh_rate_idle = 5
let g:neovide_confirm_quit = v:true
" Visual Cues
let g:neovide_cursor_antialiasing = v:true
let g:neovide_cursor_unfocused_outline_width = 0.125


set guifont=FiraMono\ Nerd\ Font:h13
]])

if vim.fn.has("mac") == 1 then
    vim.cmd("  let g:neovide_input_use_logo          = v:true")
    vim.cmd("  let g:neovide_input_macos_alt_is_meta = v:true")
    vim.cmd([[ let g:neovide_transparency            = 0.98
               let g:transparency                    = 0.95
               let g:neovide_floating_blur_amount_x  = 1.0
               let g:neovide_floating_blur_amount_y  = 1.0
               let g:neovide_cursor_vfx_mode = "pixiedust"
               let g:neovide_cursor_vfx_particle_density = 7.0
                            ]])
end
