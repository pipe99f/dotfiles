return {
	"glepnir/lspsaga.nvim",
	event = "LspAttach",
	config = function()
		local opts = { noremap = true, silent = true }
		local map = vim.keymap.set

		require("lspsaga").setup({
			ui = {
				border = "rounded",
				winblend = 0,
				colors = {
					normal_bg = "none",
				},
			},
		})

		map("n", "gn", "<cmd>Lspsaga rename<CR>", opts)
		map("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.cmd("Lspsaga hover_doc")
				-- require"lspsaga.hover".render_hover_doc()
			end
		end)
		map("n", ",j", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", { silent = true })
		map("n", ",k", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", { silent = true })
		map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
		map("n", "<space>ga", "<cmd>Lspsaga code_action<CR>", opts)
		map("v", "<space>ga", "<cmd><C-U>Lspsaga range_code_action<CR>", opts) -- no sirve

		map("n", "gD", "<cmd>lua require'telescope.builtin'.lsp_definitions()<CR>", opts)
		map("n", "gi", "<cmd>lua require'telescope.builtin'.lsp_implementations()<CR>", opts)
		map("n", "gt", "<cmd>lua require'telescope.builtin'.lsp_type_definitions()<CR>", opts)
		map("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)

		map("n", "gh", "<cmd>lua require('lspsaga.finder').lsp_finder()<CR>", opts)
		map("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

		map("n", "<space>f", "<cmd>lua vim.lsp.buf.format({async = false})<CR>", opts)

		map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
		map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	end,
}
