return {
    -- Possible Borders: [double, none, rounded, shadow, single, solid].
    ui = {
        transparent = false,
        border_style = "rounded",
        blink_cmp = {
            completion_border = "rounded",
            documentation_border = "rounded",
            signature_border = "rounded",
        },
        which_key = { border_style = "rounded" },
        fidget = { border_style = "none" },

        context = true, -- "Sticky scroll"
        winbar_title = false,
    },
}
