return {
    -- detached = false,
    -- settings = {
    --     typescript = {
    --         inlayHints = {
    --             includeInlayEnumMemberValueHints = true,
    --             includeInlayFunctionLikeReturnTypeHints = true,
    --             includeInlayFunctionParameterTypeHints = true,
    --             includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
    --             includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    --             includeInlayPropertyDeclarationTypeHints = true,
    --             includeInlayVariableTypeHints = true,
    --         },
    --     },
    -- },
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
}
