vim.g.vimtex_compiler_latexmk = {
    build_dir = '.out',
    options = {
        '-shell-escape',
        '-verbose',
        '-file-line-error',
        '-interaction=nonstopmode',
        '-synctex=1'
    }
}

--Está en la sección de autocommands
-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = "bufcheck",
-- 	pattern = "tex",
--   command = "VimtexCompile",
-- })

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_fold_enabled = true
vim.g.vimtex_quickfix_mode = 0
