local api = require("nvim-tree.api")
local icons = require("icons")

-- Replaces auto_close
local tree_cb = api.nvim_tree_callback
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd("quit")
		end
	end,
})

require("nvim-tree").setup({
	create_in_closed_folder = false,
	disable_netrw = true,
	hijack_netrw = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	diagnostics = {
		enable = true,
		icons = {
			hint = icons.diagnostics.Hint,
			info = icons.diagnostics.Information,
			warning = icons.diagnostics.Warning,
			error = icons.diagnostics.Error,
		},
	},
	renderer = {
		indent_markers = {
			enable = true,
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			modified_placement = "after",
			padding = " ",
			symlink_arrow = " -> ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
				modified = true,
			},
			glyphs = {
				default = icons.documents.File,
				symlink = icons.documents.Symlink,
				bookmark = icons.ui.Bookmark,
				modified = icons.git.Mod,
				folder = {
					arrow_closed = icons.ui.ArrowClosed,
					arrow_open = icons.ui.ArrowOpen,
					default = icons.documents.Folder,
					open = icons.documents.OpenFolder,
					empty = icons.documents.EmptyFolder,
					empty_open = icons.documents.EmptyFolderOpen,
					symlink = icons.documents.FolderSymlink,
					symlink_open = icons.documents.FolderSymlinkOpen,
				},
				git = {
					unstaged = icons.git.Mod,
					staged = icons.git.Staged,
					unmerged = icons.git.Unmerged,
					renamed = icons.git.Rename,
					untracked = icons.git.Untracked,
					deleted = icons.git.Remove,
					ignored = icons.git.Ignore,
				},
			},
		},
	},

	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = true,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 40,
		side = "left",
		number = false,
		relativenumber = true,
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	actions = {
		open_file = {
			quit_on_open = true,
			window_picker = {
				enable = false,
			},
		},
	},
})
