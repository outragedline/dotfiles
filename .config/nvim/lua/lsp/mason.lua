local servers = {
	"pyright",
	"bashls",
	"clangd",
	"rust_analyzer",
	"tsserver",
	"html",
}

local debuggers = {
	"debugpy",
	"cpptools",
}

local null_ls = {
	"autopep8",
	"stylua",
	"jq",
	"rustfmt",
	"prettier",
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
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	if server == "jdtls" then
		goto continue
	end

	lspconfig[server].setup(opts)
	::continue::
end
