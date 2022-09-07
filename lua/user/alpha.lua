local present, alpha = pcall(require, "alpha")

if not present then
    return
end

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

local icons = require("user.icons")
local daylight = require("user.functions").daylight()
if daylight then
    header_hl_group = "String"
    else
    header_hl_group = "StorageClass" -- deep blue
    -- header_hl_group = "Error" -- RED
end

local options = {

    header = {
        type = "text",
        val = {
            "+─────────────────────────────────────────────────────────────────────────────────────────+",
            "│            ____                                                                         │",
            "│        _.-`78o ```--._                                                                  │",
            "│    ,o888o.  .o888o,   ``-.                                                              │",
            "│  ,88888P  `78888P..______.]                                                             │",
            "│ /_..__..----``        __.`                                                              │",
            "│ `-._       /``| _..-``                                                                  │",
            "│     ``------\\  `\\                                                                       │",
            "│             |   ;.-``--..                                                               │",
            "│             | ,8o.  o88. `.     ,d8888b                            d8,                  │",
            "│             `;888P  `788P  :    88P`                              `8P                   │",
            "│       .o``-.|`-._         ./  d888888P`                                                 │",
            "│      J88 _.-/    ;``-P----`    ?88`  d8888b  88bd88b  ?88   d8P  88b  88bd8b,d88b       │",
            "│      `--`\\`|     /  /          88P  d8b_,dP  88P` ?8b d88  d8P`  88P  88P``?8P`?8b      │",
            "│          | /     |  |         d88   88b     d88   88P ?8b ,88`  d88  d88  d88  88P      │",
            "│          \\|     /   |        d88`    `?888P`d88`   88b `?888P`  d88` d88` d88`  88b     │",
            "│           `-----`---`========---======-----=---====---==-----===---==---==---===---=    │",
            "+─────────────────────────────────────────────────────────────────────────────────────────+",
        },
        opts = {
            position = "center",
            hl = header_hl_group,
        },
    },

    buttons = {
        type = "group",
        val = {

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
            -- button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
            -- button("SPC f o", "  Recent File  ", ":Telescope oldfiles<CR>"),
            -- button("SPC f w", "  Find Word  ", ":Telescope live_grep<CR>"),
            -- button("SPC b m", "  Bookmarks  ", ":Telescope marks<CR>"),
            -- button("SPC t h", "  Themes  ", ":Telescope themes<CR>"),
            -- button("SPC e s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
        },
        opts = {
            spacing = 1,
        },
    },

    headerPaddingTop = { type = "padding", val = headerPadding },
    headerPaddingBottom = { type = "padding", val = 2 },
}

--options = require("user.functions").load_override(options, "goolord/alpha-nvim")

alpha.setup({
    layout = {
        options.headerPaddingTop,
        options.header,
        options.headerPaddingBottom,
        options.buttons,
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
