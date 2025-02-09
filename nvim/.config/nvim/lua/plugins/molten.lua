return {
	"benlubas/molten-nvim",
	version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
	ft = { "python", "quarto", "markdown" },
	dependencies = {
		"3rd/image.nvim",
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
		-- vim.g.molten_image_provider = "wezterm" -- can't use under tmux session
		vim.g.molten_image_provider = "image.nvim" -- can't use under tmux session

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
			"<localleader>sb",
			":MoltenReevaluateCell<CR>",
			{ silent = true, desc = "re-evaluate cell" }
		)
		vim.keymap.set(
			"v",
			"<localleader>sc",
			":<C-u>MoltenEvaluateVisual<CR>gv",
			{ silent = true, desc = "evaluate visual selection" }
		)
		vim.keymap.set(
			"n",
			"<localleader>sc",
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

		local find_correct_conda_kernel = function()
			local venv = os.getenv("CONDA_DEFAULT_ENV")
			local kernel_path = vim.fn.expand("~/.local/share/jupyter/kernels/") .. venv .. "/kernel.json"
			if venv ~= nil then
				if vim.fn.filereadable(kernel_path) == 1 then
					vim.cmd(("MoltenInit %s"):format(venv))
				else
					vim.notify("Creating new kernel " .. venv, vim.log.levels.INFO)
					vim.fn.system(("python -m ipykernel install --user --name %s"):format(venv))
					vim.cmd(("MoltenInit %s"):format(venv))
				end
			else
				vim.cmd("MoltenInit python3")
			end
		end

		vim.api.nvim_create_autocmd("BufAdd", {
			pattern = { "*.ipynb" },
			callback = function()
				find_correct_conda_kernel()
			end,
		})

		-- we have to do this as well so that we catch files opened like nvim ./hi.ipynb
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = { "*.ipynb" },
			callback = function()
				if vim.api.nvim_get_vvar("vim_did_enter") ~= 1 then
					find_correct_conda_kernel()
				end
				-- automatically import output chunks from a jupyter notebook
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

		-- change the configuration when editing a python file
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*.py",
			callback = function(e)
				if string.match(e.file, ".otter.") then
					return
				end
				if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
					vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
					vim.fn.MoltenUpdateOption("virt_text_output", false)
				else
					vim.g.molten_virt_lines_off_by_1 = false
					vim.g.molten_virt_text_output = false
				end
			end,
		})

		-- Undo those config changes when we go back to a markdown or quarto file
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = { "*.qmd", "*.md", "*.ipynb" },
			callback = function(e)
				if string.match(e.file, ".otter.") then
					return
				end
				if require("molten.status").initialized() == "Molten" then
					vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
					vim.fn.MoltenUpdateOption("virt_text_output", true)
				else
					vim.g.molten_virt_lines_off_by_1 = true
					vim.g.molten_virt_text_output = true
				end
			end,
		})

		-- Provide a command to create a blank new Python notebook
		-- note: the metadata is needed for Jupytext to understand how to parse the notebook.
		-- if you use another language than Python, you should change it in the template.
		local default_notebook = [[
    {
      "cells": [
       {
        "cell_type": "markdown",
        "metadata": {},
        "source": [
          ""
        ]
       }
      ],
      "metadata": {
       "kernelspec": {
        "display_name": "Python 3",
        "language": "python",
        "name": "python3"
       },
       "language_info": {
        "codemirror_mode": {
          "name": "ipython"
        },
        "file_extension": ".py",
        "mimetype": "text/x-python",
        "name": "python",
        "nbconvert_exporter": "python",
        "pygments_lexer": "ipython3"
       }
      },
      "nbformat": 4,
      "nbformat_minor": 5
    }
  ]]

		local function new_notebook(filename)
			local path = filename .. ".ipynb"
			local file = io.open(path, "w")
			if file then
				file:write(default_notebook)
				file:close()
				vim.cmd("edit " .. path)
			else
				print("Error: Could not open new notebook file for writing.")
			end
		end

		vim.api.nvim_create_user_command("NewNotebook", function(opts)
			new_notebook(opts.args)
		end, {
			nargs = 1,
			complete = "file",
		})
	end,
}
