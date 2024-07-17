return {
	"lervag/vimtex",
	ft = "tex",
	config = function()
		vim.g.vimtex_compiler_latexmk = {
			build_dir = ".out",
			options = {
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				"-interaction=nonstopmode",
				"-synctex=1",
			},
		}

		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_fold_enabled = true
		vim.g.vimtex_quickfix_mode = 0
	end,
}
