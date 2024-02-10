-- key mappings
vim.g.mapleader = " ";

-- line numbers
vim.keymap.set("n", "<leader>ln", ":set number!<CR>") -- toggle line numbers
vim.keymap.set("n", "<leader>lr", ":set relativenumber!<CR>") -- toggle relative line numbers

-- save
vim.keymap.set("n", "<C-s>", ":w<CR>") -- save/write

-- insert mode movements
vim.keymap.set("i", "<C-h>", "<Left>") -- move left
vim.keymap.set("i", "<C-j>", "<Down>") -- move down
vim.keymap.set("i", "<C-k>", "<Up>") -- move up
vim.keymap.set("i", "<C-l>", "<Right>") -- move right

-- window movements
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- page up centered
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- page down centered

vim.keymap.set("n", "<C-h>", "<C-w>h") -- move left
vim.keymap.set("n", "<C-j>", "<C-w>j") -- move down
vim.keymap.set("n", "<C-k>", "<C-w>k") -- move up
vim.keymap.set("n", "<C-l>", "<C-w>l") -- move right

-- window management
vim.keymap.set("n", "<leader>q", ":q<CR>") -- quit
vim.keymap.set("n", "<leader>Q", ":qa<CR>") -- quit all

-- diagnostics

vim.keymap.set("n", "<leader>dd", function() -- see document diagnostics
  require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>dw", function() -- see workspace diagnostics
  require("trouble").toggle({ mode = "workspace_diagnostics" })
end)
vim.keymap.set("n", "<leader>dl", function() -- see loclist diagnostics
  require("trouble").toggle({ mode = "loclist" })
end)

vim.keymap.set("n", "<leader>dn", function() -- go to next diagnostic
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "<leader>dN", function() -- go to previous diagnostic
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)

-- dap
vim.keymap.set("n", "<leader>du", function() -- run
  require("dapui").toggle()
end)
vim.keymap.set("n", "<leader>db", function() -- toggle breakpoint
  require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<leader>dc", function() -- continue
  require("dap").continue()
end)
vim.keymap.set("n", "<leader>di", function() -- restart
  require("dap").step_into()
end)
vim.keymap.set("n", "<leader>ds", function() -- step over
  require("dap").step_over()
end)
vim.keymap.set("n", "<leader>do", function() -- step out
  require("dap").step_out()
end)

-- bufferline tabs
-- local bufferline = require("bufferline")

-- close current tab
-- vim.keymap.set("n", "<leader>x", function() 
--   local state = require("bufferline.state")
-- 
--   local close_index, close_elem =  require("bufferline.commands").get_current_element_index(state)
-- 
--   -- bufferline tab buffer is not selected so don't continue
--   if not close_index then
--     return
--   end
-- 
--   if #state.components > 1 then
--     -- Get off the buffer we are about to close
--     bufferline.cycle(-1)
--   end
-- 
--   vim.schedule(function()
--     vim.cmd("bdelete! " .. close_elem.id)
--     require("bufferline.ui").refresh()
--   end)
-- end)

-- vim.keymap.set("n", "<TAB>", function() bufferline.cycle(1) end) -- cycle tab right
-- vim.keymap.set("n", "<S-TAB>", function() bufferline.cycle(-1) end) -- cycle tab left

-- misc 
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file tree
vim.keymap.set("n", "<leader>fe", ":NvimTreeFindFile<CR>") -- find file in file tree
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find Files" }) -- find files
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Live Grep" }) -- live grep

-- copilot mappings are in plugins.configs.copilot because they override ours im pretty sure

-- lsp mappings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" }) -- go to definition
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" }) -- go to references
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover" }) -- show hover
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" }) -- rename
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" }) -- code action

