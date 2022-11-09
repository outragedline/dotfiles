require("plugins.plugins")
require("plugins.nvimtree")
require("plugins.autopairs")
require("plugins.comment")
require("plugins.git")
require("plugins.project")
require("plugins.impatient")
require("plugins.alpha")
require("plugins.colorizer")
require("plugins.outline")
require("plugins.toggleterm")
require("plugins.dap")
require("plugins.octo")
require("plugins.pantran")
require("plugins.rest")
require("plugins.notify")

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

telescope.load_extension("emoji")
