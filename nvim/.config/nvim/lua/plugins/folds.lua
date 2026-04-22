return {
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {
			autoFold = {
				enabled = false, -- I don't like this feature. Folds are inconsistent.
				kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
			},
			useLspFoldsWithTreesitterFallback = {
				enable = true,
				foldmethodIfNeitherIsAvailable = function(bufnr)
					local ft = vim.bo[bufnr].filetype
					local ft_filter = { "help", "text" }
					if vim.list_contains(ft_filter, ft) then
						return "manual"
					else
						return "indent"
					end
				end,
			},
		}, -- needed even when using default config
		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},
}
