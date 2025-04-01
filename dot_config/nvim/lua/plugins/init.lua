plugins = {
	"nvim-lua/plenary.nvim",
	"kyazdani42/nvim-web-devicons",
	"nvim-neotest/nvim-nio",
	"hiphish/rainbow-delimiters.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"nvimtools/none-ls.nvim",
	"rafamadriz/friendly-snippets",

	require("plugins.catpuccin"),
	require("plugins.indentline"),
	require("plugins.lualine"),
	require("plugins.bufferline"),
	require("plugins.alpha"),
	require("plugins.treesitter"),
	require("plugins.comment"),
	require("plugins.notify"),
	require("plugins.telescope"),
	require("plugins.autopairs"),
	require("plugins.project"),
	require("plugins.toggleterm"),
	require("plugins.yazi"),
	require("plugins.kulala"),

	-- Found no better way of doing that
	require("plugins.dap").dap,
	require("plugins.dap").dapui,
	require("plugins.dap").dap_python,

	require("plugins.git"),
	require("plugins.autosession"),
	require("plugins.null-ls"),
	require("plugins.mason"),
	require("plugins.cmp"),
	require("plugins.lspcfg"),

	require("plugins.rustacean"),
	{
		"tiagovla/scope.nvim",
		config = function()
			vim.opt.sessionoptions = {
				"buffers",
				"tabpages",
				"globals",
			}
			require("scope").setup()
		end,
	},
	{
		"famiu/bufdelete.nvim",
		event = "VeryLazy",
		lazy = true,
		keys = {
			{ "<C-A-d>", "<cmd>Bdelete!<CR>" },
		},
	},
	{
		"uga-rosa/ccc.nvim",
		config = function()
			require("ccc").setup({
				highlighter = {
					auto_enable = true,
					lsp = true,
				},
			})
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
	},
}
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, opts)
