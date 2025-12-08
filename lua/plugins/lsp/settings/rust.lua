-- Rust Tools Settings
-- automatically set inlay hints (type hints)

local function get_codelldb_paths()
    local mason_root = vim.fn.expand("$MASON")
    if mason_root == "$MASON" or mason_root == "" then
        mason_root = vim.fn.stdpath("data") .. "/mason"
    end
    local extension_path = mason_root .. "/packages/codelldb/extension/"
    local sysname = (vim.uv or vim.loop).os_uname().sysname
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb"

    if sysname:find("Windows") then
        codelldb_path = extension_path .. "adapter\\codelldb.exe"
        liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
    else
        liblldb_path = liblldb_path .. (sysname == "Darwin" and ".dylib" or ".so")
    end

    return codelldb_path, liblldb_path
end

local function build_codelldb_adapter(codelldb_path, liblldb_path)
    return {
        type = "server",
        port = "${port}",
        host = "127.0.0.1",
        executable = {
            command = codelldb_path,
            args = { "--liblldb", liblldb_path, "--port", "${port}" },
        },
    }
end

local codelldb_path, liblldb_path = get_codelldb_paths()
local adapter = false

if vim.fn.filereadable(codelldb_path) == 1 and vim.fn.filereadable(liblldb_path) == 1 then
    adapter = build_codelldb_adapter(codelldb_path, liblldb_path)
end

-- rustaceanvim reads this on startup; keep it as a table (not function) for compatibility.
vim.g.rustaceanvim = {
    tools = {
        executor = "toggleterm",
        single_file_support = true,
        reload_workspace_from_cargo_toml = true,
        inlay_hints = {
            auto = true,
            only_current_line = true,
            only_current_line_autocmd = "CursorHold",
            show_parameter_hints = true,
            locationLinks = false,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
        },
        hover_actions = {
            border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
            },
            auto_focus = false,
        },
    },
    server = {
        on_attach = require("plugins.lsp.handlers").on_attach,
        capabilities = require("plugins.lsp.handlers").capabilities,
        standalone = true,
        settings = {
            ["rust-analyzer"] = {
                trace = { server = "verbose" },
                inlayHints = { locationLinks = false },
                lens = { enable = true },
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                },
                completion = {
                    postfix = { enable = false },
                },
                check = {
                    command = "clippy",
                    extraArgs = {
                        "--",
                        "-W",
                        "clippy::all",
                        "-W",
                        "clippy::pedantic",
                        "-W",
                        "clippy::unwrap_used",
                        "-A",
                        "clippy::must_use",
                    },
                },
            },
        },
    },
    dap = {
        adapter = adapter,
    },
}
