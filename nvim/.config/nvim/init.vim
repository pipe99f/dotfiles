call plug#begin('~/.local/share/nvim/plugged')
"code completion and check
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mattn/emmet-vim'
"Plug 'dense-analysis/ale'
" Plug 'sheerun/vim-polyglot'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    
"Snippets
Plug 'L3MON4D3/LuaSnip'
"vscode-like
Plug 'rafamadriz/friendly-snippets'
"snipmate-like (el plugin de snipmate no incluye ningún snippet)
Plug 'honza/vim-snippets'

"LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'folke/trouble.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
" Plug 'glepnir/lspsaga.nvim' Unmaintained
Plug 'tami5/lspsaga.nvim'


"Debugger
Plug 'mfussenegger/nvim-dap'


"cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'kdheepak/cmp-latex-symbols'




"telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'


Plug 'preservim/nerdcommenter'
Plug 'https://github.com/preservim/nerdtree'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'ThePrimeagen/vim-be-good'

""""""""""Modes""
"Git
Plug 'tpope/vim-fugitive'
Plug 'https://github.com/mattn/vim-gist'

""Markdown   
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"Python
Plug 'jupyter-vim/jupyter-vim'

"R
Plug 'jalvesaq/Nvim-R'

"latex
Plug 'lervag/vimtex'


"tessst
Plug 'vim-test/vim-test'


"theme
Plug 'dracula/vim', { 'as': 'draculaOfficial' }
"Plug 'flazz/vim-colorschemes'
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'

"appearance details
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'kyazdani42/nvim-web-devicons'

"typing
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'alvan/vim-closetag'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'norcalli/nvim-colorizer.lua'



"Visuals
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'sbdchd/neoformat'




call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('init')
" nnoremap <silent>K :Lspsaga hover_doc<CR>
" nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>
" Sets how many lines of history VIM has to remember
set history=503



" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


"py code
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

"VIM UI

" Add numbers to each line on the left-hand side.
set number
set relativenumber

" Highlight cursor line underneath the cursor horizontally.
set cursorline
"hi CursorLine cterm=NONE ctermbg=237

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid
set hidden
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
"set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"enable indent guides plugins
let g:indentLine_char = "▏"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)

"background transparent

"highlight Normal ctermbg=none
"highlight NonText ctermbg=none

set termguicolors
colorscheme one
"hi clear CursorLine
highlight CursorLine cterm=NONE ctermbg=243
autocmd InsertEnter * highlight CursorLine cterm=NONE ctermbg=243
autocmd InsertLeave * highlight CursorLine cterm=NONE ctermbg=243



" Enable syntax highlighting
syntax enable


" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Lightline plugin theme
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => Treesitter
 " """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => NERDCommenter
 " """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => R
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"activar R (\rf) cada vez que empiezo a editar un archivo de R
let R_auto_start = 2

"open object browser in start
let R_objbr_auto_start = 1

" R output is highlighted with current colorscheme
let g:rout_follow_colorscheme = 1

" R commands in R output are highlighted
let g:Rout_more_colors = 1

 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => Remap
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"moverse entre ventanas con ctrl + vim keys
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

"open NERDTRE
nnoremap <leader>n :NERDTreeFocus<CR>


"insert mode in terminal with ESC
tnoremap <Esc> <C-,><C-n>

"go to the next Ale syntax/lint error
nmap <silent> <leader>a <Plug>(ale_next_wrap)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => Telescope
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => Latex and vimtex
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:coc_filetype_map = {'tex': 'latex'}
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => Markdown
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:mkdp_browser = 'librewolf'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => COC
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:coc_global_extensions = ['coc-json', 'coc-go', 'coc-prettier', 'coc-pyright', 'coc-sh', 'coc-snippets', 'coc-sql', 'coc-css', 'coc-html', 'coc-r-lsp', 'coc-texlab', 'coc-ltex']

set nobackup
set nowritebackup


" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


