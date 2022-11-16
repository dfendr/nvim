-- local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/perlnavigator/perlnavigator/"

-- local exe = vim.env.HOME
--     .. "/.local/share/nvim/mason/packages/perlnavigator/node_modules/perlnavigator-server/out/server.js"
-- print(exe)
return {
    -- default_config = {
    --     -- cmd = "perlnavigator",
    -- },
    settings = {
        -- cmd = { exe },
        -- executable = "perlnavigator",
        perlnavigator = {
            cmd = { "perlnavigator", "--stdio" },
            filetypes = { "perl" },
            perlPath = "perl",
            enableWarnings = true,
            perltidyProfile = "",
            perlcriticProfile = "",
            perlcriticEnabled = true,
        },
    },
}
