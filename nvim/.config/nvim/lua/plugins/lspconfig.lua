return {

	{ "neovim/nvim-lspconfig", dependencies = "williamboman/mason.nvim" },
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		config = function()
			local lsp_zero = require("lsp-zero")

			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- require("lspconfig").pyright.setup({
			-- 	capabilities = capabilities,
			-- 	filetypes = { "python" },
			-- 	on_attach = on_attach,
			-- 	settings = {
			-- 		python = {
			-- 			analysis = {
			-- 				diagnosticSeverityOverrides = {
			-- 					reportUnusedExpression = "none",
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })

			--lsp setups
			require("plugins.lsp.bashls")
			require("plugins.lsp.clangd")
			require("plugins.lsp.cssls")
			require("plugins.lsp.gopls")
			require("plugins.lsp.html")
			require("plugins.lsp.ltex")
			require("plugins.lsp.marksman")
			require("plugins.lsp.nim")
			require("plugins.lsp.pyright")
			require("plugins.lsp.r_language_server")
			require("plugins.lsp.rust_analyzer")
			require("plugins.lsp.sqlls")
			require("plugins.lsp.lua_ls")
			require("plugins.lsp.texlab")
			require("plugins.lsp.tsserver")

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
		end,
	},
}
