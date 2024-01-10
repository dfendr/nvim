local M = {}

local function spinner_icon()
    if require("utils.functions").daylight() then
        return "star"
    else
        return "moon"
    end
end

function M.config()
    require("fidget").setup({
        progress = {
            ignore_done_already = true, -- Ignore new tasks that are already complete
            ignore = { "null-ls" },
            display = {
                done_icon = "✔", -- character shown when all tasks are complete
                progress_icon = { pattern = spinner_icon(), period = 1 },
            },
        },
    })
end
return M
