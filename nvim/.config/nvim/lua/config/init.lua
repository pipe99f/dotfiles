require("packer").startup(function()
  use({ "wbthomason/packer.nvim" })

  --Snippets
  use({ "L3MON4D3/LuaSnip"})
  --vscode-like
  use({ "rafamadriz/friendly-snippets"})
  --snipmate-like (el plugin de snipmate no incluye ningún snippet)
  use("honza/vim-snippets")

  --LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")
  use({ "folke/trouble.nvim" })
  use("jose-elias-alvarez/null-ls.nvim")
  use({ "glepnir/lspsaga.nvim" })
  use("ray-x/lsp_signature.nvim")
  use({ "simrat39/symbols-outline.nvim" })
  use("j-hui/fidget.nvim")

  --Debugging
  use("mfussenegger/nvim-dap")
  use("vim-test/vim-test")

  --cmp
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/nvim-cmp")
  use("saadparwaiz1/cmp_luasnip")
  use("kdheepak/cmp-latex-symbols")
  use("lukas-reineke/cmp-rg")

  --telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")
  use({
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "tami5/sqlite.lua" },
  })
  use({
    "rmagatti/session-lens",
    config = function()
      require("session-lens").setup({ --[[your custom config--]]
      })
    end,
  })

  use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
  use("kyazdani42/nvim-tree.lua")
  use("numToStr/Comment.nvim")
  use({
    "numtostr/Fterm.nvim",
    config = function()
      require("fterm").setup()
    end,
  })
  use("ThePrimeagen/vim-be-good")

  ----MODES----
  --Docker
  -- use("dgrbrady/nvim-docker")

  --Git
  use("tpope/vim-fugitive")
  use("https://github.com/mattn/vim-gist")
  use("lewis6991/gitsigns.nvim")

  --Latex
  use("lervag/vimtex")

  --Markdown
  use("preservim/vim-markdown")
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown", "rmd", "pandoc.markdown" },
    cmd = { "MarkdownPreview" },
  })

  --R
  use("jalvesaq/Nvim-R")

  ---Running code---
  use("jupyter-vim/jupyter-vim")
  use("hkupty/iron.nvim")
  use({ "michaelb/sniprun", run = "bash ./install.sh" })
  use({ "CRAG666/code_runner.nvim" }) -- Idk if this is useful, I think I can do the same thing with autocommands.

  ---Color schemes---
  use("arcticicestudio/nord-vim")
  use("rakr/vim-one")
  use("folke/tokyonight.nvim")

  ----appearance details----
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("nvim-lualine/lualine.nvim")
  use("xiyaowong/nvim-transparent")
  use("lukas-reineke/indent-blankline.nvim")
  use({
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup()
    end,
  })
  use({ "p00f/nvim-ts-rainbow", event = { "CursorHold", "CursorHoldI" } })
  use("norcalli/nvim-colorizer.lua")

  ----typing----
  use("windwp/nvim-autopairs")
  use("kylechui/nvim-surround")
  use("machakann/vim-sandwich")
  use("windwp/nvim-ts-autotag")
  use("mattn/emmet-vim")
  use("godlygeek/tabular")

  --  use 'mg979/vim-visual-multi'

  ----Others----
  use("ahmedkhalf/project.nvim")
  use("goolord/alpha-nvim")
  use({
    "lewis6991/spellsitter.nvim",
    config = function()
      require("spellsitter").setup()
    end,
  })
  use("lewis6991/impatient.nvim")
  use({
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "slide",
        background_colour = "#000000",
      })
    end,
  })
  use({
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_enable_last_session = false,
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      })
    end,
  })
  use({
    "bennypowers/nvim-regexplainer",
    config = function()
      require("regexplainer").setup()
    end,
  })
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  })
  use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
end)

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

require("nvim-surround").setup() -- por algún motivo el plugin no funcionaba si invocaba desde "use"
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

require("auto-session").setup({
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
})

--Mappings
require("config.mappings")
