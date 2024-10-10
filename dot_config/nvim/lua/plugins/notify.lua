return {
	"rcarriga/nvim-notify",
	config = function()
		local icons = require("icons")

		vim.notify = require("notify")

		require("notify").setup({
			stages = "slide",
			on_open = nil,
			on_close = nil,
			render = "default",
			timeout = 1000,
			background_colour = "#000000",
			minimum_width = 10,
			icons = {
				ERROR = icons.diagnostics.Error,
				WARN = icons.diagnostics.Warning,
				INFO = icons.diagnostics.Information,
				DEBUG = icons.ui.Bug,
				TRACE = icons.ui.Pencil,
			},
		})

		local notify_filter = vim.notify
		vim.notify = function(msg, ...)
			if msg:match("character_offset must be called") then
				return
			end
			if msg:match("method textDocument") then
				return
			end

			notify_filter(msg, ...)
		end
	end,
}
