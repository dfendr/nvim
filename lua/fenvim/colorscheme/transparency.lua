local M = {}

M.config = function()
    local status_ok, nvim_tree = pcall(require, "transparent")
    if not status_ok then
        return
    end

    -- require('transparent').clear_prefix('lualine')
    require("transparent").clear_prefix("BufferLine")
    vim.cmd([[:highlight BufferLineFill ctermfg=None ctermbg=None guifg=None guibg=None]])

    require("transparent").setup({
        "BufferLineBackground",
        "Comment",
        "Conditional",
        "Constant",
        "CursorLineNr",
        "EOB",
        "EndOfBuffer",
        "FidgetTask",
        "FidgetTitle",
        "FloatBorder",
        "FloatShadow",
        "FloatShadowThrough",
        "Function",
        "Identifier",
        "LineNr",
        "NoText",
        "BufferLineFill",
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
