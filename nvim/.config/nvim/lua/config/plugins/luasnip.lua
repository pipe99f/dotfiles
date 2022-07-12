require("luasnip.loaders.from_vscode").lazy_load()

--Friendly snippets list
--https://github.com/rafamadriz/friendly-snippets/wiki

-- Para agreagar snippets de frameworks usando friendly snippets:
-- require'luasnip'.filetype_extend("ruby", {"rails"})


require("luasnip.loaders.from_snipmate").lazy_load()
