return {
	"mistweaverco/kulala.nvim",
	-- Most keys defined on ftplugin/http.lua
	keys = {
		{ "<leader>ks", "<cmd>lua require('kulala').search()<CR>" },
		{ "<leader>kc", "<cmd>lua require('kulala').close()<CR>" },
	},
	config = function()
		local icons = require("icons")
		require("kulala").setup({
			default_view = "headers_body",
			icons = {
				inlay = {
					loading = icons.ui.Time,
					done = icons.ui.Check,
					error = icons.diagnostics.Error,
				},
			},
		})
	end,
}
