local status_ok, dashboard = pcall(require, "dashboard")
if not status_ok then
    return
end

local db = require('dashboard')
 --db.custom_header = {
--     '███╗   ██╗██╗   ██╗ ██████╗ ██████╗ ██████╗ ███████╗',
--     '████╗  ██║██║   ██║██╔════╝██╔═══██╗██╔══██╗██╔════╝',
--     '██╔██╗ ██║██║   ██║██║     ██║   ██║██║  ██║█████╗',
--     '██║╚██╗██║╚██╗ ██╔╝██║     ██║   ██║██║  ██║██╔══╝',
--     '██║ ╚████║ ╚████╔╝ ╚██████╗╚██████╔╝██████╔╝███████╗',
--     '╚═╝  ╚═══╝  ╚═══╝   ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝'
-- }
 db.custom_header = {
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
-- '      _..._                                                                           ',
-- '    .\'     `.   ██      ██    ██ ███    ██  █████  ██████  ██    ██ ██ ███    ███ ',
-- '   :         :  ██      ██    ██ ████   ██ ██   ██ ██   ██ ██    ██ ██ ████  ████ ',
-- '   :         :  ██      ██    ██ ██ ██  ██ ███████ ██████  ██    ██ ██ ██ ████ ██ ',
-- '   `.       .\'  ██      ██    ██ ██  ██ ██ ██   ██ ██   ██  ██  ██  ██ ██  ██  ██ ',
-- '     `-...-\'    ███████  ██████  ██   ████ ██   ██ ██   ██   ████   ██ ██      ██ ',
--
-- }

--vim.g.dashboard_custom_header = O.dashboard.custom_header

db.default_executive = 'telescope'
-- db.custom_center = 1

-- db.custom_center= {
--     a = {description = {'  Find File          '}, command = 'Telescope find_files'},
--     b = {description = {'  Recently Used Files'}, command = 'Telescope oldfiles'},
--     c = {description = {'  Load Last Session  '}, command = 'SessionLoad'},
--     d = {description = {'  Find Word          '}, command = 'Telescope live_grep'},
--     --e = {description = {'  Settings           '}, command = ':e '..CONFIG_PATH..'/lv-settings.lua'}
--     e = {description = {'  Marks              '}, command = 'Telescope marks'}
-- }