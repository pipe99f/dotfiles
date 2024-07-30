return {

	-----------
	----LSP----
	-----------

	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		opts = {
			-- Your setup opts here
		},
	},
	-- {
	-- 	"j-hui/fidget.nvim",
	-- 	opts = {
	-- 		notification = {
	-- 			window = {
	-- 				winblend = 0,
	-- 			},
	-- 		},
	-- 	},
	-- },

	-----------------
	----Debugging----
	-----------------

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			-- virtual text for the debugger
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		config = function(self, opts)
			-- Debug settings if you're using nvim-dap
			local dap = require("dap")

			dap.configurations.scala = {
				{
					type = "scala",
					request = "launch",
					name = "RunOrTest",
					metals = {
						runType = "runOrTestFile",
						--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
					},
				},
				{
					type = "scala",
					request = "launch",
					name = "Test Target",
					metals = {
						runType = "testTarget",
					},
				},
			}
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
			-- require("core.utils").load_mappings("dap_python")
		end,
	},
	"nvim-neotest/neotest",

	-----------
	----cmp----
	-----------

	{ "onsails/lspkind.nvim", event = "VeryLazy" },
	{
		"lkhphuc/jupyter-kernel.nvim",
		opts = {
			inspect = {
				-- opts for vim.lsp.util.open_floating_preview
				window = {
					max_width = 84,
				},
			},
			-- time to wait for kernel's response in seconds
			timeout = 0.5,
		},
		cmd = { "JupyterAttach", "JupyterInspect", "JupyterExecute" },
		build = ":UpdateRemotePlugins",
		keys = { { "<leader>k", "<Cmd>JupyterInspect<CR>", desc = "Inspect object in kernel" } },
	},

	----------------
	----Snippets----
	----------------

	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		dependencies = {
			{ --vscode-like
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			{ --snipmate-like (el plugin de snipmate no incluye ningún snippet)
				"honza/vim-snippets",
				config = function()
					require("luasnip.loaders.from_snipmate").lazy_load()
				end,
			},
			"evesdropper/luasnip-latex-snippets.nvim",
		},
	},

	--comments
	{ "numToStr/Comment.nvim", event = "VeryLazy" },
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "VeryLazy",
		opts = {},
  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
	},

	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				function()
					require("yazi").yazi()
				end,
				desc = "Open the file manager",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				function()
					require("yazi").yazi(nil, vim.fn.getcwd())
				end,
				desc = "Open the file manager in nvim's working directory",
			},
		},
		---@type YaziConfig
		opts = {
			open_for_directories = false,
		},
	},

	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },

	-------------
	----MODES----
	-------------
	--Docker
	-- ("dgrbrady/nvim-docker"),

	-- Kubernetes
	{
		"ramilito/kubectl.nvim",
		config = function()
			require("kubectl").setup()
		end,
	},

	--Git
	{
		"NeogitOrg/neogit",
		dependencies = {
			"sindrets/diffview.nvim", -- optional - Diff integration
		},
		cmd = { "Neogit" },
		config = true,
	},

	{
		"isakbm/gitgraph.nvim",
	},

	--Quarto
	{
		"quarto-dev/quarto-nvim",
		dev = false,
		ft = { "quarto", "markdown" },
		dependencies = {
			{
				"jmbuhr/otter.nvim",
				dev = false,
				config = function()
					require("otter").setup()
				end,
			},
		},
		config = function()
			require("quarto").setup({
				closePreviewOnExit = true,
				lspFeatures = {
					enabled = true,
					chunks = "curly",
					languages = { "r", "python", "julia", "bash", "lua", "html" },
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
					completion = {
						enabled = true,
					},
				},
			})
		end,
	},

	--Jupyter notebook
	{
		"GCBallesteros/jupytext.nvim",
		config = function()
			require("jupytext").setup({
				style = "markdown",
				output_extension = "md",
				force_ft = "markdown",
			})
		end,
	},

	{
		"kiyoon/jupynium.nvim",
		build = "pip3 install --user .",
		-- build = "conda run --no-capture-output -n jupynium pip install .",
		-- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
	},
	{
		-- see the image.nvim readme for more information about configuring this plugin
		"3rd/image.nvim",
		opts = {
			backend = "kitty", -- whatever backend you would like to use
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
		config = function()
			-- require("image").setup()
			package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
			package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"
		end,
	},

	{ "benlubas/image-save.nvim", cmd = "SaveImage" },

	--Latex
	{
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
	},

	--Markdown
	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown", "rmd", "pandoc.markdown" },
		-- dependencies = {
		-- 	-- You may not need this if you don't lazy load
		-- 	-- Or if the parsers are in your $RUNTIMEPATH
		-- 	"nvim-treesitter/nvim-treesitter",
		-- 	"nvim-tree/nvim-web-devicons",
		-- },
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown", "rmd", "pandoc.markdown" },
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		config = function()
			vim.cmd([[let g:mkdp_browser = 'chromium']])
		end,
	},

	-- Org mode
	{
		"nvim-neorg/neorg",
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		opts = {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							general = "~/neorg",
							-- my_other_notes = "~/work/notes",
						},
						index = "index.norg",
					},
					["core.integrations.telescope"] = {},
				},
			},
			dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
			config = true,
		},
	},

	-- CP
	{
		"kawre/leetcode.nvim",
		cmd = "Leet", --launching from the terminal with "nvim leetcode.nvim" doesnt work
		opts = {},
	},
	{
		"xeluxee/competitest.nvim",
		cmd = "CompetiTest",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("competitest").setup()
		end,
	},

	-- Quickfix
	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	-- Neovim config
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

	--------
	---AI---
	--------
	{
		"Exafunction/codeium.nvim",
		event = "InsertEnter",
		opts = {
			-- enable_chat = true,
		},
		build = ":Codeium Auth",
	},
	-- {
	--     "dpayne/CodeGPT.nvim",
	--     dependencies = {
	--       'nvim-lua/plenary.nvim',
	--       'MunifTanjim/nui.nvim',
	--     },
	--     config = function()
	--         require("codegpt.config")
	--     end
	-- },
	-- {
	-- 	"dense-analysis/neural",
	-- 	config = function()
	-- 		require("neural").setup({
	-- 			open_ai = {
	-- 				api_key = "<YOUR OPENAI API SECRET KEY>",
	-- 			},
	-- 		})
	-- 	end,
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"ElPiloto/significant.nvim",
	-- 	},
	-- },
	--
	-- {
	-- 	"jackMort/ChatGPT.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("chatgpt").setup({
	-- 			-- optional configuration
	-- 		})
	-- 	end,
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- },
	--
	-- 'aduros/ai.vim',

	----------------------------
	---compiling/running code---
	----------------------------

	{ "michaelb/sniprun", build = "bash ./install.sh", cmd = "SnipRun" },
	{ "milanglacier/yarepl.nvim", config = true }, -- data science use case
	{
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
		dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
		opts = {},
	},
	{ -- The task runner we use
		"stevearc/overseer.nvim",
		cmd = { "OverseerBuild", "OverseerRun" },
		opts = {
			strategy = "toggleterm",
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
			},
		},
	},

	--------------------------
	----appearance details----
	--------------------------

	{ "nvim-tree/nvim-web-devicons" },
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		messages = {
	-- 			-- NOTE: If you enable messages, then the cmdline is enabled automatically.
	-- 			-- This is a current Neovim limitation.
	-- 			enabled = true,
	-- 			view = "mini", -- default view for messages
	-- 			view_error = "mini", -- view for errors
	-- 			view_warn = "mini", -- view for warnings
	-- 		},
	-- 		lsp = {
	-- 			progress = {
	-- 				enabled = false,
	-- 			},
	-- 			signature = {
	-- 				enabled = false,
	-- 			},
	-- 		},
	-- 		dependencies = {
	-- 			"MunifTanjim/nui.nvim",
	-- 			"rcarriga/nvim-notify",
	-- 		},
	-- 	},
	-- },
	{
		"nvim-treesitter/nvim-treesitter-context",
		cmd = { "TSContextEnable", "TSContesxtToggle" },
	},
	{
		"tamton-aquib/staline.nvim",
		config = function()
			require("staline").setup()
		end,
	},
	{
		"xiyaowong/nvim-transparent",
		config = function()
			require("transparent").setup({ -- Optional, you don't have to run setup.
				extra_groups = {
					"NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
					"NvimTreeNormal", -- NvimTree
				},
			})
			require("transparent").clear_prefix("BufferLine")
		end,
		opts = {},
	},
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{ "HiPhish/rainbow-delimiters.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	},
	-- {
	-- 	"HampusHauffman/block.nvim",
	-- 	config = function()
	-- 		require("block").setup({})
	-- 	end,
	-- },

	--------------
	----typing----
	--------------

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {
			fast_wrap = {},
		},
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "typescript", "javascript", "markdown" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"Wansmer/treesj",
		keys = {
			{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},

	--   'mg979/vim-visual-multi',

	-----------------------------
	----Efficient keybindings----
	-----------------------------

	{
		"ggandor/leap.nvim",
		event = "VeryLazy",
		config = function()
			require("leap").add_default_mappings(true)
		end,
	},
	{
		"ggandor/flit.nvim",
		event = "VeryLazy",
		config = function()
			require("flit").setup({
				keys = { f = "f", F = "F", t = "t", T = "T" },
				-- A string like "nv", "nvo", "o", etc.
				labeled_modes = "v",
				multiline = true,
				-- Like `leap`s similar argument (call-specific overrides).
				-- E.g.: opts = { equivalence_classes = {} }
				opts = {},
			})
		end,
	},

	--------------
	----Others----
	--------------
	{ "nvim-lua/plenary.nvim", lazy = true },
	{
		"ahmedkhalf/project.nvim",
		opts = {
			-- manual_mode = true,
		},
		event = "VeryLazy",
		config = function(_, opts)
			require("project_nvim").setup(opts)
		end,
	},
	{
		"rmagatti/auto-session",
		-- event = "VeryLazy",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_save_enabled = true,
				auto_restore_enabled = true,
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"LintaoAmons/scratch.nvim",
		event = "VeryLazy",
	},
	{ "ekickx/clipboard-image.nvim" },
}
