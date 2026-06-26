return {
	--Quarto
	{
		"quarto-dev/quarto-nvim",
		dev = false,
		ft = { "quarto", "markdown" },
		dependencies = {
			{
				"jmbuhr/otter.nvim",
				-- dependencies = { "nvim-treesitter/nvim-treesitter" },
				opts = {},
			},
		},
		config = function()
			require("quarto").setup({
				closePreviewOnExit = true,
				lspFeatures = {
					enabled = true,
					chunks = "all",
					languages = { "r", "python", "julia", "bash", "lua", "html" },
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
					completion = {
						enabled = true,
					},
				},
				codeRunner = {
					enabled = true,
					default_method = "molten",
				},
			})

			-- Quarto mappings
			local runner = require("quarto.runner")
			vim.keymap.set("n", "<localleader>sr", runner.run_cell, { desc = "run cell", silent = true })
			vim.keymap.set("n", "<localleader>sa", runner.run_above, { desc = "run cell and above", silent = true })
			vim.keymap.set("n", "<localleader>sA", runner.run_all, { desc = "run all cells", silent = true })
			vim.keymap.set("n", "<localleader>sl", runner.run_line, { desc = "run line", silent = true })
			-- vim.keymap.set("v", "<localleader>s", runner.run_range, { desc = "run visual range", silent = true })
		end,
	},
	{ -- preview equations
		"jbyuki/nabla.nvim",
		keys = {
			{ "<leader>qm", ':lua require"nabla".toggle_virt()<cr>', desc = "toggle [m]ath equations" },
		},
	},

	--Jupyter notebook
	{
		"kiyoon/jupynium.nvim",
		-- build = "pip3 install --user .",
		cmd = "JupyniumStartAndAttachToServer",
		build = "conda run --no-capture-output -n ds pip install .",
		-- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
	},
	{ "benlubas/image-save.nvim", cmd = "SaveImage" },
	{
		"sheng-tse/jupynvim",
		build = function(plugin)
			local install = loadfile(plugin.dir .. "/lua/jupynvim/install.lua")()
			install.run(plugin)
		end,
		config = function()
			require("jupynvim").setup({
				log_level = "info",
				image_renderer = "placeholder", -- "placeholder", "kitty", or "chafa"
			})
		end,
	},

	--Latex
	{
		"lervag/vimtex",
		-- ft = "tex", -- It is recommended to not lazy load
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
	},

	--Markdown
	{ -- Terminal markdown preview
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "rmd", "pandoc.markdown", "codecompanion", "Avante", "quarto", "AgenticChat" },
		opts = {
			file_types = { "quarto", "rmd", "markdown", "Avante", "codecompanion", "AgenticChat" },
		},
	},
	-- { -- UNMAINTAINED
	-- 	"iamcco/markdown-preview.nvim",
	-- 	build = "cd app && yarn install",
	-- 	ft = { "markdown", "rmd", "pandoc.markdown" },
	-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- 	config = function()
	-- 		vim.cmd([[let g:mkdp_browser = 'chromium']])
	-- 	end,
	-- },
	{ -- Maintained and with good mermaid support
		"selimacerbas/markdown-preview.nvim",
		dependencies = { "selimacerbas/live-server.nvim" },
		cmd = { "MarkdownPreview" },
		config = function()
			require("markdown_preview").setup({
				-- all optional; sane defaults shown
				instance_mode = "takeover", -- "takeover" (one tab) or "multi" (tab per instance)
				port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
				open_browser = true,
				debounce_ms = 300,
			})
		end,
	},

	-- Org mode
	{
		"nvim-orgmode/orgmode",
		-- event = "VeryLazy",
		ft = { "org" },
		dependencies = {
			{
				"akinsho/org-bullets.nvim",
				config = function()
					require("org-bullets").setup()
				end,
			},
			"chipsenkbeil/org-roam.nvim",
		},
		config = function()
			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/org/**/*",
				org_default_notes_file = "~/org/refile.org",
				org_startup_folded = "showeverything", -- options: overview (show top level), content (first two levels), showeverything (all levels)
				mappings = {
					org = {
						org_cycle = "<leader>c",
						org_global_cycle = "<leader>gc",
					},
					agenda = {
						org_agenda_goto = "<leader>gt",
					},
				},
			})

			vim.lsp.enable("org")
		end,
	},
	{
		"chipsenkbeil/org-roam.nvim",
		ft = "org",
		tag = "0.1.1",
		config = function()
			require("org-roam").setup({
				directory = "~/org_roam_files",
				-- optional
				org_files = {
					"~/another_org_dir",
					"~/some/folder/*.org",
					"~/a/single/org_file.org",
				},
			})
		end,
	},
}
