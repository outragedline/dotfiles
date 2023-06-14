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

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
