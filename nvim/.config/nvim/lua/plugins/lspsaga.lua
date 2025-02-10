return {
	"glepnir/lspsaga.nvim",
	event = "LspAttach",
	config = function()
		local opts = { noremap = true, silent = true }
		local map = vim.keymap.set

		require("lspsaga").setup({
			symbol_in_winbar = { enable = false },
		})

		map("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.cmd("Lspsaga hover_doc")
			end
		end)
		map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
		map("n", "<space>ga", "<cmd>Lspsaga code_action<CR>", opts)

		map("n", "gD", "<cmd>lua require'telescope.builtin'.lsp_definitions()<CR>", opts)
		map("n", "gi", "<cmd>lua require'telescope.builtin'.lsp_implementations()<CR>", opts)
		map("n", "gt", "<cmd>lua require'telescope.builtin'.lsp_type_definitions()<CR>", opts)
		map("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)

		map("n", "gh", "<cmd>Lspsaga finder<CR>", opts)
		map("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

		map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
		map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	end,
}
