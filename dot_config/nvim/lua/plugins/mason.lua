return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local servers = {
			"pyright",
			"ruff",
			"clangd",
			"ts_ls",
			"lua_ls",
			"cssls",
			"jdtls",
			"gradle_ls",
			"mesonlsp",
			"intelephense",
			"taplo",
			"prismals",
		}

		local debuggers = {
			"javadbg",
			"javatest",
			"python",
			"codelldb",
			"php-debug-adapter",
		}

		local null_ls = {
			"prettier",
			"stylua",
			"npm_groovy_lint",
			"pint",
			"sqlfluff",
			"ktlint",
		}

		local settings = {
			ui = {
				border = "rounded",
				icons = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
		}

		require("mason").setup(settings)
		require("mason-lspconfig").setup({
			ensure_installed = servers,
			automatic_installation = true,
		})

		require("mason-nvim-dap").setup({
			ensure_installed = debuggers,
			automatic_installation = true,
		})

		require("mason-null-ls").setup({
			ensure_installed = null_ls,
			automatic_installation = true,
		})

		local lspconfig = require("lspconfig")
		local opts = {}

		for _, server in pairs(servers) do
			opts = {
				on_attach = require("handlers").lsp.on_attach,
				capabilities = require("handlers").lsp.capabilities(),
			}

			if server == "jdtls" then
				goto continue
			end

			lspconfig[server].setup(opts)
			::continue::
		end
	end,
}
