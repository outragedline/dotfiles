return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		null_ls.setup({
			debug = false,
			sources = {
				--formatting binaries
				formatting.stylua,
				formatting.clang_format.with({
					filetypes = {
						"c",
						"cpp",
						"cs",
						"cuda",
					},
				}),
				formatting.prettier,
				formatting.npm_groovy_lint.with({
					filetypes = {
						"groovy",
					},
				}),
				formatting.pint,
				formatting.sqlfluff.with({
					extra_args = { "--config", vim.fn.getcwd() .. "/.sqlfluff" },
				}),

				-- linters / diagnostics binaries
				diagnostics.tidy,
				diagnostics.sqlfluff,
			},

			on_attach = function(client, bufnr)
				require("lsp.handlers").on_attach(client, bufnr)
			end,
		})
	end,
}
