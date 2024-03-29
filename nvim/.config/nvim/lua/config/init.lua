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
	"jose-elias-alvarez/null-ls.nvim",
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
	{ "glepnir/lspsaga.nvim" },
	"ray-x/lsp_signature.nvim",
	{ "simrat39/symbols-outline.nvim" },
	{ "j-hui/fidget.nvim", version = "legacy" },

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
	-- "vim-test/vim-test",
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

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "kyazdani42/nvim-web-devicons",
	},
	"kyazdani42/nvim-tree.lua",
	"numToStr/Comment.nvim",
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
	"goerz/jupytext.vim",
	{
		"kiyoon/jupynium.nvim",
		build = "pip3 install --user .",
		-- build = "conda run --no-capture-output -n jupynium pip install .",
		-- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
	},

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
		"jcdickinson/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
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
	{ "xiyaowong/nvim-transparent", lazy = false },
	"lukas-reineke/indent-blankline.nvim",
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	"HiPhish/nvim-ts-rainbow2",
	"norcalli/nvim-colorizer.lua",
	-- {
	-- 	"HampusHauffman/block.nvim",
	-- 	config = function()
	-- 		require("block").setup({})
	-- 	end,
	-- },

	----typing----
	"windwp/nvim-autopairs",
	"kylechui/nvim-surround",
	"machakann/vim-sandwich",
	"windwp/nvim-ts-autotag",
	"mattn/emmet-vim",
	"godlygeek/tabular",

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
		"folke/neodev.nvim",
		opts = {},
		config = function()
			require("neodev").setup({})
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	{ "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
})

--Requires
require("config.plugins.treesitter")
require("config.plugins.cmp")
require("config.plugins.mason") -- must be always before require('plugins.lspconfig')
require("config.plugins.luasnip")
require("config.plugins.lspconfig")
require("config.plugins.trouble")
require("config.plugins.null-ls")
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
-- require("config.plugins.noice")

require("nvim-surround").setup()
require("todo-comments").setup()
require("notify").setup({
	stages = "slide",
	background_colour = "#000000",
})
require("fidget").setup({
	window = {
		blend = 0,
	},
})

--Mappings
require("config.mappings")
