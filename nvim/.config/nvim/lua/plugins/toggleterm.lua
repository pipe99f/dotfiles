return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	-- cmd = "ToggleTerm",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<A-\>]],
		})
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "gitui",
			dir = "git_dir",
			direction = "float",
			count = 5,
			hidden = true,
			float_opts = {
				border = "double",
			},
			-- function to run on opening the terminal
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
			-- function to run on closing the terminal
			on_close = function(term)
				vim.cmd("startinsert!")
			end,
		})

		local hiddenFloat = Terminal:new({
			direction = "float",
			count = 6,
			hidden = true,
		})

		function _lazygit_toggle()
			lazygit:toggle()
		end

		function _hiddenFloat()
			hiddenFloat:toggle()
		end
	end,
}
