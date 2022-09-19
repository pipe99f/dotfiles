local map = vim.api.nvim_set_keymap
local opts = { noremap=true, silent=true }
local autocmd = vim.api.nvim_create_autocmd

-----------
--GENERAL--
-----------

vim.g.mapleader = " "

-- Quickfix mappings map('n', '<leader>ck', ':cexpr []<cr>', opts)
map('n', '<leader>cc', ':cclose <cr>', opts)
map('n', '<leader>co', ':copen <cr>', opts)
map('n', '<leader>cf', ':cfdo %s/', opts)
map('n', '<leader>cp', ':cprev<cr>zz', opts)
map('n', '<leader>cn', ':cnext<cr>zz', opts)

-- Copy path
vim.cmd('map <leader>fn :let @+ = expand("%:t") \\| echo "File name copied: " . @+<CR>')
vim.cmd('map <leader>fp :let @+ = expand("%:p") \\| echo "File path copied: " . @+<CR>')

--Ctrl+Backspace deletes word
map('i', '<C-bs>', '<C-w>', { silent = true })

--fast saving
map('n', '<leader>w', ':w!<CR>', {silent = false})
map('n', '<leader>W', ':wa!<CR>', {silent = false})

-- Quit neovim
map('n', '<C-Q>', ':qa<CR>', opts)

-- resize windows
map('n', '<C-Up>', ':resize -2<CR>', opts)
map('n', '<C-Down>', ':resize +2<CR>', opts)
map('n', '<C-Left>', ':vertical resize -2<CR>', opts)
map('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- move between windows
map('n', '<C-k>', '<C-W>k', {silent = true})
map('n', '<C-j>', '<C-W>j', {silent = true})
map('n', '<C-l>', '<C-W>l', {silent = true})
map('n', '<C-h>', '<C-W>h', {silent = true})

--create split window
map('n', '<leader>vs', ':vsplit<CR>', {silent = false})
map('n', '<leader>ss', ':split<CR>', {silent = false})

--normal mode in terminal
map('t', '<Esc>', '<C-\\><C-n>', {silent = false})

--running code
-- autocmd('FileType', {pattern = 'python',  })

-- vim.api.nvim_create_augroup('runcode', {clear = true})
vim.cmd([[
  augroup runcode
  autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
  autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
  autocmd FileType python nnoremap <buffer> <leader>rr :w <CR> :bo :8sp <CR> :term python "%:p" <CR>

  autocmd FileType sh nnoremap <buffer> <leader>rr :w <CR> :bo :8sp <CR> :term  bash "%:p" <CR>
  autocmd FileType zsh nnoremap <buffer> <leader>rr :w <CR> :bo :8sp <CR> :term  bash "%:p" <CR>

  autocmd FileType javascript nnoremap <buffer> <leader>rr :w <CR> :bo :8sp <CR> :term  node "%:p" <CR>

  autocmd FileType lua nnoremap <buffer> <F8>:w <leader>rr :bo :8sp <CR> :term lua "%:p" <CR>
  augroup END
]])

-----------
--PLUGINS--
-----------

--Code runner
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })

--Iron
map('n', '<leader>ti', '<cmd>IronRepl<CR>', opts) -- toggle iron REPL

-- FTerm
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

--NvimTree
map('n', '<leader>n', ':NvimTreeToggle<CR>', {silent = false, noremap = true})
map('n', '<leader>r', ':NvimTreeRefresh<CR>', {silent = false, noremap = true})

--Symbol outline
map('n', '<A-o>', '<cmd>SymbolsOutline<CR>', { noremap = true })

--Telescope
map('n', '<leader>ff', ':<cmd>lua require("telescope.builtin").find_files()<cr>', {silent = false, noremap = true})
map('n', '<leader>fg', ':<cmd>lua require("telescope.builtin").live_grep()<cr>', {silent = false, noremap = true})
map('n', '<leader>fb', ':<cmd>lua require("telescope.builtin").buffers()<cr>', {silent = false, noremap = true})
map('n', '<leader>fh', ':<cmd>lua require("telescope.builtin").help_tags()<cr>', {silent = false, noremap = true})
map('n', '<leader>tk', ':<cmd>lua require("telescope.builtin").keymaps()<cr>', {silent = false, noremap = true})
map('n', '<leader><leader>', ':<cmd>lua require("telescope").extensions.frecency.frecency()<cr>', {silent = false, noremap = true})

map('n', '<leader>gt', ':<cmd>lua require("telescope.builtin").git_status()<cr>', {silent = false, noremap = true})
map('n', '<leader>cm', ':<cmd>lua require("telescope.builtin").git_commits()<cr>', {silent = false, noremap = true})


