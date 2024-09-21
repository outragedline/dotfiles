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
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		config = function()
			require("plugins.lualine")
		end,
	},
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
	{
		"rcarriga/nvim-notify",
		config = function()
			require("plugins.notify")
		end,
	},

	{
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
			require("plugins.telescope")
		end,
	},
	require("plugins.autopairs"),
	{
		"ahmedkhalf/project.nvim",
		lazy = false,
		config = function()
			require("plugins.project")
		end,
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
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		lazy = true,
		keys = {
			{ mode = "t", "<C-q>", [[<C-\><C-n>]] },
			{ mode = { "n", "t" }, "<A-1>", "<cmd>ToggleTerm 1<cr>" },
			{ mode = { "n", "t" }, "<A-2>", "<cmd>ToggleTerm 2<cr>" },
			{ mode = { "n", "t" }, "<C-l><C-a>", "<cmd>lua _lazygit_toggle()<cr>" },
			--[[ { mode = { "n", "t" }, "<C-r><C-a>", "<cmd>lua _ranger_toggle()<cr>" }, ]]
			{ mode = { "n", "t" }, "<C-l><C-a>", "<cmd>lua _lazygit_toggle()<cr>" },
		},
		config = function()
			require("plugins.toggleterm")
		end,
	},
	{
		"kelly-lin/ranger.nvim",
		event = "VeryLazy",
		lazy = true,
		config = function()
			require("plugins.ranger")
		end,
		keys = {
			{ mode = "n", "<C-r><C-a>", "<cmd>lua 		require('ranger-nvim').open(true)<cr>" },
		},
	},
	{
		"potamides/pantran.nvim",
		event = "VeryLazy",
		lazy = true,
		keys = {

			{ "<C-t>", "<cmd>Pantran<CR>" },
		},
		config = function()
			require("plugins.pantran")
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
	require("plugins.kulala"),
	{
		"kyazdani42/nvim-tree.lua",
		event = "VeryLazy",
		lazy = true,
		keys = {
			{ "<C-a>", "<cmd> NvimTreeToggle<CR>" },
		},
		config = function()
			require("plugins.nvimtree")
		end,
	},

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
