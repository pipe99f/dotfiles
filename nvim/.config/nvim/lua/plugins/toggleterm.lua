return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<A-\>]],
		})
		local Terminal = require("toggleterm.terminal").Terminal

		-- Lazydocker
		local lazydocker = Terminal:new({
			cmd = "lazydocker",
			hidden = true,
			direction = "float",
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
			float_opts = {
				border = "double",
			},
		})
		function lazy_docker_toggle()
			lazydocker:toggle()
		end
		vim.keymap.set("n", "<M-d>", "<cmd>lua lazy_docker_toggle()<CR>", { desc = "Toggle lazydocker" })
		vim.keymap.set("t", "<M-d>", "<C-\\><C-n><cmd>lua lazy_docker_toggle()<CR>", { desc = "Toggle lazydocker" })
	end,
}
