return {
	"hkupty/iron.nvim",
	event = "VeryLazy",
	config = function()
		require("iron.core").setup({
			config = {
				-- If iron should expose `<plug>(...)` mappings for the plugins
				should_map_plug = false,
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					-- python = require("iron.fts.python").ipython,
					python = {
						command = { "ipython", "--no-autoindent", "--matplotlib=tkagg" },
						format = require("iron.fts.common").bracketed_paste_python,
						block_deviders = { "# %%", "#%%" },
					},
					markdown = {
						command = { "ipython", "--no-autoindent", "--matplotlib=tkagg" },
						format = require("iron.fts.common").bracketed_paste_python,
						block_deviders = { "# %%", "#%%" },
					},
					quarto = {
						command = { "ipython", "--no-autoindent", "--matplotlib=tkagg" },
						format = require("iron.fts.common").bracketed_paste,
						block_deviders = { "```" },
					},
					-- python = {
					-- 	command = { "jupyter-console" },
					-- 	format = require("iron.fts.common").bracketed_paste,
					-- 	block_deviders = { "# %%", "#%%" },
					-- },
					-- markdown = {
					-- 	command = { "jupyter-console" },
					-- 	format = require("iron.fts.common").bracketed_paste,
					-- },
					-- quarto = {
					-- 	command = { "jupyter-console" },
					-- 	format = require("iron.fts.common").bracketed_paste,
					-- 	block_deviders = { "```" },
					-- },
					r = {
						command = { "radian" },
					},
				},
				repl_open_cmd = "botright 11 split",
				-- repl_open_cmd = "60 vs",
				-- how the REPL window will be opened, the default is opening
				-- a float window of height 40 at the bottom.
			},
			-- Iron doesn't set keymaps by default anymore. Set them here
			-- or use `should_map_plug = true` and map from you vim files
			keymaps = {
				send_motion = "<space>sc",
				visual_send = "<space>sc",
				send_file = "<space>sf",
				send_line = "<space>sl",
				send_paragraph = "<space>sp",
				send_until_cursor = "<space>su",
				send_mark = "<space>sm",
				send_code_block = "<space>sb",
				send_code_block_and_move = "<space>sn",
				mark_motion = "<space>mc",
				mark_visual = "<space>mc",
				remove_mark = "<space>md",
				cr = "<space>s<cr>",
				interrupt = "<space>s<space>",
				exit = "<space>sq",
				clear = "<space>cl",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			highlight = {
				italic = true,
			},
		})
	end,
}
