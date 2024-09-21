local M = {}
M.dap = {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	lazy = true,
	keys = {

		{ "<leader>dt", "<cmd>DapToggleBreakpoint<cr>" },
		{ "<leader>dc", "<cmd>DapContinue<cr>" },
		{ "<leader>di", "<cmd>DapStepInto<cr>" },
		{ "<leader>do", "<cmd>DapStepOver<cr>" },
	},
	config = function()
		local dap = require("dap")
		local nvim_path = vim.fn.stdpath("data")

		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				-- CHANGE THIS to your path!
				command = nvim_path .. "/mason/bin/codelldb",
				args = { "--port", "${port}" },

				-- On windows you may have to uncomment this:
				-- detached = false,
			},
		}
		dap.configurations.c = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				runInTerminal = true,
				args = {},
			},
		}
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.rust = dap.configurations.c

		local function get_python_module()
			return vim.fn.input("Which module?: ")
		end
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "launch module",
				justMyCode = false,

				module = function()
					return get_python_module()
				end,
				pythonPath = function()
					local cwd = vim.fn.getcwd()
					if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					else
						return "/usr/bin/python"
					end
				end,
			},
		}

		dap.configurations.java = {
			{
				type = "java",
				request = "attach",
				name = "Debug (Attach) - Remote",
				hostName = "127.0.0.1",
				port = 5005,
			},
		}
		dap.adapters.php = {
			type = "executable",
			command = "node",
			args = { nvim_path .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
		}

		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003,
				pathMappings = {
					["/var/www/html"] = vim.fn.getcwd(),
				},
			},
		}
	end,
}
M.dap_python = {
	"mfussenegger/nvim-dap-python",
	ft = "py",
	event = "VeryLazy",
	lazy = true,
	config = function()
		require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
	end,
}
M.dapui = {
	"rcarriga/nvim-dap-ui",
	event = "VeryLazy",
	lazy = true,
	keys = {
		{ "<leader>du", "<cmd>lua require'dapui'.toggle({reset=true})<cr>" },
	},
	config = function()
		local icons = require("icons")
		local dap, dapui = require("dap"), require("dapui")
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

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" }
		)
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
	end,
}

return M
