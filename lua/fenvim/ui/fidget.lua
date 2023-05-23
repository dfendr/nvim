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
        text = {
            spinner = spinner_icon(), -- animation shown when tasks are ongoing
            done = "✔", -- character shown when all tasks are complete
            commenced = "Started", -- message shown when task starts
            completed = "Completed", -- message shown when task completes
        },
        align = {
            bottom = true, -- align fidgets along bottom edge of buffer
            right = true, -- align fidgets along right edge of buffer
        },
        timer = {
            spinner_rate = 125, -- frame rate of spinner animation, in ms
            fidget_decay = 2000, -- how long to keep around empty fidget, in ms
            task_decay = 1000, -- how long to keep around completed task, in ms
        },
        window = {
            relative = "win", -- where to anchor, either "win" or "editor"
            blend = 100, -- &winblend for the window
            zindex = nil, -- the zindex value for the window
            border = require("core.prefs").ui.fidget, -- style of border for the fidget window
        },
        fmt = {
            leftpad = true, -- right-justify text in fidget box
            stack_upwards = true, -- list of tasks grows upwards
            max_width = 0, -- maximum width of the fidget box
            -- function to format fidget title
            fidget = function(fidget_name, spinner)
                return string.format("%s %s", spinner, fidget_name)
            end,
            -- function to format each task line
            task = function(task_name, message, percentage)
                return string.format(
                    "%s%s [%s]",
                    message,
                    percentage and string.format(" (%s%%)", percentage) or "",
                    task_name
                )
            end,
        },
        sources = { -- Sources to configure
            ["null-ls"] = { -- Name of source
                ignore = true, -- Ignore notifications from this source
            },
        },
    })
end
return M
