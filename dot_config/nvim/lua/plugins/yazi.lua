return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<C-c>",
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			"<C-a>",
			"<cmd>Yazi toggle<CR>",
			desc = "Resume the last yazi session",
		},
		{
			"<M-a>",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
	},
	opts = {
		open_for_directories = true,
		keymaps = {
			show_help = "<f1>",
		},
	},
}
