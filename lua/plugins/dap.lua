local dapui_status_ok, dapui = pcall(require, "dapui")
if not dapui_status_ok then
	return
end
require("dapui").setup()
