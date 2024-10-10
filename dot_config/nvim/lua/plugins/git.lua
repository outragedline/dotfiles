return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	keys = {

		{ "<leader>gs", "<cmd> Gitsigns show<CR>" },
		{ "<leader>gt", "<cmd> Gitsigns toggle_deleted<CR>" },
		{ "<leader>gd", "<cmd> Gitsigns diffthis<CR>" },
	},
	config = function()
		require("gitsigns").setup({
			signcolumn = false,
			numhl = true,
			linehl = false,
			word_diff = false,
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				ignore_whitespace = false,
			},
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		})
	end,
}
