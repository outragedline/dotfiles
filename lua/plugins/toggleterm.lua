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
	direction = "float",
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

local mycli = Terminal:new({
	cmd = "mycli",
	direction = "float",
})

function _ranger_toggle()
	ranger:toggle()
end

function _mycli_toggle()
	mycli:toggle()
end
