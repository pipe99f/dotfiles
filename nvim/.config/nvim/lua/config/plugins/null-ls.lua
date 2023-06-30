local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
	null_ls.builtins.formatting.black, -- python
	null_ls.builtins.formatting.gofumpt, --go
	null_ls.builtins.formatting.isort,
	null_ls.builtins.formatting.latexindent, --latex
	null_ls.builtins.formatting.markdownlint, --md
	null_ls.builtins.formatting.prettierd, -- js, html, css, etc.
	null_ls.builtins.formatting.rustfmt,
	null_ls.builtins.formatting.styler, --R, es el único que me falta instalar
	null_ls.builtins.formatting.stylua, --lua
	null_ls.builtins.formatting.shellharden, --Shell
	null_ls.builtins.formatting.shfmt, --Shell
	-- null_ls.builtins.formatting.sqlfluff,
	null_ls.builtins.formatting.uncrustify, --c, c++, c# and more

	null_ls.builtins.code_actions.shellcheck, --Shell

	null_ls.builtins.diagnostics.mypy,
	null_ls.builtins.diagnostics.ruff,
	null_ls.builtins.diagnostics.shellcheck,
	-- null_ls.builtins.diagnostics.sqlfluff,
	null_ls.builtins.diagnostics.tidy, --html diagnostics
}


local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    sources = sources,

    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                    vim.lsp.buf.format({bufnr = bufnr})
                end,
            })
        end
    end,
})
