return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	config = function()
		vim.g.rustaceanvim = {
			tools = {},
			server = {
				on_attach = function(client, bufnr)
					require("handlers").lsp.on_attach(client, bufnr)
				end,
				default_settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						procMacro = {
							enabled = true,
						},
					},
				},
			},
		}
	end,
}
