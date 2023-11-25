-- key mappings
vim.g.mapleader = " ";

-- line numbers
vim.keymap.set("n", "<leader>ln", ":set number!<CR>") -- toggle line numbers
vim.keymap.set("n", "<leader>rn", ":set relativenumber!<CR>") -- toggle relative line numbers

-- save
vim.keymap.set("n", "<C-s>", ":w<CR>") -- save/write

-- insert mode movements
vim.keymap.set("i", "<C-h>", "<Left>") -- move left
vim.keymap.set("i", "<C-j>", "<Down>") -- move down
vim.keymap.set("i", "<C-k>", "<Up>") -- move up
vim.keymap.set("i", "<C-l>", "<Right>") -- move right

-- window movements
vim.keymap.set("n", "<C-h>", "<C-w>h") -- move left
vim.keymap.set("n", "<C-j>", "<C-w>j") -- move down
vim.keymap.set("n", "<C-k>", "<C-w>k") -- move up
vim.keymap.set("n", "<C-l>", "<C-w>l") -- move right

-- window management
vim.keymap.set("n", "<leader>q", ":q<CR>") -- quit
vim.keymap.set("n", "<leader>Q", ":qa<CR>") -- quit all

-- "programs"
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file tree
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find Files" }) -- find files

-- copilot mappings are in plugins.configs.copilot because they override ours im pretty sure

