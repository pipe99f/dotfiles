require('packer').startup(function()

-- Packer can manage itself
  use 'wbthomason/packer.nvim'
--code completion and check
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
  use 'folke/trouble.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'
--Plug 'glepnir/lspsaga.nvim' Unmaintained
  use 'tami5/lspsaga.nvim'


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
      "numToStr/FTerm.nvim",
      config = function()
          require('FTerm').setup()
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

--Python
  use 'jupyter-vim/jupyter-vim'

--R
  use 'jalvesaq/Nvim-R'

--latex
  use 'lervag/vimtex'

--tessst
  use 'vim-test/vim-test'


----theme----
--Plug 'flazz/vim-colorschemes'
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

----typing----
  use 'windwp/nvim-autopairs'
  use 'machakann/vim-sandwich'
  use 'alvan/vim-closetag'
--  use 'mg979/vim-visual-multi'
  use 'norcalli/nvim-colorizer.lua'

----Others----
  use "ahmedkhalf/project.nvim"
  use {
      'lewis6991/spellsitter.nvim',
      config = function()
        require('spellsitter').setup()
      end
  }
  use 'lewis6991/impatient.nvim'

end)



require('plugins.treesitter')
require('plugins.cmp')
require('plugins.lspinstaller') -- must be always before require('plugins.lspconfig')
require('plugins.luasnip')
require('plugins.lspconfig')
require('plugins.trouble')
require('plugins.null-ls')
require('plugins.lspsaga')
require('plugins.nvim-tree')
require('plugins.lualine')
require('plugins.alpha')
require('plugins.colorizer')
require('plugins.nvim-transparent')
require('plugins.blankline')
require('plugins.bufferline')
require('plugins.gitsigns')
require('plugins.comment')
require('plugins.autopairs')
require('plugins.project')

--UI
vim.opt.laststatus = 3 -- use global statusline

--Keybindins
-- FTerm
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

