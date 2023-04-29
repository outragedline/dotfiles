local opts = { noremap = true, silent = true }
local fopts = { noremap = false, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

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
keymap("n", "<C-A-Left>", "<C-w>h", opts)
keymap("n", "<C-A-Down>", "<C-w>j", opts)
keymap("n", "<C-A-Up>", "<C-w>k", opts)
keymap("n", "<C-A-Right>", "<C-w>l", opts)

-- visual mappings
keymap("v", "<", "<gv", opts) -- unindent lines
keymap("v", ">", ">gv", opts) -- indent lines

keymap("v", "p", "_dP", fopts) --"paste"  in visual mode replace selected text with the yanked text

-- ToggleTerm mappings
keymap("t", "<C-q>", [[<C-\><C-n>]], opts)
keymap("n", "<C-r><C-a>", "<cmd>lua _ranger_toggle()<cr>", opts)
keymap("t", "<A-1>", "<cmd>ToggleTerm 1<cr>", opts)
keymap("t", "<A-2>", "<cmd>ToggleTerm 2<cr>", opts)
keymap("n", "<A-1>", "<cmd>ToggleTerm 1<cr>", opts)
keymap("n", "<A-2>", "<cmd>ToggleTerm 2<cr>", opts)
keymap("n", "<C-m><C-y>", "<cmd>lua _mycli_toggle()<cr>", opts)
keymap("n", "<C-l><C-a>", "<cmd>lua _lazygit_toggle()<cr>", opts)
keymap("t", "<C-r><C-a>", "<cmd>lua _ranger_toggle()<cr>", opts)
keymap("t", "<C-l><C-a>", "<cmd>lua _lazygit_toggle()<cr>", opts)
keymap("t", "<C-A-Left>", "<cmd>wincmd h<cr>", opts)
keymap("t", "<C-A-Down>", "<cmd>wincmd j<cr>", opts)
keymap("t", "<C-A-Up>", "<cmd>wincmd k<cr>", opts)
keymap("t", "<C-A-Right>", "<cmd>wincmd l<cr>", opts)

--tools
keymap("n", "<C-a>", "<cmd> NvimTreeToggle<CR>", opts)
keymap("n", "<C-o>", "<cmd> SymbolsOutline<CR>", opts)
keymap("n", "<leader>ch", "<cmd>noh<cr>", opts)
keymap("n", "<leader>r", "<Plug>RestNvim", opts)
keymap("n", "<leader>rp", "<Plug>RestNvimPreview", opts)
keymap("n", "<leader>rl", "<Plug>RestNvimLast", opts)

keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", fopts)

-- e.g. if you change the order of buffers :bnext and :bprevious will not respect the custom ordering
keymap("n", "<C-n>", "<cmd>BufferLineCycleNext<CR>", opts)
keymap("n", "<C-p>", "<cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "<leader>bp", "<cmd>BufferLinePick<CR>", opts)
keymap("n", "<leader>bpc", "<cmd>BufferLinePickClose<CR>", opts)

-- close current buffer
keymap("n", "<C-A-d>", "<cmd> bdelete!<CR>", opts)

-- move around tabs
keymap("n", "<C-A-n>", "<cmd>tabnext<CR>", fopts)
keymap("n", "<C-A-p>", "<cmd>tabprevious<CR>", fopts)

-- create new tab
keymap("n", "<leader>tn", "<cmd> tabnew<CR>", opts)
keymap("n", "<leader>ts", ":tab split ", opts)


-- Buffer navigation
keymap("n", "<C-m><C-n>", "<cmd> BufferLineMoveNext<CR>", opts)
keymap("n", "<C-m><C-p>", "<cmd> BufferLineMovePrev<CR>", opts)

--Telescope mappings
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", opts)
keymap("n", "<leader>fp", "<cmd>Telescope projects<cr>", opts)
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opts)

keymap("n", "<C-p><C-e>", '"*p', opts)

--Gitsigns
keymap("n", "<leader>gs", "<cmd> Gitsigns show<CR>", opts)
keymap("n", "<leader>gt", "<cmd> Gitsigns toggle_deleted<CR>", opts)
keymap("n", "<leader>gd", "<cmd> Gitsigns diffthis<CR>", opts)

-- DAP
keymap("n", "<leader>dt", "<cmd>DapToggleBreakpoint<cr>", opts)
keymap("n", "<leader>dc", "<cmd>DapContinue<cr>", opts)
keymap("n", "<leader>di", "<cmd>DapStepInto<cr>", opts)
keymap("n", "<leader>do", "<cmd>DapStepOver<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle({reset=true})<cr>", opts)

-- Packer
keymap("n", "<leader>ps", "<cmd>PackerSync<cr>", opts)

-- Move lines
-- Normal-mode commands
keymap("n", "<A-j>", ":MoveLine(1)<CR>", opts)
keymap("n", "<A-k>", ":MoveLine(-1)<CR>", opts)
keymap("n", "<A-h>", ":MoveHChar(-1)<CR>", opts)
keymap("n", "<A-l>", ":MoveHChar(1)<CR>", opts)

-- Visual-mode commands
keymap("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
keymap("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)
keymap("v", "<A-h>", ":MoveHBlock(-1)<CR>", opts)
keymap("v", "<A-l>", ":MoveHBlock(1)<CR>", opts)

-- Translator
keymap("n", "<C-t>", "<cmd>Pantran<CR>", opts)

-- Harpoon
keymap("n", "<leader>ht", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
keymap("n", "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)
keymap("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", opts)
keymap("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", opts)

-- unmapping
keymap("n", "<C-z>", "", fopts)
keymap("n", "<F1>", "", fopts)
