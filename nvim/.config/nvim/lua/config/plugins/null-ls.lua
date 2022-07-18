require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.uncrustify, --c, c++, c# and more
        require("null-ls").builtins.formatting.stylua, --lua
        require("null-ls").builtins.formatting.prettier_standard, -- js
        require("null-ls").builtins.formatting.gofmt, --go
        require("null-ls").builtins.formatting.latexindent, --latex
        require("null-ls").builtins.formatting.isort, --python
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.styler, --R
        require("null-ls").builtins.formatting.shfmt, --Shell
        -- require("null-ls").builtins.completion.spell,
    },
})

--https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts para excluir servers que formatean también
--https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/MAIN.md documentación de null-ls

--Formatting on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    vim.lsp.buf.formatting_sync()
                end,
            })
        end
    end,
})
