return {

	-----------
	----LSP----
	-----------

	{
		"rachartier/tiny-code-action.nvim",
		-- event = "LspAttach",
		opts = {},
		keys = { { "<leader>ca", '<cmd> lua require("tiny-code-action").code_action()<cr>' } },
	},
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		-- event = "VeryLazy",
		-- priority = 1000,
		keys = {
			{ "<leader>e", "<cmd>TinyInlineDiag enable<cr>" },
		},
		config = function()
			require("tiny-inline-diagnostic").setup({
				options = {
					multilines = {
						enabled = true,
					},
					show_source = {
						enabled = true,
					},
				},
			})
			vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
		end,
	},
	{
		"hedyhli/outline.nvim",
		keys = { { "<M-o>", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
		cmd = "Outline",
		opts = {},
	},
	{
		"Bekaboo/dropbar.nvim",
		-- optional, but required for fuzzy finder support
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		config = function()
			local dropbar_api = require("dropbar.api")
			vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
			vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
			vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
		end,
	},

	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },

	-------------
	----MODES----
	-------------
	-- CSV
	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			parser = { comments = { "#", "//" } },
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},

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
			-- "sindrets/diffview.nvim", -- optional - unmaintained
			-- "esmuellert/codediff.nvim", -- optional
		},
		cmd = { "Neogit" },
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		},
		config = true,
	},
	{
		"esmuellert/codediff.nvim",
		cmd = "CodeDiff",
	},
	{
		"HarshK97/diffmantic.nvim", -- Semantic diff
		config = function()
			require("diffmantic").setup()
		end,
		cmd = { "Diffmantic" },
	},
	{
		"barrettruth/diffs.nvim", -- May conflict with codediff.nvim
		init = function() -- Highlights neogit when tabbing
			vim.g.diffs = {
				integrations = {
					neogit = true,
					gitsigns = true,
					-- neojj = true,
					-- fugitive = true,
				},
			}
		end,
		ft = { "NeogitStatus" },
		cmd = { "Gdiff", "Greview" },
	},
	{
		"pwntester/octo.nvim", -- Issues and PR's
		cmd = "Octo",
		opts = {
			picker = "telescope",
			enable_builtin = true,
			default_merge_method = "squash",
			-- default_to_projects_v2 = true,
		},
		keys = {
			{
				"<leader>oi",
				"<CMD>Octo issue list<CR>",
				desc = "List GitHub Issues",
			},
			{
				"<leader>op",
				"<CMD>Octo pr list<CR>",
				desc = "List GitHub PullRequests",
			},
			{
				"<leader>od",
				"<CMD>Octo discussion list<CR>",
				desc = "List GitHub Discussions",
			},
			{
				"<leader>on",
				"<CMD>Octo notification list<CR>",
				desc = "List GitHub Notifications",
			},
			{
				"<leader>os",
				function()
					require("octo.utils").create_base_search_command({ include_current_repo = true })
				end,
				desc = "Search GitHub",
			},
		},
	},
	{
		"oribarilan/lensline.nvim",
		tag = "2.0.0", -- or: branch = 'release/2.x' for latest non-breaking updates
		-- event = "LspAttach",
		cmd = "LenslineToggleView",
		config = function()
			require("lensline").setup()
		end,
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
		-- build = "pip3 install --user .",
		cmd = "JupyniumStartAndAttachToServer",
		build = "conda run --no-capture-output -n ds pip install .",
		-- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
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

	-- HTML
	{
		"brianhuster/live-preview.nvim",
		ft = { "markdown", "rmd", "pandoc.markdown" },
	},

	-- Org mode
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

	-- HTTP / REST files
	{
		"mistweaverco/kulala.nvim",
		keys = {
			{ "<leader>ks", desc = "Send request" },
			{ "<leader>ka", desc = "Send all requests" },
			{ "<leader>kb", desc = "Open scratchpad" },
		},
		ft = { "http", "rest" },
		dependencies = {},
		opts = {
			-- your configuration comes here
			global_keymaps = true,
			global_keymaps_prefix = "<leader>k",
			kulala_keymaps_prefix = "",
			kulala_keymaps = {
				["Show verbose"] = {
					"<leader>kv",
					function()
						require("kulala.ui").show_verbose()
					end,
				},
			},
		},
	},

	-- SQL
	-- { "pope/vim-dadbod" },
	-- { "kristijanhusak/vim-dadbod-ui" },
	-- { "kristijanhusak/vim-dadbod-completion" },
	{
		"kndndrj/nvim-dbee",
		ft = "sql",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		build = function()
			-- Install tries to automatically detect the install method.
			-- if it fails, try calling it with one of these parameters:
			--    "curl", "wget", "bitsadmin", "go"
			require("dbee").install()
		end,
		config = function()
			require("dbee").setup(--[[optional config]])
		end,
	},
	{
		"MattiasMTS/cmp-dbee",
		dependencies = {
			{ "kndndrj/nvim-dbee" },
		},
		ft = "sql", -- optional but good to have
		opts = {}, -- needed
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
	-- {
	-- 	"stevearc/quicker.nvim",
	-- 	event = "FileType qf",
	-- 	---@module "quicker"
	-- 	---@type quicker.SetupOptions
	-- 	opts = {},
	-- },

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
		"milanglacier/yarepl.nvim", -- data science use case
		cmd = "REPLStart",
		config = true,
	},
	{
		"GCBallesteros/NotebookNavigator.nvim",
		ft = "python",
		dependencies = {
			-- "echasnovski/mini.comment",
			-- "hkupty/iron.nvim", -- repl provider
			-- "akinsho/toggleterm.nvim", -- alternative repl provider
			-- "benlubas/molten-nvim", -- alternative repl provider
			{ "nvimtools/hydra.nvim", event = "VeryLazy" },
		},
		config = function()
			local nn = require("notebook-navigator")
			nn.setup({
				cell_markers = {
					-- python = "# %%",
				},
				repl_provider = "molten",
			})
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
	{
		"nvim-treesitter/nvim-treesitter-context",
		cmd = { "TSContext enable", "TSContext toggle" },
	},
	{
		"tamton-aquib/staline.nvim", -- status line
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
		"norcalli/nvim-colorizer.lua", -- hex code colorizer
		event = "VeryLazy",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"nmac427/guess-indent.nvim", -- adjust indent following current buffer style
		event = "VeryLazy",
		config = function()
			require("guess-indent").setup({
				filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
					"lua",
				},
			})
		end,
	},

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
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				-- vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
				-- 	underline = true,
				-- 	virtual_text = {
				-- 		spacing = 5,
				-- 		severity_limit = "Warning",
				-- 	},
				-- 	update_in_insert = true,
				-- })
				vim.diagnostic.config({
					underline = true,
					virtual_text = {
						spacing = 5,
						-- In the new API, 'severity_limit' is replaced by 'severity'
						-- This shows Warnings, Errors, and anything "above" Info
						severity = { min = vim.diagnostic.severity.WARN },
					},
					update_in_insert = true,
				})
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
		"danymat/neogen", -- Fast annotions using treesitter
		keys = {
			{
				"gcn",
				function()
					require("neogen").generate()
				end,
				desc = "Neogen annotation",
			},
		},
		cmd = "Neogen",
		config = true,
	},

	{
		"nvim-focus/focus.nvim", -- Auto resize splits
		version = false,
		events = "VeryLazy",
		cmd = "FocusToggle",
		config = function()
			require("focus").setup()
		end,
	},
	{
		"nvimtools/hydra.nvim",
		event = "VeryLazy",
		config = function() end,
	},
	{
		"aaronik/treewalker.nvim", -- Move fast between treesitter nodes
		event = "BufEnter",

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
			vim.keymap.set("n", "<M-J>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
			vim.keymap.set("n", "<M-K>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
			vim.keymap.set("n", "<M-L>", "<cmd>Treewalker SwapRight<CR>", { silent = true })
			vim.keymap.set("n", "<M-H>", "<cmd>Treewalker SwapLeft<CR>", { silent = true })
		end,
	},
	{
		"MagicDuck/grug-far.nvim", -- Find and replace
		cmd = "GrugFar",
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
		config = function()
			require("grug-far").setup({
				-- engine = 'ripgrep' is default, but 'astgrep' can be specified
			})
		end,
	},

	--------------
	----Others----
	--------------
	-- { "nvim-lua/plenary.nvim", lazy = true },
	-- { "Vimjas/vim-python-pep8-indent" },
	{
		"alex-popov-tech/store.nvim",
		-- dependencies = { "OXY2DEV/markview.nvim" },
		opts = {},
		cmd = "Store",
	},
	{ -- For loadig very large files
		"minigian/juan-logs.nvim",
		build = function(plugin)
			local path = plugin.dir .. "/build.lua"
			if vim.fn.filereadable(path) == 1 then
				dofile(path)
			end
		end,
		-- You can use `build = "cargo build --release"` if you have `cargo` in your system
		config = function()
			require("juanlog").setup({
				threshold_size = 1024 * 1024 * 100, -- 100MB trigger
				mode = "dynamic", -- I don't remember the other mode name, but it's useless so don't worry
				lazy = true, -- background indexing. prevents neovim from freezing
				dynamic_chunk_size = 10000, -- lines to load at once
				dynamic_margin = 2000, -- trigger scroll load when this close to the edge
				patterns = { "*.log", "*.txt", "*.csv", "*.json" },
				enable_custom_statuscol = true, -- fakes absolute line numbers
				syntax = false, -- set to true to enable native vim syntax (can be slow)
			})
		end,
	},
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
		},
		-- ft = "python", -- Load when opening Python files
		keys = {
			{ "<space>v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
		},
		opts = { -- this can be an empty lua table - just showing below for clarity.
			search = {}, -- if you add your own searches, they go here.
			options = {}, -- if you add plugin options, they go here.
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
	{
		"gbprod/yanky.nvim",
		event = "BufEnter",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	-- Unmaintained and using a deprecated function
	-- {
	-- 	"ahmedkhalf/project.nvim",
	-- 	opts = {
	-- 		-- manual_mode = true,
	-- 	},
	-- 	event = "VeryLazy",
	-- 	config = function(_, opts)
	-- 		require("project_nvim").setup(opts)
	-- 	end,
	-- },
	{
		"DrKJeff16/project.nvim",
		event = "VeryLazy",
		opts = {
			-- manual_mode = false,
		},
		-- config = function()
		-- 	require("project").setup()
		-- end,
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			session_lens = {
				load_on_setup = false,
			},
		},
	},

	{
		"wurli/contextindent.nvim",
		-- This is the only config option; you can use it to restrict the files
		-- which this plugin will affect (see :help autocommand-pattern).
		ft = { "markdown", "pandoc.markdown", "quarto", "org", "html" },
		opts = { pattern = "*" },
		-- dependencies = { "nvim-treesitter/nvim-treesitter" },
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
			image = {
				enabled = true,
				doc = {
					enabled = true,
					inline = false,
					-- max_width = 100,
					-- max_height = 100,
				},
			},
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
