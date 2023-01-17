local onedark_status_ok, onedark = pcall(require, "onedark")
if not onedark_status_ok then
	return
end


onedark.setup({
	-- Main options --
	style = "cool", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = true,
	lualine = {
		transparent = false, -- lualine center bar transparency
	},
})
vim.cmd("colorscheme onedark")
