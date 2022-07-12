local lspconfig = require("lspconfig")

local servers = { "bashls", "clangd", "cssls", "gopls", "html", "ltex", "marksman", "pyright", "r_language_server", "rust_analyzer", "sqls", "sumneko_lua", "texlab", "tsserver"}


require("nvim-lsp-installer").setup{
    ensure_installed = servers,
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }    


}
