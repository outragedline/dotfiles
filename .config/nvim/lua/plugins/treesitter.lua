require('nvim-treesitter.configs').setup({
	ensure_installed = { "lua", "python", "javascript", "json", "bash", "http", "html", "sql", "c", "rust" },
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = true,
		disable = { "http" },
	},
	indent = {
		enable = true,
		disable = { "http" },
	},
	rainbow = {
		enable = true,
		disable = { "http" },
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
