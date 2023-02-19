local status_ok, neodev = pcall(require, "neodev")
if not status_ok then
    goto continue
end

neodev.setup({
    -- add any options here, or leave empty to use the default settings

    library = {
        enabled = false, -- when not enabled, lua-dev will not change any settings to the LSP server
        -- these settings will be used for your Neovim config directory
        runtime = true, -- runtime path
        types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = true, -- installed opt or start plugins in packpath
        -- you can also specify the list of plugins to make available as a workspace library
        -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
    -- for your Neovim config directory, the config.library settings will be used as is
    -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
    -- for any other directory, config.library.enabled will be set to false
    override = function(root_dir, options) end,
})

::continue::
return {
    settings = {
        Lua = {
            type = {
                -- weakUnionCheck = true,
                -- weakNilCheck = true,
                -- castNumberToInteger = true,
            },
            format = {
                enable = false,
            },
            hint = {
                enable = true,
                arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
                await = true,
                paramName = "Disable", -- "All", "Literal", "Disable"
                paramType = false,
                semicolon = "Disable", -- "All", "SameLine", "Disable"
                setType = true,
            },
            -- spell = {"the"}
            runtime = {
                version = "LuaJIT",
                special = {
                    reload = "require",
                },
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                    -- [vim.fn.datapath "config" .. "/lua"] = true,
                },
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
