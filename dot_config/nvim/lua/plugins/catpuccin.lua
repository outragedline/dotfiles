return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 900,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			show_end_of_buffer = false,
			term_colors = true,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false,
			no_bold = false,
			styles = {
				comments = { "italic" },
				conditionals = { "italic" },
				loops = { "italic" },
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			color_overrides = {},
			custom_highlights = {},
			integrations = {
				cmp = true,
				gitsigns = false,
				nvimtree = true,
				telescope = true,
				notify = true,
			},
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
