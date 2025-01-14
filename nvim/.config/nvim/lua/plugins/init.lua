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

		-- these dependencies will only be loaded when luasnip loads
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

	{
		"mikavilpas/yazi.nvim",
		-- event = "VeryLazy",
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
		keys = {
			{ "<leader>K", '<cmd>lua require("kubectl").toggle()<cr>', desc = "Toggle kubectl" },
		},
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
		---@type I.GGConfig
		opts = {
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%H:%M:%S %d-%m-%Y",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				on_select_commit = function(commit)
					print("selected commit:", commit.hash)
				end,
				on_select_range_commit = function(from, to)
					print("selected range:", from.hash, to.hash)
				end,
			},
		},
		keys = {
			{
				"<leader>gl",
				function()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "GitGraph - Draw",
			},
		},
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
				codeRunner = {
					enabled = true,
					default_method = "molten",
				},
			})
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
		cmd = "JupyniumStartAndAttachToServer",
		-- build = "conda run --no-capture-output -n jupynium pip install .",
		-- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
	},
	-- {
	-- 	-- see the image.nvim readme for more information about configuring this plugin
	-- 	"3rd/image.nvim",
	-- 	opts = {
	-- 		backend = "kitty", -- whatever backend you would like to use
	-- 		max_width = 100,
	-- 		max_height = 12,
	-- 		max_height_window_percentage = math.huge,
	-- 		max_width_window_percentage = math.huge,
	-- 		window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
	-- 		window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	-- 	},
	-- },

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
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "rmd", "pandoc.markdown", "codecompanion", "Avante" },
		opts = {
			file_types = { "markdown", "Avante", "codecompanion" },
		},
	},
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	ft = { "markdown", "rmd", "pandoc.markdown" },
	-- 	-- dependencies = {
	-- 	-- 	-- You may not need this if you don't lazy load
	-- 	-- 	-- Or if the parsers are in your $RUNTIMEPATH
	-- 	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	-- 	"nvim-tree/nvim-web-devicons",
	-- 	-- },
	-- },
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown", "rmd", "pandoc.markdown" },
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		config = function()
			vim.cmd([[let g:mkdp_browser = 'firefox']])
		end,
	},

	-- Org mode
	{
		"nvim-neorg/neorg",
		-- lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		ft = "norg",
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
	{
		"nvim-orgmode/orgmode",
		-- event = "VeryLazy",
		ft = { "org" },
		dependencies = { "akinsho/org-bullets.nvim", "chipsenkbeil/org-roam.nvim" },
		config = function()
			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/orgfiles/**/*",
				org_default_notes_file = "~/orgfiles/refile.org",
			})

			-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
			-- add ~org~ to ignore_install
			-- require('nvim-treesitter.configs').setup({
			--   ensure_installed = 'all',
			--   ignore_install = { 'org' },
			-- })
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

	----------------------------
	---compiling/running code---
	----------------------------

	{ "michaelb/sniprun", build = "bash ./install.sh", cmd = "SnipRun" },
	{
		"milanglacier/yarepl.nvim",
		cmd = "REPLStart",
		config = true,
	}, -- data science use case
	{
		"GCBallesteros/NotebookNavigator.nvim",
		keys = {
			{
				"]h",
				function()
					require("notebook-navigator").move_cell("d")
				end,
			},
			{
				"[h",
				function()
					require("notebook-navigator").move_cell("u")
				end,
			},
			{ "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
			{ "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
		},
		dependencies = {
			-- "echasnovski/mini.comment",
			"hkupty/iron.nvim", -- repl provider
			-- "akinsho/toggleterm.nvim", -- alternative repl provider
			-- "benlubas/molten-nvim", -- alternative repl provider
			"anuvyklack/hydra.nvim",
		},
		event = "VeryLazy",
		config = function()
			local nn = require("notebook-navigator")
			nn.setup({ activate_hydra_keys = "<leader>h", repl_provider = "iron" })
		end,
	},
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
		cmd = { "TSContextEnable", "TSContextToggle" },
	},
	{
		"tamton-aquib/staline.nvim",
		config = function()
			require("staline").setup({
				sections = {
					-- left = { "  ", "mode", " ", "branch", " ", "lsp" },
					mid = { "lsp", require("doing").status },
				},
				-- defaults = {
				-- 	true_colors = true,
				-- },
			})
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

	------------------
	----Efficiency----
	------------------

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
		"Wansmer/treesj",
		keys = {
			{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},

	{
		"folke/flash.nvim",
		-- event = "VeryLazy",
		vscode = true,
		---@type Flash.Config
		opts = {},
  -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
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
		"nvim-focus/focus.nvim",
		version = false,
		events = "VeryLazy",
		config = function()
			require("focus").setup()
		end,
	},
	{
		"aaronik/treewalker.nvim",

		-- The following options are the defaults.
		-- Treewalker aims for sane defaults, so these are each individually optional,
		-- and setup() does not need to be called, so the whole opts block is optional as well.
		opts = {
			-- Whether to briefly highlight the node after jumping to it
			highlight = true,

			-- How long should above highlight last (in ms)
			highlight_duration = 250,

			-- The color of the above highlight. Must be a valid vim highlight group.
			-- (see :h highlight-group for options)
			highlight_group = "CursorLine",
		},
		config = function()
			-- TODO: Hacer que los keymaps funcionen con hydra
			-- movement
			vim.keymap.set({ "n", "v" }, "<M-k>", "<cmd>Treewalker Up<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<M-j>", "<cmd>Treewalker Down<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<M-l>", "<cmd>Treewalker Right<cr>", { silent = true })
			vim.keymap.set({ "n", "v" }, "<M-h>", "<cmd>Treewalker Left<cr>", { silent = true })

			-- swapping
			vim.keymap.set("n", "<M-S-j>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
			vim.keymap.set("n", "<M-S-k>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
			vim.keymap.set("n", "<M-S-l>", "<cmd>Treewalker SwapRight<CR>", { silent = true })
			vim.keymap.set("n", "<M-S-h>", "<cmd>Treewalker SwapLeft<CR>", { silent = true })
		end,
	},

	--------------
	----Others----
	--------------
	-- { "nvim-lua/plenary.nvim", lazy = true },
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
	{ -- Create scratch buffer
		"LintaoAmons/scratch.nvim",
		cmd = "Scratch",
		-- event = "VeryLazy",
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			bufdelete = { enabled = true }, -- idk how it improves <leader>bd keybinding
			gitbrowse = { enabled = true },
			-- input = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scroll = { enabled = true },
			-- statuscolumn = { enabled = true },
			words = { enabled = true }, -- highlights variables
		},
    -- stylua: ignore
    keys = {
      { "<leader>nh",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    -- Check lua use case in repo docs, same thing could be done with more languages
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
	  },
	},

	{ -- Don't forget what I'm doing
		"Hashino/doing.nvim",
		event = "VeryLazy",
		cmd = "Do",
		-- keys = {
		--   { "<leader>da", function() require("doing").add() end, {}, },
		--   { "<leader>dn", function() require("doing").done() end, {}, },
		--   { "<leader>de", function() require("doing").edit() end, {}, },
		-- },
	},
}
