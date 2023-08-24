local jdtls = vim.fs.normalize(vim.fn.stdpath("data") .. "/mason/packages/jdtls/jdtls")
local config = {
    cmd = { jdtls },
    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
    on_attach = require("fenvim.lsp.handlers").on_attach,
    settings = { java = {
        signatureHelp = { enabled = true },
    } },
}

return config
