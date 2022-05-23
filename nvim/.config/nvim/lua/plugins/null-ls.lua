require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.uncrustify, --c, c++, c# and more
        require("null-ls").builtins.formatting.stylua, --lua
        require("null-ls").builtins.formatting.prettier_standard,
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
