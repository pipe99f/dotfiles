local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
    null_ls.builtins.formatting.uncrustify, --c, c++, c# and more
    null_ls.builtins.formatting.stylua, --lua
    null_ls.builtins.formatting.prettier, -- js, html, css, etc.
    null_ls.builtins.formatting.gofumpt, --go
    null_ls.builtins.formatting.latexindent, --latex null_ls.builtins.formatting.isort, --python
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.styler, --R, es el único que me falta instalar 
    null_ls.builtins.formatting.shfmt, --Shell

    null_ls.builtins.diagnostics.tidy, --html diagnostics

}

null_ls.setup({ sources = sources })


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
                    vim.lsp.buf.format({ --no se puede seleccionar null-ls como formatter default sino hasta nvim 0.8
                        bufnr = bufnr,
                        filter = function(client)
                            return client.name == "null-ls"
                        end

                    })
                end,
            })
        end
    end,
})

local null_ls = require("null-ls")
local api = vim.api

