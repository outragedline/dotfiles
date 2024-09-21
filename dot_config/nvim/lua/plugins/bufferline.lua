return {
	"akinsho/bufferline.nvim",
	lazy = false,
	keys = {
		{ "<Tab>", "<cmd>BufferLineCycleNext<CR>" },
		{ "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>" },
		{ "<leader>bp", "<cmd>BufferLinePick<CR>" },
		{ "<leader>bpc", "<cmd>BufferLinePickClose<CR>" },
		{ "<C-m><C-n>", "<cmd> BufferLineMoveNext<CR>" },
		{ "<C-m><C-p>", "<cmd> BufferLineMovePrev<CR>" },
	},
	config = function()
		require("bufferline").setup()
	end,
}
