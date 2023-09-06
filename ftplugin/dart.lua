local status_ok, rusttools = pcall(require, "flutter-tools")
if not status_ok then
    return
end

local status_ok, telescope = pcall(require, "telescope")
if status_ok then
    telescope.load_extension("flutter")
end

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<localleader>",
        buffer = 0, -- Local Buffer
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    local mappings = {
        name = "Dart",
        r = { "<cmd>FlutterRun<Cr>", "Run" },
        e = { "<cmd>FlutterEmulators<Cr>", "Emulator List" },
        d = { "<cmd>FlutterDevTools<Cr>", "Start Dev Tools Server" },
        f = { "<cmd>Telescope flutter commands<cr>", "Flutter Commands" },
    }

    which_key.register(mappings, opts)
end
