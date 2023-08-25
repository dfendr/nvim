require("core.options")
require("core.keymaps")
require("core.autocmds")

local version = vim.version()

if version.major == 0 and version.minor >= 10 then
  -- Set the colorscheme to "retrobox" if Neovim is at least 0.10
  vim.cmd([[colo retrobox]])
elseif version.major == 0 and version.minor == 9 and version.patch >= 1 then
  -- Set the colorscheme to "habamax" if Neovim is 0.9.1 or higher but less than 0.10
  vim.cmd([[colo habamax]])
end

