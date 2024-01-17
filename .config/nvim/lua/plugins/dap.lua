local home = os.getenv("HOME")
local dap = require("dap")

dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
	name = 'lldb'
}
dap.configurations.c = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		runInTerminal = true,
		args = {},
	},
}

dap.adapters.godot = {
	type = "server",
	host = '127.0.0.1',
	port = 6006,
}

local function get_python_module()
	return vim.fn.input("Which module?: ")
end
dap.configurations.python = {
	{
		type = 'python',
		request = 'launch',
		name = "launch module",
		justMyCode = false,


		module = function()
			return get_python_module()
		end,
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
				return cwd .. '/venv/bin/python'
			elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
				return cwd .. '/.venv/bin/python'
			else
				return '/usr/bin/python'
			end
		end,
	},
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
