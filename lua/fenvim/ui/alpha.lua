local M = {}
function M.config()
    local function button(sc, txt, keybind)
        local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

        local opts = {
            position = "center",
            text = txt,
            shortcut = sc,
            cursor = 5,
            width = 36,
            align_shortcut = "right",
            hl = "AlphaButtons",
            hl_shortcut = "TSNumber",
        }

        if keybind then
            opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
        end

        return {
            type = "button",
            val = txt,
            on_press = function()
                local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
                vim.api.nvim_feedkeys(key, "normal", false)
            end,
            opts = opts,
        }
    end

    -- dynamic header padding
    local fn = vim.fn
    local marginTopPercent = 0.05
    local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

    local icons = require("fenvim.ui.icons")
    local daylight = require("utils.functions").daylight()
    if daylight then
        header_hl_group = "@string"
    else
        header_hl_group = "@label" -- deep blue
        -- header_hl_group = "Error" -- RED
    end

    -- ┌────────────────────────┐
    -- │          |             │
    -- │          |   .         │
    -- │   `.  *  |     .'      │
    -- │     `. ._|_* .'  .     │
    -- │   . * .'   `.  *       │
    ---│ ------|     |-------   │
    -- │   .  *`.___.' *  .     │
    -- │      .'  |* `.  *      │
    -- │    .' *  |  . `.       │
    -- │        . |             │
    -- │          |             │
    -- └────────────────────────┘

    local function dynamic_header() --TODO: Tweak this and fix the height/width conditions later.
        local uis = vim.api.nvim_list_uis()[1]
        local height = uis.height
        local width = uis.width
        local val = { --Default
            [[   ____       _   ___     ]],
            [[  / __/__ ___| | / (_)_ _ ]],
            [[ / _// -_) _ \ |/ / /  ' \]],
            [[/_/  \__/_//_/___/_/_/_/_/]],
        }
        if width > 88 and height > 36 and not daylight then
            val = {
                [[┌────────────────────────────────────────────────────────────────────────────────────────┐]],
                [[│           ____                                                                         │]],
                [[│       _.-'78o `"`--._                                                                  │]],
                [[│   ,o888o.  .o888o,   ''-.                                                              │]],
                [[│ ,88888P  `78888P..______.]                                                             │]],
                [[│/_..__..----""        __.'                                                              │]],
                [[│`-._       /""| _..-''                                                                  │]],
                [[│    "`-----\  `\                                                                        │]],
                [[│            |   ;.-""--..                                                               │]],
                [[│            | ,8o.  o88. `.     ,d8888b                           d8,                   │]],
                [[│            `;888P  `788P  :    88P`                             `8P                    │]],
                [[│      .o""-.|`-._         ./  d888888P`                                                 │]],
                [[│     J88 _.-/    ";"-P----'    ?88`  d8888b  88bd88b  ?88   d8P  88b  88bd8b,d88b       │]],
                [[│     `--'\`|     /  /          88P   d8b_,dP  88P` ?8b d88  d8P` 88P  88P``?8P`?8b      │]],
                [[│         | /     |  |          d88   88b     d88   88P ?8b ,88`  d88  d88  d88  88P     │]],
                [[│         \|     /   |         d88`   `?888P`d88`   88b `?888P`   d88` d88` d88`  88b    │]],
                [[│          `-----`---'-----===---======-----=---====---==-----===---==---==---===---=    │]],
                [[└────────────────────────────────────────────────────────────────────────────────────────┘]],
            }
        elseif width > 88 and height > 36 and daylight then
            val = {
                [[┌────────────────────────────────────────────────────────────────────────────────────────┐]],
                [[│           ____                                                                         │]],
                [[│       _.-'78o `"`--._                                                                  │]],
                [[│   ,o888o.  .o888o,   ''-.                                                              │]],
                [[│ ,88888P  `78888P..______.]                                                             │]],
                [[│/_..__..----""        __.'                                                              │]],
                [[│`-._       /""| _..-''                                                                  │]],
                [[│    "`-----\  `\                                                                        │]],
                [[│            |   ;.-""--..        ,...                          ,,                       │]],
                [[│            | ,8o.  o88. `.    .d' ""            `7MMF'   `7MF'db                       │]],
                [[│            `;888P  `788P  :   dM`                 `MA     ,V                           │]],
                [[│      .o""-.|`-._         ./  mMMmm.gP"Ya `7MMpMMMb.VM:   ,V `7MM  `7MMpMMMb.pMMMb.     │]],
                [[│     J88 _.-/    ";"-P----'    MM ,M'   Yb  MM    MM MM.  M'   MM    MM    MM    MM     │]],
                [[│     `--'\`|     /  /          MM 8M""""""  MM    MM `MM A'    MM    MM    MM    MM     │]],
                [[│         | /     |  |          MM YM.    ,  MM    MM  :MM;     MM    MM    MM    MM     │]],
                [[│         \|     /   |        .JMML.`Mbmmd'.JMML  JMML. VF    .JMML..JMML  JMML  JMML.   │]],
                [[│          `-----`---'--------=----=------=-----=------===-===-----==----==----==-----   │]],
                [[└────────────────────────────────────────────────────────────────────────────────────────┘]],
            }
        elseif width <= 88 and width > 20 and height > 60 then
            val = {
                [[┌───────────────────────────────────────────────┐]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠐⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡀⠂⠄⠤⡀⠄⢐⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠉⠄⠄⠐⠚⠙⠛⠂⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣠⡴⠄⠄⠄⠄⠄⠄⠄⣴⣿⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⣀⣠⣀⠠⠗⠙⠁⠄⠄⠄⠄⠄⠄⠄⠄⢿⣿⣿⣾⣦⠄⢀⣀⣦⣤⡠⠄⠄⠄⢀⠄⠂⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠊⠊⠟⠉⠄⠄⢠⣠⡤⠄⠄⠄⠄⠄⠄⠄⠄⠄⠙⠛⠛⠃⠄⠉⠛⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⣴⠄⠄⠄⠐⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⠿⠟⠛⠉⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢠⡖⠁⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⡠⠄⠄⠄⠄⠄⠄⠄⠄⠐⠐⠄⠄⠄⠄⠄⠈⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠒⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⢄⣀⣀⣒⣒⣂⣲⣶⣞⣊⡁⠐⠖⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠂⠘⠑⠒⠒⠚⠛⠿⠿⢿⡿⣯⠭⢏⣉⠉⠁⠄⠄⠄⠉⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⡀⣤⣤⡤⠤⢤⡀⠠⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠠⠄⢀⡀⠄⠄⠤⠦⠤⠴⠧⠼⢿⠿⠿⠧⠒⠛⠁⠢⠤⢀⣀⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠐⠄⠰⡖⢲⣰⣒⣶⡶⣶⡦⠤⣤⠤⠤⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠆⠤⢀⠠⣠⢬⣟⣛⣿⣿⣿⣿⣟⣿⣿⣬⢿⣥⣤⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠉⠙⠛⠿⢿⢿⠿⣿⣿⣿⣯⣿⣻⠄⠁⠄⠄⠄⢀⠄⠄⠄⠄⡀⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⠄⡀⠄⢀⣛⠶⣶⣶⣶⣶⣶⣦⣦⢄⠄⠄⠁⠉⠄⠄⠄⠄⠐⠐⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠛⠒⠛⠻⠿⢿⣿⣿⣿⣿⣷⣹⠭⠅⠄⠄⠄⠂⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠁⠄⠠⢀⠄⠈⠻⠛⠒⠲⣶⣶⡬⠭⠍⠛⠈⠛⠛⠖⠠⠁⠈⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠄⠄⠄⠄⠄⠩⠙⠒⠂⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄/) ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄o ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄// _  _ _   _  ,_,  _ _ _ ⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄//_(/_/ / /_/ |/  (_/ / / /_ ⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄/) ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[│⠄⠄⠄⠄⠄⠄⠄⠄⠄(/ ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄│]],
                [[└───────────────────────────────────────────────┘]],
            }
        elseif width < 100 and width >= 60 and height <= 60 and height >= 46 then
            val = {
                [[┌──────────────────────────────────────────────────────────────┐]],
                [[│⠀⠀⠀⠀⠀⠀⠀⢀⣷⣼⣿⣿⣿⣿⣿⣿⣿⠻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢐⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⠀⠀⠀⠀⠀⠀⠘⠿⠿⠻⣛⣿⣿⣿⡵⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢟⢟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠟⠻⣿⢦⣄⣻⣿⣿⣿⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠻⠿⠛⠿⠟⠿⣿⣿⣿⣿⣿⣿⡷│]],
                [[│⠀⠀⠀⠀⠀⠀⣠⣦⣿⣷⣷⣴⣿⢸⣿⣿⣿⣷⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⠀⠀⠀⠀⠀⠚⠻⠿⢛⣛⣻⣽⣿⣿⣷⣦⡤⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣠⣄⣬⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⠀⠀⠀⠀⠀⠤⡶⠹⣿⣿⣿⣿⣿⡟⣿⣿⣾⣻⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣝│]],
                [[│⣴⣦⣦⣄⣤⠀⠻⠿⠷⠈⠙⢫⣹⣧⣶⣽⢛⡛⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⣻⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣷⣤⣄⡀⣀⣀⠘⢑⡿⣿⣿⣿⢿⣟⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣦⣾│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣥⠀⢨⣧⣀⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠁⢼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣻│]],
                [[│⣁⣉⣻⣿⣿⣿⣿⣿⣿⣿⡿⠰⣾⣿⣿⡿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⢀⣇⠀⠀⠀⠀⠀⢀⢀⠠⢄⣤⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣟⣻⣿⠛⠻⠟⠟⢀⣙⣿⣷⡟⣿⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣺⡂⠀⣬⣷⡄⠀⢤⣇⣤⣿⣷⣾⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣾⣿⣦⡄⣀⣠⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠶⡎⡰⣾⣻⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣤⣤⣤⣤⣴⣿⣿⣧⣤⣤⣤⣰⣿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│  ______     _,   _        │⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│ (  /       ( |  /o        │⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│  -/--_  _ _  | /,  _ _ _  │⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│ _/  (/_/ / /_|/ (_/ / / /_│⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿│]],
                [[└────────────────┴───────────────────────────┴─────────────────┘]],
            }
        end
        return val
    end

    local options = {
        header = {
            type = "text",
            val = dynamic_header,
            opts = {
                position = "center",
                hl = header_hl_group,
            },
        },
        buttons = {
            type = "group",
            val = {

                button("n", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
                -- button("r", icons.ui.History .. " Recent Files", "<cmd>Telescope oldfiles<cr>"),
                button("w", icons.misc.Word .. " Find Word  ", ":Telescope live_grep<CR>"),
                button("f", icons.documents.Files .. " Find Files", ":Telescope find_files <CR>"),
                button("r", icons.misc.Repo .. " Search Repositories", ":cd ~/Repos<CR> :Telescope find_files <CR>"),
                button("s", icons.ui.SignIn .. " Find Session", ":SearchSession<CR>"),
                -- button("SPC f t", icons.type.String .. " Find Text", ":Telescope live_grep <CR>"),
                button("c", icons.ui.Gear .. " Configuration", ":e $MYVIMRC | :cd %:p:h <CR>"),
                button("u", icons.ui.CloudDownload .. " Update", ":Lazy update<CR>"),
                button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
                -- button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
                -- button("SPC f o", "  Recent File  ", ":Telescope oldfiles<CR>"),
                -- button("SPC f w", "  Find Word  ", ":Telescope live_grep<CR>"),
                -- button("SPC b m", "  Bookmarks  ", ":Telescope marks<CR>"),
                -- button("SPC t h", "  Themes  ", ":Telescope themes<CR>"),
            },
            opts = {
                spacing = 1,
            },
        },
        footer = {
            type = "text",
            val = require("alpha.fortune")(),
            opts = { hl = "Comment", position = "center" },
        },

        headerPaddingTop = { type = "padding", val = headerPadding },
        headerPaddingBottom = { type = "padding", val = 2 },
    }

    --options = require("user.functions").load_override(options, "goolord/alpha-nvim")

    require("alpha").setup({
        layout = {
            options.headerPaddingTop,
            options.header,
            options.headerPaddingBottom,
            options.buttons,
            options.footer,
        },
        opts = {},
    })

    -- Disable statusline in dashboard
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
            -- store current statusline value and use that
            local old_laststatus = vim.opt.laststatus
            vim.api.nvim_create_autocmd("BufUnload", {
                buffer = 0,
                callback = function()
                    vim.opt.laststatus = old_laststatus
                end,
            })
            vim.opt.laststatus = 0
        end,
    })
end
return M
