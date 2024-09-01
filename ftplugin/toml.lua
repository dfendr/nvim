local status_ok, functions = pcall(require, "core.functions")
if not status_ok then
    return
end

if vim.fn.expand('%:t') ~= 'Cargo.toml' then
    return
end

local status_ok, which_key = pcall(require, "which-key")
if status_ok then
    which_key.add({
        { "<localleader>", buffer = 0, group = "Crates", nowait = true, remap = false },
        { "<localleader>o", "<cmd>lua require('crates').show_popup()<CR>", buffer = 0, desc = "Show Popup", nowait = true, remap = false },
        { "<localleader>r", "<cmd>lua require('crates').reload()<CR>", buffer = 0, desc = "Reload", nowait = true, remap = false },
        { "<localleader>v", "<cmd>lua require('crates').show_versions_popup()<CR>", buffer = 0, desc = "Show Versions", nowait = true, remap = false },
        { "<localleader>f", "<cmd>lua require('crates').show_features_popup()<CR><cmd>lua require('crates').show_features_popup()<CR>", buffer = 0, desc = "Show Features", nowait = true, remap = false },
        { "<localleader>d", "<cmd>lua require('crates').show_dependencies_popup()<CR>", buffer = 0, desc = "Show Dependencies", nowait = true, remap = false },
        { "<localleader>u", "<cmd>lua require('crates').update_crate()<CR>", buffer = 0, desc = "Update Crate", nowait = true, remap = false },
        { "<localleader>a", "<cmd>lua require('crates').update_all_crates()<CR>", buffer = 0, desc = "Update All Crates", nowait = true, remap = false },
        { "<localleader>U", "<cmd>lua require('crates').upgrade_crate()<CR>", buffer = 0, desc = "Upgrade Crate", nowait = true, remap = false },
        { "<localleader>A", "<cmd>lua require('crates').upgrade_all_crates(true)<CR>", buffer = 0, desc = "Upgrade All Crates", nowait = true, remap = false },
        { "<localleader>H", "<cmd>lua require('crates').open_homepage()<CR>", buffer = 0, desc = "Open Homepage", nowait = true, remap = false },
        { "<localleader>R", "<cmd>lua require('crates').open_repository()<CR>", buffer = 0, desc = "Open Repository", nowait = true, remap = false },
        { "<localleader>D", "<cmd>lua require('crates').open_documentation()<CR>", buffer = 0, desc = "Open Documentation", nowait = true, remap = false },
        { "<localleader>C", "<cmd>lua require('crates').open_crates_io()<CR>", buffer = 0, desc = "Open Crates.io", nowait = true, remap = false },
    })
end

