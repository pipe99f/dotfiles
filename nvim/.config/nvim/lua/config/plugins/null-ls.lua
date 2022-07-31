local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
  null_ls.builtins.formatting.uncrustify, --c, c++, c# and more
  null_ls.builtins.formatting.stylua, --lua
  null_ls.builtins.formatting.prettierd, -- js, html, css, etc.
  null_ls.builtins.formatting.gofumpt, --go
  null_ls.builtins.formatting.latexindent, --latex null_ls.builtins.formatting.isort
  null_ls.builtins.formatting.black, -- python
  null_ls.builtins.formatting.isort,
  null_ls.builtins.formatting.styler, --R, es el único que me falta instalar
  null_ls.builtins.formatting.shfmt, --Shell

  null_ls.builtins.diagnostics.tidy, --html diagnostics

}

null_ls.setup({ sources = sources })



