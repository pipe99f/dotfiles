vim.opt.termguicolors = true -- must run before colorizer

require('impatient') --must run before any plugin
require('config')


local cmd = vim.cmd --most part taken from CosmicNvim
local opt = vim.opt
local g = vim.g
local indent = 2

cmd([[
      filetype on
      filetype plugin on
      filetype indent on
]])

-- misc
opt.backspace = { 'eol', 'start', 'indent' }
opt.clipboard = 'unnamedplus'
opt.encoding = 'utf-8'
opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }
opt.syntax = 'enable'
opt.history = 500

-- indention
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = indent
opt.smartindent = true
opt.softtabstop = indent
opt.tabstop = indent

-- search
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.wildignore = opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*' }
opt.wildmenu = true

-- ui
vim.cmd('colorscheme one')
vim.opt.laststatus = 3 -- use global statusline
opt.cursorline = true
opt.laststatus = 2
opt.lazyredraw = true
opt.list = true
opt.listchars = {
  extends = '»',
  precedes = '«',
  nbsp = '×',
}
opt.mouse = 'a'
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true

opt.scrolloff = 9
opt.showmode = false
opt.sidescrolloff = 3 -- Lines to scroll horizontally
opt.signcolumn = 'yes'
opt.splitbelow = true -- Open new split below
opt.splitright = true -- Open new split to the right
opt.hidden = true
opt.linebreak = true
opt.textwidth = 200
opt.wrap = true


-- backups
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- autocomplete
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.shortmess = opt.shortmess + { c = true }

-- perfomance
opt.redrawtime = 1500
opt.timeoutlen = 400
opt.ttimeoutlen = 10
opt.updatetime = 200

--plugins
cmd([[

let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode=0

let g:mkdp_browser = 'chromium' 

]])

