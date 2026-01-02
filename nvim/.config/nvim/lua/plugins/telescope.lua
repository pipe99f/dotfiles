return {
	"nvim-telescope/telescope.nvim",
	-- tag = "*", -- not working, however, according to one issue, master is the branch to use
	branch = "master",
	cmd = "Telescope",
	dependencies = {

    -- stylua: ignore
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		{ "nvim-telescope/telescope-frecency.nvim", dependencies = { "tami5/sqlite.lua" } },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<c-t>"] = require("trouble.sources.telescope").open,
					},
					n = { ["<c-t>"] = require("trouble.sources.telescope").open },
				},
			},
			pickers = {
				-- Default configuration for builtin pickers goes here:
				-- picker_name = {
				--   picker_config_key = value,
				--   ...
				-- }
				-- Now the picker_config_key will be applied every time you call this
				-- builtin picker
			},
			extensions = {
				fzf = {
					fuzzy = true,
				},
				-- Your extension configuration goes here:
				-- extension_name = {
				--   extension_config_key = value,
				-- }
				-- please take a look at the readme of the extension you want to configure
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("projects")
		require("telescope").load_extension("frecency")
	end,
}
