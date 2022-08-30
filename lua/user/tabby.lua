local status_ok, tabby = pcall(require, "tabby")
if not status_ok then
    return
end

tabby.setup({ -- Defaults configuration options
 tabline = require("tabby.presets").active_wins_at_tail,
})
