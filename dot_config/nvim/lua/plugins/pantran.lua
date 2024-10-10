return {
	"potamides/pantran.nvim",
	event = "VeryLazy",
	lazy = true,
	keys = {

		{ "<C-t>", "<cmd>Pantran<CR>" },
	},
	config = function()
		require("pantran").setup({
			default_engine = "google",
			engines = {
				google = {
					default_source = "portuguese",
					default_target = "en",
				},
			},
			controls = {
				mappings = {
					edit = {
						n = {
							["j"] = "gj",
							["k"] = "gk",
						},
					},
					-- Keybindings here are used in the selection window.
					select = {
						n = {
							-- ...
						},
					},
				},
			},
		})
	end,
}
