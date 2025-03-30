return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	lazy = true,
	keys = {
		{ mode = "t",          "<C-q>",      [[<C-\><C-n>]] },
		{ mode = { "n", "t" }, "<A-1>",      "<cmd>ToggleTerm 1<cr>" },
		{ mode = { "n", "t" }, "<A-2>",      "<cmd>ToggleTerm 2<cr>" },
		{ mode = { "n", "t" }, "<A-3>",      "<cmd>ToggleTerm 3<cr>" },
		{ mode = { "n", "t" }, "<A-4>",      "<cmd>ToggleTerm 4<cr>" },
		{ mode = { "n", "t" }, "<C-l><C-a>", "<cmd>lua _lazygit_toggle()<cr>" },
	},
	config = function()
		require("toggleterm").setup({
			size = 10,
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			direction = "float",
		})

		function _lazygit_toggle()
			lazygit:toggle()
		end
	end,
}
