local opts = { noremap = true, silent = true }
local fopts = { noremap = false, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c"

--Remap space as leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-s>", "<cmd> w<CR>", opts) -- save buffer
keymap("n", "<A-q>", "<cmd>q<CR>", fopts) -- close current window
keymap("n", "<C-A-q>", "<cmd>qa<CR>", fopts) -- close current window

-- Resize windows with arrows
keymap("n", "<C-Up>", "<cmd> resize +2<CR>", opts)
keymap("n", "<C-Down>", "<cmd> resize -2<CR>", opts)
keymap("n", "<C-Left>", "<cmd> vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd> vertical resize +2<CR>", opts)

-- move between windows
keymap({ "n", "t" }, "<C-A-Left>", "<C-w>h", opts)
keymap({ "n", "t" }, "<C-A-Down>", "<C-w>j", opts)
keymap({ "n", "t" }, "<C-A-Up>", "<C-w>k", opts)
keymap({ "n", "t" }, "<C-A-Right>", "<C-w>l", opts)

-- visual mappings
keymap("v", "<", "<gv", opts) -- unindent lines
keymap("v", ">", ">gv", opts) -- indent lines

keymap("v", "p", "_dP", fopts) --"paste"  in visual mode replace selected text with the yanked text

keymap("n", "<leader>ch", "<cmd>noh<cr>", opts)

keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", fopts)

-- close current buffer
keymap("n", "<C-A-d>", "<cmd> bdelete!<CR>", opts)

-- move around tabs
keymap("n", "<C-A-n>", "<cmd>tabnext<CR>", fopts)
keymap("n", "<C-A-p>", "<cmd>tabprevious<CR>", fopts)

-- create new tab
keymap("n", "<leader>tn", "<cmd> tabnew<CR>", opts)
keymap("n", "<leader>ts", ":tab split ", opts)

-- unmapping
keymap("n", "<C-z>", "", fopts)
keymap("n", "<F1>", "", fopts)
