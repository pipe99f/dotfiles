--hay que configurar esto correctamente porque me estaban apareciendo diagnostics de todos los lsp instalados

local saga = require("lspsaga")
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_buf_set_keymap

local lspsaga = require("lspsaga")
saga.init_lsp_saga({
})

-- preview definition
-- vim.api.nvim_set_keymap('n', 'gd', "require'lspsaga.provider'.preview_definition()<CR>", opts)

vim.api.nvim_set_keymap("n", "gn", "<cmd>Lspsaga rename<CR>", opts)
vim.keymap.set('n', 'K', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.cmd('Lspsaga hover_doc')
    -- require"lspsaga.hover".render_hover_doc()
  end
end)
-- vim.api.nvim_set_keymap("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
vim.api.nvim_set_keymap("n", ",j", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", { silent = true })
vim.api.nvim_set_keymap("n", ",k", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "<space>ga", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("v", "<space>ga", "<cmd><C-U>Lspsaga range_code_action<CR>", opts) -- no sirve

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua require'telescope.builtin'.lsp_definitions()<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require'telescope.builtin'.lsp_implementations()<CR>", opts)
vim.api.nvim_set_keymap("n", "gt", "<cmd>lua require'telescope.builtin'.lsp_type_definitions()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua require'telescope.builtin'.lsp_references()<CR>", opts)

vim.api.nvim_set_keymap("n", "gh", "<cmd>lua require('lspsaga.finder').lsp_finder()<CR>", opts)
vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>", opts)

vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

-- require("cosmic-ui").setup()
--
-- function map(mode, lhs, rhs, opts)
-- 	local options = { noremap = true, silent = true }
-- 	if opts then
-- 		options = vim.tbl_extend("force", options, opts)
-- 	end
-- 	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
-- end
--
-- map("n", "<space>ga", '<cmd>lua require("cosmic-ui").code_actions()<cr>')
-- map("v", "<space>ga", '<cmd>lua require("cosmic-ui").range_code_actions()<cr>')
