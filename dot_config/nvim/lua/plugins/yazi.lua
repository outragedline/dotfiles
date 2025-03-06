return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<M-a>",
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			"<C-a>",
			"<cmd>Yazi toggle<CR>",
			desc = "Resume the last yazi session",
		},
		{
			"<C-M-a>",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
	},
	opts = {
		open_for_directories = true,
		open_multiple_tabs = true,
		keymaps = {
			show_help = "<f1>",
		},
	},
}
