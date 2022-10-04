local status_ok, image = pcall(require, "image")
if not status_ok then
    return
end

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
