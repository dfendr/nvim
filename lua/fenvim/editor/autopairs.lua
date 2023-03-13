local M = {}
function M.config()
    local status_ok, npairs = pcall(require, "nvim-autopairs")
    if not status_ok then
        return
    end

    npairs.setup({
        check_ts = true,
        ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            java = false,
        },
        ignored_next_char = "[%w%.]",
        enable_check_bracket_line = true,
        disable_filetype = { "TelescopePrompt", "spectre_panel", "alpha" },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    })

    --TODO: : Add rules for MD
    -- local Rule = require("nvim-autopairs.rule")
    -- npairs.add_rule(Rule("**", "**", "md"))
end

return M
