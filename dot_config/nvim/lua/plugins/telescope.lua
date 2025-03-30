return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	lazy = true,
	keys = {
		{ "<leader><leader>", "<cmd>Telescope buffers<cr>" },
		{ "<leader>sf",       "<cmd>Telescope find_files<cr>" },
		{ "<leader>sg",       "<cmd>Telescope live_grep<cr>" },
		{ "<leader>sh",       "<cmd>Telescope help_tags<cr>" },
		{ "<leader>sr",       "<cmd>Telescope oldfiles<cr>" },
		{ "<leader>sp",       "<cmd>Telescope projects<cr>" },
		{ "<leader>sk",       "<cmd>Telescope keymaps<cr>" },
		{ "<leader>sd",       "<cmd>Telescope diagnostics<cr>" },
		{ "<leader>sr",       "<cmd>Telescope resume<cr>" },
		{ "<leader>sw",       "<cmd>Telescope grep_string<cr>" },
		{ "<leader>sc",       "<cmd>Telescope command_history<cr>" },
		{ "<leader>ss",       "<cmd>Telescope spell_suggest<cr>" },
	},
	config = function()
		local telescopeConfig = require("telescope.config")
		local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
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
					find_command = { "rg", "--files", "--hidden" },
				},
			},
		})
	end,
}
