return {
	-- {
	-- 	"kevinhwang91/nvim-ufo",
	-- 	dependencies = "kevinhwang91/promise-async",
	-- 	config = function()
	-- 		require("ufo").setup({
	-- 			provider_selector = function(bufnr, filetype, buftype)
	-- 				return { "treesitter", "indent" }
	-- 			end,
	-- 			preview = {
	-- 				win_config = {
	-- 					border = "rounded",
	-- 					winhighlight = "Normal:Normal",
	-- 					winblend = 0,
	-- 				},
	-- 				mappings = {
	-- 					scrollU = "<C-u>",
	-- 					scrollD = "<C-d>",
	-- 				},
	-- 			},
	-- 		})
	--
	-- 		vim.keymap.set("n", "zR", require("ufo").openAllFolds)
	-- 		vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
	-- 	end,
	-- },
	{
		"chrisgrieser/nvim-origami",
		event = "VeryLazy",
		opts = {}, -- needed even when using default config
		-- recommended: disable vim's auto-folding
		init = function()
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	},
}
