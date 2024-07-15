require("lspconfig").pyright.setup({
	capabilities = capabilities,
	filetypes = { "python" },
	on_attach = on_attach,
	settings = {
		python = {
			analysis = {
				diagnosticSeverityOverrides = {
					reportUnusedExpression = "none",
				},
			},
		},
	},
})
