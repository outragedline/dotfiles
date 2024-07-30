local dap = require("dap")
local nvim_path = vim.fn.stdpath("data")

dap.adapters.codelldb = {
	type = 'server',
	port = "${port}",
	executable = {
		-- CHANGE THIS to your path!
		command = nvim_path .. '/mason/bin/codelldb',
		args = { "--port", "${port}" },

		-- On windows you may have to uncomment this:
		-- detached = false,
	}
}
dap.configurations.c = {
	{
		name = 'Launch',
		type = 'codelldb',
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
