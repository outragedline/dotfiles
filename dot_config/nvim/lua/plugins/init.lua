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
plugins = {
	{ "nvim-lua/plenary.nvim" },
	{ "kyazdani42/nvim-web-devicons" },
	{ "nvim-neotest/nvim-nio" },
	require("plugins.catpuccin"),

	require("plugins.indentline"),
	require("plugins.lualine"),
	{
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
	},
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
	require("plugins.alpha"),
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		config = function()
			require("plugins.treesitter")
		end,
	},
	{ "hiphish/rainbow-delimiters.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	require("plugins.comment"),
	require("plugins.notify"),

	require("plugins.telescope"),
	require("plugins.autopairs"),
	require("plugins.project"),
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
	require("plugins.toggleterm"),
	require("plugins.ranger"),
	require("plugins.pantran"),
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
	require("plugins.kulala"),
	require("plugins.nvimtree"),

	-- cmp plugins
	{ "hrsh7th/nvim-cmp" }, -- The completion plugin
	{ "hrsh7th/cmp-buffer" }, -- buffer completions
	{ "hrsh7th/cmp-path" }, -- path completions
	{ "hrsh7th/cmp-cmdline" }, -- cmdline completions
	{ "saadparwaiz1/cmp_luasnip" }, -- snippet completions
	{ "hrsh7th/cmp-nvim-lsp" }, -- enable lsp autocomplete with cmp
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},

	-- LSP
	{ "neovim/nvim-lspconfig" },
	{ "nvimtools/none-ls.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "williamboman/mason.nvim" },
	{ "jay-babu/mason-nvim-dap.nvim" },
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("lsp.null-ls") -- require your null-ls config here (example below)
		end,
	},

	-- Found no better way of doing that
	require("plugins.dap").dap,
	require("plugins.dap").dapui,
	require("plugins.dap").dap_python,
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{ "rafamadriz/friendly-snippets" },

	require("plugins.git"),
	require("plugins.autosession"),
}
require("lazy").setup(plugins, opts)
