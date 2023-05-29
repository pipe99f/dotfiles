require("lspconfig").pyright.setup({
	capabilities = capabilities,
	filetypes = { "python" },
	on_attach = on_attach,
})
