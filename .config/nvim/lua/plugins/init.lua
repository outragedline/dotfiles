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
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("plugins.catpuccin")
		end,
	},

	{ "lukas-reineke/indent-blankline.nvim" },
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
			{ "<Tab>",       "<cmd>BufferLineCycleNext<CR>" },
			{ "<S-Tab>",     "<cmd>BufferLineCyclePrev<CR>" },
			{ "<leader>bp",  "<cmd>BufferLinePick<CR>" },
			{ "<leader>bpc", "<cmd>BufferLinePickClose<CR>" },
			{ "<C-m><C-n>",  "<cmd> BufferLineMoveNext<CR>" },
			{ "<C-m><C-p>",  "<cmd> BufferLineMovePrev<CR>" },
		},
		config = function()
			require("bufferline").setup()
		end,
	},
	{
		"tiagovla/scope.nvim",
		config = function()
			-- init.lua
			require("scope").setup()
		end,
	},
	{
		"famiu/bufdelete.nvim",
		event = "VeryLazy",
		keys = {
			{ "<C-A-d>", "<cmd>Bdelete!<CR>" },
		},
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins.alpha")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		config = function()
			require("plugins.treesitter")
		end,
	},
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("plugins.comment")
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("plugins.notify")
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
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
	{
		"windwp/nvim-autopairs",
		lazy = false,
		config = function()
			require("plugins.autopairs")
		end,
	},
	{
		"ahmedkhalf/project.nvim",
		lazy = false,
		config = function()
			require("plugins.project")
		end,
	},
	{
		"uga-rosa/ccc.nvim",
		lazy = false,
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
		keys = {
			{ mode = "t",          "<C-q>",      [[<C-\><C-n>]] },
			{ mode = { "n", "t" }, "<A-1>",      "<cmd>ToggleTerm 1<cr>" },
			{ mode = { "n", "t" }, "<A-2>",      "<cmd>ToggleTerm 2<cr>" },
			{ mode = { "n", "t" }, "<C-l><C-a>", "<cmd>lua _lazygit_toggle()<cr>" },
			{ mode = { "n", "t" }, "<C-r><C-a>", "<cmd>lua _ranger_toggle()<cr>" },
			{ mode = { "n", "t" }, "<C-l><C-a>", "<cmd>lua _lazygit_toggle()<cr>" },
		},
		config = function()
			require("plugins.toggleterm")
		end,
	},
	{
		"potamides/pantran.nvim",
		event = "VeryLazy",
		keys = {

			{ "<C-t>", "<cmd>Pantran<CR>" },
		},
		config = function()
			require("plugins.pantran")
		end,
	},
	{
		"NTBBloodbath/rest.nvim",
		event = "VeryLazy",
		ft = "http",
		keys = {
			{ "<leader>r", "<Plug>RestNvim" },
		},
		config = function()
			require("plugins.rest")
		end,
	},
	{
		"kyazdani42/nvim-tree.lua",
		keys = {
			{ "<C-a>", "<cmd> NvimTreeToggle<CR>" },
		},
		config = function()
			require("plugins.nvimtree")
		end,
	},

	-- cmp plugins
	{ "hrsh7th/nvim-cmp" },   -- The completion plugin
	{ "hrsh7th/cmp-buffer" }, -- buffer completions
	{ "hrsh7th/cmp-path" },   -- path completions
	{ "hrsh7th/cmp-cmdline" }, -- cmdline completions
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp"
	},
	{ "hrsh7th/cmp-nvim-lsp" }, -- enable lsp autocomplete with cmp
	{ "mfussenegger/nvim-jdtls" },

	-- LSP
	{ "neovim/nvim-lspconfig" },
	{ "jose-elias-alvarez/null-ls.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "williamboman/mason.nvim" },
	{ "jayp0521/mason-nvim-dap.nvim" },
	{ "jayp0521/mason-null-ls.nvim" },
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		keys = {

			{ "<leader>dt", "<cmd>DapToggleBreakpoint<cr>" },
			{ "<leader>dc", "<cmd>DapContinue<cr>" },
			{ "<leader>di", "<cmd>DapStepInto<cr>" },
			{ "<leader>do", "<cmd>DapStepOver<cr>" },
		},
		config = function()
			require("plugins.dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		keys = {
			{ "<leader>du", "<cmd>lua require'dapui'.toggle({reset=true})<cr>" },
		},
		config = function()
			require("plugins.dapui")
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "py",
		event = "VeryLazy",
		config = function()
			require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
		end,
	},

	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		keys = {

			{ "<leader>gs", "<cmd> Gitsigns show<CR>" },
			{ "<leader>gt", "<cmd> Gitsigns toggle_deleted<CR>" },
			{ "<leader>gd", "<cmd> Gitsigns diffthis<CR>" },
		},
		config = function()
			require("plugins.git")
		end,
	},

	{
		"tpope/vim-dadbod",
		event = "VeryLazy",
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		event = "VeryLazy",
	},
}
require("lazy").setup(plugins, opts)
