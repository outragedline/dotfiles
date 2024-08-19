local icons = require("icons")
require("kulala").setup({
	default_view = "body",
	icons = {
		inlay = {
			loading = icons.ui.time,
			done = icons.ui.Check,
			error = icons.diagnostics.Error,
		},
	},
})
