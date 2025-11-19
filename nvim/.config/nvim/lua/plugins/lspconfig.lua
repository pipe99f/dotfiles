return {
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		ft = { "c", "cpp" },
		config = function() end,
		opts = {
			-- inlay_hints = {
			-- 	inline = false,
			-- },
			ast = {
				--These require codicons (https://github.com/microsoft/vscode-codicons)
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					specifier = "",
					statement = "",
					["template argument"] = "",
				},
				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
			},
		},
	},
	{
		"scalameta/nvim-metals",
		ft = { "scala", "sbt" },
		opts = function()
			local metals_config = require("metals").bare_config()

			-- Example of settings
			metals_config.settings = {
				showImplicitArguments = true,
				excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
			}

			metals_config.init_options.statusBarProvider = "off"

			-- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- metals_config.capabilities = require("lsp-zero").get_capabilities()
			metals_config.capabilities = require("blink.cmp").get_lsp_capabilities()

			metals_config.on_attach = function(client, bufnr)
				require("metals").setup_dap()
			end
			return metals_config
		end,
		config = function(self, metals_config)
			local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "scala", "sbt", "java" },
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
				group = nvim_metals_group,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		ft = { "rust" },
		version = "^4", -- Recommended
		config = function()
			vim.g.rustaceanvim = {
				server = {
					-- capabilities = require("lsp-zero").get_capabilities(),
					capabilities = require("blink.cmp").get_lsp_capabilities(),
					default_settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								buildScripts = {
									enable = true,
								},
							},
							-- Add clippy lints for Rust.
							checkOnSave = true,
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
			}
		end,
	},
}
