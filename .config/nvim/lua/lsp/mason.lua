local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
	return
end

local status_ok_2, mason_null = pcall(require, "mason-null-ls")
if not status_ok_2 then
	return
end

local status_ok_3, mason_nvim_dap = pcall(require, "mason-nvim-dap")
if not status_ok_3 then
	return
end

local servers = {
	"pyright",
	"bashls",
	"clangd",
	"rust_analyzer"
}

local debuggers = {
	"debugpy",
	"cpptools",
}

local null_ls = {
	"autopep8",
	"stylua",
	"jq",
	"clang_format",
	"rustfmt"
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

mason.setup(settings)
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

mason_nvim_dap.setup({
	ensure_installed = debuggers,
	automatic_installation = true,
})

mason_null.setup({
	ensure_installed = null_ls,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

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