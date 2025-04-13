local icons = require("icons")
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			preset = {
				keys = {
					{ icon = icons.ui.Search, key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = icons.ui.NewFile, key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = icons.ui.List, key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{ icon = icons.documents.Files, key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{
						icon = icons.ui.Gear,
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = icons.ui.Restore, key = "s", desc = "Restore Session", action = ":SessionRestore" },
					{ icon = icons.ui.Lazy, key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
					{ icon = icons.ui.SignOut, key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		notifier = { enabled = true },
	},
}
