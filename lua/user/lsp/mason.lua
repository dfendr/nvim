local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup {
     ui = {
         icons = {
             package_installed = "✓"
         }
     }
 }

 require("mason-lspconfig").setup {
     ensure_installed = { "sumneko_lua" },
 }
