local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  return
end

local dashboard = require "alpha.themes.dashboard"

local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl_shortcut = "Macro"
  return b
end

local icons = require "user.icons"

dashboard.section.header.val = {
'+─────────────────────────────────────────────────────────────────────────────────────────+',
'│            ____                                                                         │',
'│        _.-`78o ```--._                                                                  │',
'│    ,o888o.  .o888o,   ``-.                                                              │',
'│  ,88888P  `78888P..______.]                                                             │',
'│ /_..__..----``        __.`                                                              │',
'│ `-._       /``| _..-``                                                                  │',
'│     ``------\\  `\\                                                                       │',
'│             |   ;.-``--..                                                               │',
'│             | ,8o.  o88. `.     ,d8888b                            d8,                  │',
'│             `;888P  `788P  :    88P`                              `8P                   │',
'│       .o``-.|`-._         ./  d888888P`                                                 │',
'│      J88 _.-/    ;``-P----`    ?88`  d8888b  88bd88b  ?88   d8P  88b  88bd8b,d88b       │',
'│      `--`\\`|     /  /          88P  d8b_,dP  88P` ?8b d88  d8P`  88P  88P``?8P`?8b      │',
'│          | /     |  |         d88   88b     d88   88P ?8b ,88`  d88  d88  d88  88P      │',
'│          \\|     /   |        d88`    `?888P`d88`   88b `?888P`  d88` d88` d88`  88b     │',
'│           `-----`---`========---======-----=---====---==-----===---==---==---===---=    │',
'+─────────────────────────────────────────────────────────────────────────────────────────+',
}
dashboard.section.buttons.val = {
  button("SPC f f", icons.documents.Files .. " Find file", ":Telescope find_files <CR>"),
  button("SPC n", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
  --button("p", icons.git.Repo .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
  button("SPC f r", icons.ui.History .. " Recent Files", ":Telescope oldfiles <CR>"),
  button("SPC f t", icons.type.String .. " Find Text", ":Telescope live_grep <CR>"),
  -- dashboard.button("s", icons.ui.SignIn .. " Find Session", ":silent Autosession search <CR>"),
  button("SPC s", icons.ui.SignIn .. " Find Session", ":SearchSession<CR>"),
  button("SPC c", icons.ui.Gear .. " Config", ":e ~/.config/nvim/init.lua <CR>"),
  button("SPC p u", icons.ui.CloudDownload .. " Update", ":PackerSync<CR>"),
  button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
}
local function footer()
  -- NOTE: requires the fortune-mod package to work
  local handle = io.popen("fortune")
  local fortune = handle:read("*a")
  handle:close()
  return fortune
  --return "dylfender@gmail.com"
end

dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Macro"
dashboard.section.footer.opts.hl = "Type"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
