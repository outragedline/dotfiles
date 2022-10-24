local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 10,
	open_mapping = [[<C-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "horizontal",
	close_on_exit = true,
	shell = vim.o.shell,
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

local ranger = Terminal:new({
	cmd = "ranger",
	direction = "float",
})

function _ranger_toggle()
	ranger:toggle()
end

function _G.set_terminal_keymaps()
	local opts = { buffer = 0, noremap = false, silent = true }
	local keymap = vim.keymap.set
	keymap("t", "<C-r><C-a>", "<cmd>lua _ranger_toggle()<cr>", opts)
	keymap("t", "<C-l><C-a>", "<cmd>lua _lazygit_toggle()<cr>", opts)
	keymap("t", "<C-A-Left>", "<cmd>wincmd h<cr>", opts)
	keymap("t", "<C-A-Down>", "<cmd>wincmd j<cr>", opts)
	keymap("t", "<C-A-Up>", "<cmd>wincmd k<cr>", opts)
	keymap("t", "<C-A-Right>", "<cmd>wincmd l<cr>", opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
