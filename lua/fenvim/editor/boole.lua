local status_ok, boole = pcall(require, "boole")
if not status_ok then
    return
end

require("boole").setup({
    mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
    },
    -- User defined loops
    additions = {
        { "Foo", "Bar" },
        { "tic", "tac", "toe" },
    },
})

