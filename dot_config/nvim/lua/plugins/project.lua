return {
	"ahmedkhalf/project.nvim",
	lazy = false,
	config = function()
		require("project_nvim").setup({
			active = true,
			on_config_done = nil,
			manual_mode = false,
			detection_methods = { "pattern", "lsp" },
			patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".mvnw" },
			show_hidden = false,
			silent_chdir = true,
			ignore_lsp = {},
			datapath = vim.fn.stdpath("data"),
		})
		require("telescope").load_extension("projects")
	end,
}
