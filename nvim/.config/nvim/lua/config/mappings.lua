local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local autocmd = vim.api.nvim_create_autocmd

-----------
--GENERAL--
-----------

vim.g.mapleader = " "

-- Quickfix mappings map('n', '<leader>ck', ':cexpr []<cr>', opts)
map("n", "<leader>cc", ":cclose <cr>", opts)
map("n", "<leader>co", ":copen <cr>", opts)
map("n", "<leader>cf", ":cfdo %s/", opts)
map("n", "<leader>cp", ":cprev<cr>zz", opts)
map("n", "<leader>cn", ":cnext<cr>zz", opts)

-- Copy path
vim.cmd('map <leader>fn :let @+ = expand("%:t") \\| echo "File name copied: " . @+<CR>')
vim.cmd('map <leader>fp :let @+ = expand("%:p") \\| echo "File path copied: " . @+<CR>')

-- Rename all string occurrences in the current buffer
vim.cmd("map re gD:%s/<C-R>///gc<left><left><left>")

--Ctrl+Backspace deletes word
vim.keymap.set("i", "<C-h>", "<C-w>")

--Enter in normal mode deletes word
vim.keymap.set("n", "<cr>", "ciw")

--avoid placing cursor at the beginning when yanking in visual mode
vim.keymap.set("v", "y", "may`a")

--Beginning and end of lines
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

--Move highlited text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up" })

--fast saving
map("n", "<leader>w", ":w!<CR>", { silent = false })
map("n", "<leader>W", ":wa!<CR>", { silent = false })

-- Quit neovim
map("n", "<C-Q>", ":qa<CR>", opts)

-- resize windows
map("n", "<C-Up>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- move between windows
map("n", "<C-k>", "<C-W>k", { silent = true })
map("n", "<C-j>", "<C-W>j", { silent = true })
map("n", "<C-l>", "<C-W>l", { silent = true })
map("n", "<C-h>", "<C-W>h", { silent = true })

--create split window
map("n", "<leader>vs", ":vsplit<CR>", { silent = false })
map("n", "<leader>ss", ":split<CR>", { silent = false })

--normal mode in terminal
map("t", "<Esc>", "<C-\\><C-n>", { silent = false })

--buffers
vim.keymap.set("n", "<BS>", ":b#<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = false, noremap = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = false, noremap = true })
vim.api.nvim_set_keymap("n", ">b", ":BufferLineMoveNext<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<b", ":BufferLineMovePrev<CR>", { silent = true, noremap = true })

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

  autocmd FileType lua nnoremap <buffer> <leader>rr :w :bo :8sp <CR> :term lua "%:p" <CR>

  autocmd FileType cpp nnoremap <buffer> <leader>rr :w <CR> :make %< && ./%< <cr>
  autocmd FileType cpp nnoremap <buffer> <leader>ru :w <CR> :!gcc % && ./%< <CR>
  augroup END
]])

-----------
--PLUGINS--
-----------

--Code runner
-- vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
-- vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })

--DAP
vim.keymap.set("n", "<leader>db", "<CMD>DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<leader>dpr", "<CMD>lua require('dap-python').test_method()<CR>")

--Iron
map("n", "<leader>ti", "<cmd>IronRepl<CR>", opts) -- toggle iron REPL

--NvimTree
map("n", "<leader>n", ":NvimTreeToggle<CR>", { silent = false, noremap = true })

-- Toggleterm
-- vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
-- vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("n", "<A-i>", "<CMD>lua _hiddenFloat()<CR>")
vim.keymap.set("t", "<A-i>", "<C-\\><C-n><CMD>:lua _hiddenFloat()<CR>")
map("n", "<A-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
map("t", "<A-g>", "<C-\\><C-n><cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
-- map('n', '<A-t>', '<CMD>:ToggleTerm direction=horizontal<CR>',{noremap = true, silent = true})
-- map('t', '<A-t>', '<C-\\><C-n><CMD>:ToggleTerm direction=horizontal<CR>',{noremap = true, silent = true})
-- map('t', '<A-\\>', '<C-\\><C-n><CMD>:ToggleTerm direction=float<CR>')

--Symbols Outline
map("n", "<A-o>", ":SymbolsOutline<CR>", { silent = false, noremap = true })

--Spectre
vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").open()<CR>', {
	desc = "Open Spectre",
})
vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

--Telescope
map("n", "<leader>tk", ':<cmd>lua require("telescope.builtin").keymaps()<cr>', { silent = false, noremap = true })
map("n", "<leader>fe", ':<cmd>lua require("telescope.builtin").find_files()<cr>', { silent = false, noremap = true })
map(
	"n",
	"<leader>tf",
	':<cmd>lua require("telescope").extensions.frecency.frecency()<cr>',
	{ silent = false, noremap = true }
)
map("n", "<leader><leader>", ':<cmd>lua require("telescope.builtin").resume()<cr>', { silent = false, noremap = true })

map("n", "<leader>gt", ':<cmd>lua require("telescope.builtin").git_status()<cr>', { silent = false, noremap = true })
map("n", "<leader>cm", ':<cmd>lua require("telescope.builtin").git_commits()<cr>', { silent = false, noremap = true })
