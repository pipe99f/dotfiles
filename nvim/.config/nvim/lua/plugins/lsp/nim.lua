require("lspconfig").nim_langserver.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})
