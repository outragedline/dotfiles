return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	lazy = true,
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>" },
		{ "<leader>fp", "<cmd>Telescope projects<cr>" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>" },
	},
	config = function()
		local telescopeConfig = require("telescope.config")
		local vimgrep_arguments = { table.unpack(telescopeConfig.values.vimgrep_arguments) }

		-- I want to search in hidden/dot files.
		table.insert(vimgrep_arguments, "--hidden")
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules/",
					".git/",
				},
				vimgrep_arguments = vimgrep_arguments,
			},
			pickers = {
				find_files = {
					-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
					find_command = { "rg", "--files", "--hidden" },
				},
			},
		})
	end,
}
