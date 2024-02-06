local M = {}

M.config = function()
    local status_ok, nvim_tree = pcall(require, "transparent")
    if not status_ok then
        return
    end

    require('transparent').clear_prefix('lualine')
    require('transparent').clear_prefix('BufferLine')


    require("transparent").setup({
        groups = { -- table: default groups
            "Comment",
            "BufferLineBackground",
            "Conditional",
            "Constant",
            "CursorLineNr",
            "EndOfBuffer",
            "FloatBorder",
            "FloatShadow",
            "FloatShadowThrough",
            "Function",
            "FidgetTitle",
            "FidgetTask",
            "Identifier",
            "LineNr",
            "NvimTreeNormal",
            "NvimTreeNormalNC",
            "NvimTreeSignColumn",
            "NoicePopup",
            "NoiceFormatProgressDone",
            "NoiceLspProgressClient",
            "NoiceLspProgressSpinner",
            "NoiceLspProgressTitle",
            "NoiceFormatProgressTodo",
            "NoiceMini",
            "NonText",
            "NoText",
            "Normal",
            "NormalFloat",
            "NormalNC",
            "Operator",
            "PreProc",
            "Repeat",
            "SignColumn",
            "Special",
            "Statement",
            "String",
            "Structure",
            "Todo",
            "Type",
            "Underlined",
        },
        extra_groups = {}, -- table: additional groups that should be cleared
        exclude_groups = {}, -- table: groups you don't want to clear
    })

end
return M
