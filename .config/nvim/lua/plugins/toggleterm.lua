require('toggleterm').setup({
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
	shell =	'/bin/zsh',
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
