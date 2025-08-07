return {
    "ziontee113/icon-picker.nvim",
    config = function()
        require("icon-picker").setup({ disable_legacy_commands = true })

        -- Mapped in which-key.lua
    end,
}
