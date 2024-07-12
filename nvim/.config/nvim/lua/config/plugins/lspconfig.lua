local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

--lsp setups
require("config.plugins.lsp.bashls")
require("config.plugins.lsp.clangd")
require("config.plugins.lsp.cssls")
require("config.plugins.lsp.gopls")
require("config.plugins.lsp.html")
require("config.plugins.lsp.ltex")
require("config.plugins.lsp.marksman")
require("config.plugins.lsp.pyright")
require("config.plugins.lsp.r_language_server")
require("config.plugins.lsp.rust_analyzer")
require("config.plugins.lsp.sqlls")
require("config.plugins.lsp.lua_ls")
require("config.plugins.lsp.texlab")
require("config.plugins.lsp.tsserver")

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- for _, lsp in pairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     -- capabilites = capabilites,
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     }
--   }
-- end
--
