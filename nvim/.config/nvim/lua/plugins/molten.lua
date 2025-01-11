return {
	"benlubas/molten-nvim",
	version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
	dependencies = {
		-- "3rd/image.nvim",
		{ "willothy/wezterm.nvim", config = true },
	},
	build = ":UpdateRemotePlugins",
	init = function()
		-- these are examples, not defaults. Please see the readme
		vim.g.molten_image_provider = "wezterm"
		vim.g.molten_output_win_max_height = 20
	end,
	config = function()
		-- Copy paste from https://github.com/benlubas/molten-nvim/blob/main/docs/Notebook-Setup.md

		-- I find auto open annoying, keep in mind setting this option will require setting
		-- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
		vim.g.molten_auto_open_output = false -- must be false when using wezterm

		-- this guide will be using image.nvim
		-- Don't forget to setup and install the plugin if you want to view image outputs
		vim.g.molten_image_provider = "wezterm" -- can't use under tmux session

		-- optional, I like wrapping. works for virt text and the output window
		vim.g.molten_wrap_output = true

		-- Output as virtual text. Allows outputs to always be shown, works with images, but can
		-- be buggy with longer images
		vim.g.molten_virt_text_output = true

		-- this will make it so the output shows up below the \`\`\` cell delimiter
		vim.g.molten_virt_lines_off_by_1 = true

		-- Molten mappings
		vim.keymap.set("n", "<localleader>si", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
		vim.keymap.set("n", "<localleader>sl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
		vim.keymap.set(
			"n",
			"<localleader>ss",
			":MoltenReevaluateCell<CR>",
			{ silent = true, desc = "re-evaluate cell" }
		)
		vim.keymap.set(
			"v",
			"<localleader>s",
			":<C-u>MoltenEvaluateVisual<CR>gv",
			{ silent = true, desc = "evaluate visual selection" }
		)
		vim.keymap.set(
			"n",
			"<localleader>e",
			":MoltenEvaluateOperator<CR>",
			{ desc = "evaluate operator", silent = true }
		)
		vim.keymap.set(
			"n",
			"<localleader>os",
			":noautocmd MoltenEnterOutput<CR>",
			{ desc = "open output window", silent = true }
		)
		vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
		vim.keymap.set("n", "<localleader>sw", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

		-- if you work with html outputs:
		vim.keymap.set(
			"n",
			"<localleader>mx",
			":MoltenOpenInBrowser<CR>",
			{ desc = "open output in browser", silent = true }
		)

		-- Quarto mappings
		local runner = require("quarto.runner")
		vim.keymap.set("n", "<localleader>sr", runner.run_cell, { desc = "run cell", silent = true })
		vim.keymap.set("n", "<localleader>sa", runner.run_above, { desc = "run cell and above", silent = true })
		vim.keymap.set("n", "<localleader>sA", runner.run_all, { desc = "run all cells", silent = true })
		vim.keymap.set("n", "<localleader>sl", runner.run_line, { desc = "run line", silent = true })
		vim.keymap.set("v", "<localleader>s", runner.run_range, { desc = "run visual range", silent = true })
		vim.keymap.set("n", "<localleader>sA", function()
			runner.run_all(true)
		end, { desc = "run all cells of all languages", silent = true })

		-- Keeping cell outputs in both .md and .ipynb files
		-- automatically import output chunks from a jupyter notebook
		-- tries to find a kernel that matches the kernel in the jupyter notebook
		-- falls back to a kernel that matches the name of the active venv (if any)
		local imb = function(e) -- init molten buffer
			vim.schedule(function()
				local kernels = vim.fn.MoltenAvailableKernels()
				local try_kernel_name = function()
					local metadata = vim.json.decode(io.open(e.file, "r"):read("a"))["metadata"]
					return metadata.kernelspec.name
				end
				local ok, kernel_name = pcall(try_kernel_name)
				if not ok or not vim.tbl_contains(kernels, kernel_name) then
					kernel_name = nil
					local venv = os.getenv("VIRTUAL_ENV")
					if venv ~= nil then
						kernel_name = string.match(venv, "/.+/(.+)")
					end
				end
				if kernel_name ~= nil and vim.tbl_contains(kernels, kernel_name) then
					vim.cmd(("MoltenInit %s"):format(kernel_name))
				end
				vim.cmd("MoltenImportOutput")
			end)
		end

		-- automatically import output chunks from a jupyter notebook
		vim.api.nvim_create_autocmd("BufAdd", {
			pattern = { "*.ipynb" },
			callback = imb,
		})

		-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = { "*.ipynb" },
			callback = function(e)
				if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
					imb(e)
				end
			end,
		})

		-- automatically export output chunks to a jupyter notebook on write
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.ipynb" },
			callback = function()
				if require("molten.status").initialized() == "Molten" then
					vim.cmd("MoltenExportOutput!")
				end
			end,
		})
	end,
}
