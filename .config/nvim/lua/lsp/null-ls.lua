local null_ls = require("null-ls")
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		--formatting binaries
		formatting.autopep8, -- python
		formatting.stylua, --lua
		formatting.xmllint, -- XML
		formatting.jq, -- JSON
		formatting.clang_format, -- C/C++
		formatting.rustfmt,

		-- linters / diagnostics binaries
		diagnostics.tidy, -- XML
	},
})
