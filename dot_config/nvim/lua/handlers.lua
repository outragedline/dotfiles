return {
	lsp = {
		capabilities = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			return capabilities
		end,
		on_attach = function(client, bufnr)
			local function lsp_keymaps(bufnr)
				local opts = { noremap = true, silent = true }
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_declarations<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "H", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>sh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"[d",
					'<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
					opts
				)
				vim.api.nvim_buf_set_keymap(
					bufnr,
					"n",
					"]d",
					'<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
					opts
				)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cl", "<cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
				vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-f>", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
			end
			lsp_keymaps(bufnr)
			client.server_capabilities.document_formatting = true
		end,
	},
}
