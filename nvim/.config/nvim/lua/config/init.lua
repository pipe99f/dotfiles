require('packer').startup(function()

  use 'wbthomason/packer.nvim'
  use 'mattn/emmet-vim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}


--Snippets
  use 'L3MON4D3/LuaSnip'
--vscode-like
  use 'rafamadriz/friendly-snippets'
--snipmate-like (el plugin de snipmate no incluye ningún snippet)
  use 'honza/vim-snippets'


--LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use { "williamboman/mason.nvim" }
  use 'folke/trouble.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
--Plug 'glepnir/lspsaga.nvim' Unmaintained
  use 'tami5/lspsaga.nvim'
  use 'CosmicNvim/cosmic-ui'
  use 'ray-x/lsp_signature.nvim'


--Debugger
  use 'mfussenegger/nvim-dap'


--cmp
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'kdheepak/cmp-latex-symbols'
  use 'lukas-reineke/cmp-rg'


--telescope
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
--  use 'tami5/sqlite.lua'
--  use 'nvim-telescope/telescope-frecency.nvim'

  use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use 'kyazdani42/nvim-tree.lua'
  use 'numToStr/Comment.nvim'
  use {
      "numtostr/Fterm.nvim",
      config = function()
          require('fterm').setup()
      end
  }
--  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
--  Plug 'junegunn/fzf.vim'
  use 'ThePrimeagen/vim-be-good'


----MODES----
--Git
  use 'tpope/vim-fugitive'
  use 'https://github.com/mattn/vim-gist'
  use 'lewis6991/gitsigns.nvim'

--Markdown---
  use 'godlygeek/tabular'
  use 'preservim/vim-markdown'
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
})

--Web


--Python
  use 'jupyter-vim/jupyter-vim'

--R
  use 'jalvesaq/Nvim-R'

--latex
  use 'lervag/vimtex'

--tessst
  use 'vim-test/vim-test'


----theme----
  use 'arcticicestudio/nord-vim'
  use 'rakr/vim-one'
  use 'xiyaowong/nvim-transparent'

----appearance details----
  use 'ryanoasis/vim-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'goolord/alpha-nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use {
      "karb94/neoscroll.nvim",
      config = function()
          require('neoscroll').setup()
      end
  }
  use 'p00f/nvim-ts-rainbow'
  use 'MunifTanjim/nui.nvim'

----typing----
  use 'windwp/nvim-autopairs'
  use 'kylechui/nvim-surround'
  use 'machakann/vim-sandwich'
  use "windwp/nvim-ts-autotag"

--  use 'mg979/vim-visual-multi'
  use 'norcalli/nvim-colorizer.lua'

----Others----
  use "ahmedkhalf/project.nvim"
  use {
      "lewis6991/spellsitter.nvim",
      config = function()
          require('spellsitter').setup()
      end
  }

  use 'lewis6991/impatient.nvim'
  use {
      "rcarriga/nvim-notify",
      config = function()
          require('notify').setup()
      end
  }

end)



require('config.plugins.treesitter')
require('config.plugins.cmp')
require('config.plugins.mason') -- must be always before require('plugins.lspconfig')
require('config.plugins.luasnip')
require('config.plugins.lspconfig')
require('config.plugins.trouble')
require('config.plugins.null-ls')
require('config.plugins.lspsaga')
require('config.plugins.nvim-tree')
require('config.plugins.lualine')
require('config.plugins.alpha')
require('config.plugins.colorizer')
require('config.plugins.nvim-transparent')
require('config.plugins.blankline')
require('config.plugins.bufferline')
require('config.plugins.gitsigns')
require('config.plugins.comment')
require('config.plugins.autopairs')
require('config.plugins.project')
require('config.plugins.nvimr')
require('config.plugins.lsp_signature')


require('nvim-surround').setup()  -- por algún motivo el plugin no funcionaba si invocaba desde "use"


--Mappings
require('config.mappings')
