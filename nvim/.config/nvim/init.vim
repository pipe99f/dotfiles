"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors

lua require('impatient')
lua require('init')

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

"copypath
" copy result to the system clipboard and echo the result
    " the cb> prompt means the clipboard
    " *f*ile *n*ame, ex. init.vim
    map <Leader>fn :let @+ = expand("%:t") \| echo 'File name copied: ' . @+<CR>
    " *f*ile *p*ath, ex. /home/user/nvim/init.vim
    map <Leader>fp :let @+ = expand("%:p") \| echo 'File path copied: ' . @+<CR>
    " *d*irectory *p*ath, ex. /home/user/nvim
    map <Leader>dp :let @+ = expand("%:p:h") \| echo 'Directory path copied: ' . @+<CR>
    " *d*irectory *n*ame, ex. nvim
    map <Leader>dn :let @+ = expand("%:p:h:t") \| echo 'Directory name copied: ' . @+<CR>


" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
autocmd TermOpen * startinsert

"py code
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python nnoremap <buffer> <F8> :w <CR> :bo :8sp <CR> :term python % <CR>

"lua code
autocmd FileType lua nnoremap <buffer> <F8>:w <CR> :bo :8sp <CR> :term lua % <CR>

"""""VIM UI

" Add numbers to each line on the left-hand side.
set number
set relativenumber

" Highlight cursor line underneath the cursor horizontally.
set cursorline

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
colorscheme one
highlight CursorLine cterm=NONE ctermbg=243
autocmd InsertEnter * highlight CursorLine cterm=NONE ctermbg=243
autocmd InsertLeave * highlight CursorLine cterm=NONE ctermbg=243

" Enable syntax highlighting
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


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

"object window position and size
" let R_objbr_place = 'RIGHT'
let R_objbr_w = 30

"terminal window position and size
let R_rconsole_width = 0
let R_rconsole_height = 12


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

"normal mode in terminal with ESC
tnoremap <Esc> <C-\><C-n>

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

let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => Markdown
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:mkdp_browser = 'brave'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " => NvimTree
 """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>n :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>


