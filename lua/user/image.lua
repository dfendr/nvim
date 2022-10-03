local status_ok, image = pcall(require, "image")
if not status_ok then
    return
end

-- % / $file • Current File
-- # / $altFile • Alternate File
-- $dir • Current Working Directory
-- $filePath • Path to Current File
-- $fileBase • Basename of File (no extension)
-- $moduleName • Python Module Name

image.setup({ -- Require and call setup function somewhere in your init.lua
    render = {
        min_padding = 5,
        show_label = true,
        use_dither = true,
    },
    events = {
        update_on_nvim_resize = true,
    },
})
