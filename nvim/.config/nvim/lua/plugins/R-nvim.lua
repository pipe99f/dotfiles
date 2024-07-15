return {
	"R-nvim/R.nvim",
	ft = "r",
	lazy = false,
	config = function()
		local opts = {
			R_args = { "--quiet", "--no-save" },
			hook = {
				on_filetype = function()
					-- This function will be called at the FileType event
					-- of files supported by R.nvim. This is an
					-- opportunity to create mappings local to buffers.
					vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
					vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
				end,
			},
			-- min_editor_width = 72,
			rconsole_height = 14,
			objbr_w = 30,
		}
		require("r").setup(opts)
	end,
}
