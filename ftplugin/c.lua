local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
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
