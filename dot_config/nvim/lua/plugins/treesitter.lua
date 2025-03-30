return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"python",
				"javascript",
				"typescript",
				"json",
				"bash",
				"http",
				"html",
				"css",
				"c",
				"cpp",
				"rust",
				"java",
				"groovy",
				"make",
				"kotlin",
				"meson",
				"sql",
				"yaml",
				"tsx",
				"prisma"
			},

			highlight = {
				enable = true, -- false will disable the whole extension
				additional_vim_regex_highlighting = true,
				disable = { "http" },
			},
			indent = {
				enable = true,
				disable = { "http" },
			},
			autopairs = {
				enable = true,
			},
		})

		require("ts_context_commentstring").setup({
			enable = true,
			enable_autocmd = false,
		})
	end,
}
