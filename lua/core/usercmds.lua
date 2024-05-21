local function start_profiling()
  vim.cmd('profile start profile.log')
  vim.cmd('profile func *')
  vim.cmd('profile file *')
end

local function stop_profiling()
  vim.cmd('profile pause')
  vim.cmd('noautocmd qall!')
end


-- Register the start profiling command
vim.api.nvim_create_user_command(
  'StartProfiling',
  start_profiling,
  {desc = 'Start profiling Vimscript execution'}
)

-- Register the stop profiling command
vim.api.nvim_create_user_command(
  'StopProfiling',
  stop_profiling,
  {desc = 'Stop profiling and exit Neovim'}
)
