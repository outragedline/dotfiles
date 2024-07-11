vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua require('kulala').jump_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<cmd>lua require('kulala').jump_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<cmd>Rest run<CR>", { noremap = true, silent = true })
