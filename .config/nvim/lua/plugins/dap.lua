local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end
local icons = require("ui.icons")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

dapui.setup({
	controls = { enabled = false },
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	expand_lines = vim.fn.has("nvim-0.7"),
	layouts = {
		{
			elements = {

				"breakpoints",
				"scopes",
				"stacks",
				"watches",
			},
			size = 50, -- 50 columns
			position = "right",
		},
		{
			elements = {
				"console",
				"repl",
			},
			size = 0.3, -- 30% of total lines
			position = "bottom",
		},
	},
	floating = {
		max_height = 0.2, -- These can be integers or a float between 0 and 1.
		max_width = 0.2, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = 10, -- Can be integer or nil.
	},
})

vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

local home = os.getenv("HOME")

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = home .. "/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

dap.configurations.c = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = false,
	},
}
dap.configurations.rust = dap.configurations.c

local status_ok, dap_python = pcall(require, "dap-python")
if not status_ok then
	return
end

dap_python.setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")