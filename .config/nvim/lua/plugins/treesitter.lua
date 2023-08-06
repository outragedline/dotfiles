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
		"rust",
		"java",
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
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
