return {
	"R-nvim/R.nvim",
	ft = { "r", "rmd" },
	keys = {
		{ -- Restart graphic device and open in browser
			"<LocalLeader>gd",
			-- "<cmd>lua require('r.send').cmd('tryCatch(httpgd::hgd_browse(),error=function(e) {httpgd::hgd();httpgd::hgd_browse(browser = \\'brave\\')})')<CR>",
			"<cmd>lua require('r.send').cmd('tryCatch(httpgd::hgd_browse(),error=function(e) {httpgd::hgd();httpgd::hgd_browse()})')<CR>",
			desc = "httpgd",
		},
	},
	-- lazy = false,
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
			-- open_html = "no",
		}
		require("r").setup(opts)
	end,
}
