return {
    "ziontee113/icon-picker.nvim",
    config = function()
        require("icon-picker").setup({ disable_legacy_commands = true })

        local opts = { noremap = true, silent = true }

        local map = require("core.functions").map
        map("n", "<Leader>S", "<cmd>IconPickerNormal<cr>", opts, "Symbols")
    end,
}
