local flutter_ok, rusttools = pcall(require, "flutter-tools")
if not flutter_ok then
    return
end

local telescope_ok, telescope = pcall(require, "telescope")
if telescope_ok then
    telescope.load_extension("flutter")
end

local whichkey_ok, which_key = pcall(require, "which-key")
if whichkey_ok then
    which_key.add({
    { "<localleader>", buffer = 0, group = "Dart", nowait = true, remap = false },
    { "<localleader>r", "<cmd>FlutterRun<Cr>", buffer = 0, desc = "Run", nowait = true, remap = false },
    { "<localleader>e", "<cmd>FlutterEmulators<Cr>", buffer = 0, desc = "Emulator List", nowait = true, remap = false },
    { "<localleader>d", "<cmd>FlutterDevTools<Cr>", buffer = 0, desc = "Start Dev Tools Server", nowait = true, remap = false },
    { "<localleader>f", "<cmd>Telescope flutter commands<cr>", buffer = 0, desc = "Flutter Commands", nowait = true, remap = false },
    })

end
