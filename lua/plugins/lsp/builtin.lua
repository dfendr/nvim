local M = {}

local function find_root(bufnr, markers)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fs.dirname(fname)
  local root = vim.fs.find(markers or { ".git" }, { path = dir, upward = true })[1]
  return root and vim.fs.dirname(root) or dir
end

local function safe_require(mod)
  local ok, val = pcall(require, mod)
  if ok then return val end
  return nil
end

function M.setup()
  -- Diagnostics/UI
  local handlers = require("plugins.lsp.handlers")
  handlers.setup()

  -- Capabilities (blink.cmp if present)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local blink = safe_require("blink.cmp")
  if blink and blink.get_lsp_capabilities then
    capabilities = blink.get_lsp_capabilities(capabilities)
  end

  local on_attach = handlers.on_attach

  -- Server definitions (minimal, extend as needed)
  local servers = {
    pyright = {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    },
    ts_ls = {
      -- typescript-language-server
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
      root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    },
    vtsls = {
      cmd = { "vtsls", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
      root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
    },
    bashls = {
      cmd = { "bash-language-server", "start" },
      filetypes = { "sh", "zsh" },
      root_markers = { ".git" },
    },
    clangd = {
      cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=bundled", "--cross-file-rename", "--header-insertion=iwyu" },
      filetypes = { "c", "cpp", "arduino" },
      root_markers = { "compile_commands.json", ".git" },
      capabilities = { offsetEncoding = "utf-8" },
    },
    jsonls = (function()
      local schemastore = safe_require("schemastore")
      return {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { ".git" },
        settings = schemastore and { json = { schemas = schemastore.json.schemas() } } or nil,
      }
    end)(),
    lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
      settings = {
        Lua = {
          telemetry = { enable = false },
          workspace = { checkThirdParty = false },
          diagnostics = { globals = { "vim" } },
        },
      },
    },
    yamlls = {
      cmd = { "yaml-language-server", "--stdio" },
      filetypes = { "yaml", "yml" },
      root_markers = { ".git" },
      settings = { yaml = { schemaStore = { enable = true } } },
    },
    tailwindcss = safe_require("plugins.lsp.settings.tailwindcss") or {
      cmd = { "tailwindcss-language-server", "--stdio" },
      filetypes = { "html", "css" },
    },
    emmet_ls = safe_require("plugins.lsp.settings.emmet_ls") or nil,
  }

  -- Autostart per filetype
  for name, cfg in pairs(servers) do
    if cfg and cfg.filetypes then
      vim.api.nvim_create_autocmd("FileType", {
        pattern = cfg.filetypes,
        callback = function(args)
          -- Avoid starting duplicate client for buffer
          local existing = vim.lsp.get_clients({ bufnr = args.buf, name = name })
          if existing and #existing > 0 then return end

          local fname = vim.api.nvim_buf_get_name(args.buf)
          local dir = vim.fs.dirname(fname)
          local marker = nil
          if cfg.root_markers then
            marker = vim.fs.find(cfg.root_markers, { path = dir, upward = true })[1]
          end
          if cfg.root_markers_required and not marker then
            return
          end

          local root_dir = cfg.root_dir or (marker and vim.fs.dirname(marker) or find_root(args.buf, cfg.root_markers))
          local final = vim.tbl_deep_extend("force", {}, cfg, {
            name = name,
            root_dir = root_dir,
            on_attach = on_attach,
            capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {}),
          })

          -- Remove keys not understood by vim.lsp.start
          final.filetypes = nil
          final.root_markers = nil

          vim.lsp.start(final)
        end,
      })
    end
  end
end

return M
