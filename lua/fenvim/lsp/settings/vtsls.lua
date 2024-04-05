return {

    client = {
        server_capabilities = { documentFormattingProvider = false, documentRangeFormattingProvider = false },
    },
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
}
