local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
	return
end

copilot.setup({
	panel = {
		enabled = true,
	},
	suggestion = {
		enabled = true,
		auto_trigger = false,
		debounce = 75,
		keymap = {
			accept = "<tab>",
			next = "<A-]>",
			prev = "<A-[>",
			dismiss = "<C-]>",
		},
	},
})
