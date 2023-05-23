local M = {}
function M.config()
    local status_ok, npairs = pcall(require, "nvim-autopairs")
    if not status_ok then
        return
    end

    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

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

    -- Autopairs for closures
    -- require Rule function
    npairs.add_rules({

        -- Rule('**', '**', 'markdown')
        --      :with_pair(cond.before_regex_check('%S', 1))
        --      :with_pair(cond.after_regex_check('%S', 1))
        --      :with_move(cond.none())
        --      :with_del(cond.none()),
        --
        -- Rule('_', '_', 'markdown')
        --     :with_pair(cond.before_regex_check('%S', 1))
        --     :with_pair(cond.after_regex_check('%S', 1))
        --     :with_move(cond.none())
        --     :with_del(cond.none()),

        -- Arrow key for js (item)=> -> (item)=> { } --
        Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
            :use_regex(true)
            :set_end_pair_length(2),
    })
end

return M
