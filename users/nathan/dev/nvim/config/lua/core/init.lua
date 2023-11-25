local opt = vim.opt

-- using lualine instead
opt.laststatus = 3 -- remove default status lines
opt.showmode = false -- don't show the mode
opt.ruler = false -- don't show cursor position in status line

opt.clipboard = "unnamedplus" -- use system clipboard
opt.cursorline = true -- highlight line the cursor is on

-- indenting, 2 space tabs
opt.expandtab = true -- we use tabs instead of spaces here
opt.shiftwidth = 2 -- set the auto indent width
opt.smartindent = true -- it's smart
opt.tabstop = 2 -- what a tab in a file means to nvim
opt.softtabstop = 2 -- when i click tab, this is how many spaces

-- line number
opt.number = true -- use relative line numbers (get lost in the sauce)
opt.numberwidth = 2 -- line number is 2 width

opt.ignorecase = true -- ignore case for searches
opt.smartcase = true -- be smart about ignoring case

-- key mappings
vim.g.mapleader = " ";

-- line numbers
vim.keymap.set("n", "<leader>ln", ":set number!<CR>") -- toggle line numbers
vim.keymap.set("n", "<leader>rn", ":set relativenumber!<CR>") -- toggle relative line numbers

-- save
vim.keymap.set("n", "<C-s>", ":w<CR>") -- save/write
vim.keymap.set("i", "<C-s>", ":w<CR>") -- save/write

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
vim.keymap.set("n", "<leader>ff", require("telescope.buildin").find_files, { desc = "Find Files" }) -- find files

-- copilot
vim.keymap.set("i", "<A-u>", require("copilot.suggestion").accept())
