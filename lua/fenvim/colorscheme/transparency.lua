local M = {}

M.config = function()
    local status_ok, nvim_tree = pcall(require, "transparent")
    if not status_ok then
        return
    end

    -- require('transparent').clear_prefix('lualine')
    require("transparent").clear_prefix("BufferLine")

    require("transparent").setup({
        "BufferLineBackground",
        "BufferLineFill",
        "Comment",
        "Conditional",
        "Constant",
        "CursorLineNr",
        "EndOfBuffer",
        "EOB",
        "FidgetTask",
        "FidgetTitle",
        "FloatBorder",
        "FloatShadow",
        "FloatShadowThrough",
        "Function",
        "Headline",
        "Identifier",
        "LineNr",
        "NoiceFormatProgressDone",
        "NoiceFormatProgressTodo",
        "NoiceLspProgressClient",
        "NoiceLspProgressSpinner",
        "NoiceLspProgressTitle",
        "NoiceMini",
        "NoicePopup",
        "NonText",
        "Normal",
        "NormalFloat",
        "NormalNC",
        "NoText",
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "NvimTreeSignColumn",
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
        groups = { -- table: default groups
        },
        extra_groups = {}, -- table: additional groups that should be cleared
        exclude_groups = {}, -- table: groups you don't want to clear
    })
end
return M
