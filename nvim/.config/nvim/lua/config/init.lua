local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	--Snippets
	"L3MON4D3/LuaSnip",
	--vscode-like
	"rafamadriz/friendly-snippets",
	--snipmate-like (el plugin de snipmate no incluye ningún snippet)
	"honza/vim-snippets",
	"evesdropper/luasnip-latex-snippets.nvim",

	--LSP
	"neovim/nvim-lspconfig",
	{ "scalameta/nvim-metals", dependencies = { "nvim-lua/plenary.nvim" } },
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jay-babu/mason-nvim-dap.nvim",
	{ "folke/trouble.nvim" },
	-- "nvimtools/none-ls.nvim",
	"mfussenegger/nvim-lint",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	{ "glepnir/lspsaga.nvim" },
	"ray-x/lsp_signature.nvim",
	{ "simrat39/symbols-outline.nvim" },
	{
		"j-hui/fidget.nvim",
		version = "legacy",
		config = function()
			require("fidget").setup({
				window = {
					blend = 0,
				},
			})
		end,
	},

	--Formatter
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {},
	},

	--Debugging
	"mfussenegger/nvim-dap",
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
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
			-- require("core.utils").load_mappings("dap_python")
		end,
	},
	"nvim-neotest/neotest",

	--cmp
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"onsails/lspkind.nvim",
	"saadparwaiz1/cmp_luasnip",
	"kdheepak/cmp-latex-symbols",
	"lukas-reineke/cmp-rg", --sugiere mucha basura
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

	--telescope
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	{ "nvim-telescope/telescope-frecency.nvim", dependencies = { "tami5/sqlite.lua" } },
	{
		"rmagatti/session-lens",
		config = function()
			require("session-lens").setup({ --[[your custom config--]]
			})
		end,
	},
	--comments
	"numToStr/Comment.nvim",
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup()
		end,
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
	},

	"kyazdani42/nvim-tree.lua",
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	"ThePrimeagen/vim-be-good",

	----MODES----
	--Docker
	-- ("dgrbrady/nvim-docker"),

	--Git
	"https://github.com/mattn/vim-gist",
	"lewis6991/gitsigns.nvim",

	--Quarto
	{
		"quarto-dev/quarto-nvim",
		dev = false,
		ft = { "quarto", "markdown" },
		dependencies = {
			{ "hrsh7th/nvim-cmp" },
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
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
		end,
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
	},

	{
		"willothy/wezterm.nvim",
		config = true,
	},

	{ "benlubas/image-save.nvim", cmd = "SaveImage" },

	--Latex
	"lervag/vimtex",

	--Markdown
	"preservim/vim-markdown",
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown", "rmd", "pandoc.markdown" },
		cmd = { "MarkdownPreview" },
	},
	{ "ekickx/clipboard-image.nvim" },

	--R
	"jalvesaq/Nvim-R",

	--AI--
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({
				enable_chat = true,
			})
		end,
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

	---------------------------
	---building/running code---
	---------------------------

	-- "jupyter-vim/jupyter-vim",
	"hkupty/iron.nvim",
	{ "michaelb/sniprun", build = "bash ./install.sh" },
	{ "CRAG666/code_runner.nvim", dependencies = "nvim-lua/plenary.nvim" }, -- Idk if this is useful, I think I can do the same thing with autocommands.,
	{ "milanglacier/yarepl.nvim", config = true },
	{
		"stevearc/overseer.nvim",
		opts = {
			-- Tasks are disposed 5 minutes after running to free resources.
			-- If you need to close a task inmediatelly:
			-- press ENTER in the menu you see after compiling on the task you want to close.
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
				bindings = {
					["q"] = function()
						vim.cmd("OverseerClose")
					end,
				},
			},
		},
		dependencies = "stevearc/dressing.nvim",
		config = function()
			require("overseer").setup()
		end,
	},

	{
		"Zeioth/compiler.nvim",
		cmd = { "CompilerOpen", "CompilerToggleResults" },
		dependencies = { "stevearc/overseer.nvim" },
		config = function(_, opts)
			require("compiler").setup(opts)
		end,
	},

	---Color schemes---
	-- "arcticicestudio/nord-vim",
	"rakr/vim-one",
	"shaunsingh/nord.nvim",
	"nyoom-engineering/oxocarbon.nvim",
	"rebelot/kanagawa.nvim",
	"tiagovla/tokyodark.nvim",
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ "dasupradyumna/midnight.nvim", lazy = false, priority = 1000 },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},

	----appearance details----
	{ "folke/noice.nvim", dependencies = "MunifTanjim/nui.nvim" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-lualine/lualine.nvim",
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "kyazdani42/nvim-web-devicons",
	},
	{ "xiyaowong/nvim-transparent", lazy = false },
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{ "HiPhish/rainbow-delimiters.nvim" },
	"norcalli/nvim-colorizer.lua",
	-- {
	-- 	"HampusHauffman/block.nvim",
	-- 	config = function()
	-- 		require("block").setup({})
	-- 	end,
	-- },

	----typing----
	"windwp/nvim-autopairs",
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	"machakann/vim-sandwich",
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	"mattn/emmet-vim",
	"godlygeek/tabular",
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {},
	},

	--   'mg979/vim-visual-multi',

	----Others----
	"ahmedkhalf/project.nvim",
	"goolord/alpha-nvim",
	{
		"lewis6991/spellsitter.nvim",
		config = function()
			require("spellsitter").setup()
		end,
	},
	"lewis6991/impatient.nvim",
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				stages = "slide",
				background_colour = "#000000",
			})
		end,
	},
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_enable_last_session = false,
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},
	{
		"bennypowers/nvim-regexplainer",
		config = function()
			require("regexplainer").setup()
		end,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings(true)
		end,
	},
	{
		"ggandor/flit.nvim",
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
	{
		"nvim-pack/nvim-spectre",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1001, -- this plugin needs to run before anything else
		opts = {
			rocks = { "magick" },
		},
	},
	{
		"folke/neodev.nvim",
		opts = {},
		config = function()
			require("neodev").setup({})
		end,
	},
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
	{
		"nvimtools/hydra.nvim",
	},
})

--Requires
require("config.plugins.treesitter")
require("config.plugins.cmp")
require("config.plugins.mason") -- must be always before require('plugins.lspconfig')
require("config.plugins.luasnip")
require("config.plugins.lspconfig")
require("config.plugins.trouble")
require("config.plugins.nvim-lint")
require("config.plugins.lspsaga")
require("config.plugins.nvim-tree")
require("config.plugins.lualine")
require("config.plugins.alpha")
require("config.plugins.colorizer")
require("config.plugins.nvim-transparent")
require("config.plugins.blankline")
require("config.plugins.bufferline")
require("config.plugins.gitsigns")
require("config.plugins.comment")
require("config.plugins.autopairs")
require("config.plugins.project")
require("config.plugins.nvimr")
require("config.plugins.lsp_signature")
require("config.plugins.telescope")
require("config.plugins.symbolsoutline")
require("config.plugins.ufo")
require("config.plugins.iron")
require("config.plugins.coderunner")
require("config.plugins.vimtex")
require("config.plugins.toggleterm")
require("config.plugins.metals")
require("config.plugins.molten")
require("config.plugins.hydra")
require("config.plugins.conform")
-- require("config.plugins.noice")

--Mappings
require("config.mappings")
