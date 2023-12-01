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

opt.termguicolors = true -- enable the good colors

vim.cmd("highlight Normal guibg=none") -- transparent background

opt.cmdheight = 0;
vim.api.nvim_create_autocmd({ "RecordingEnter" }, {
  callback = function()
    vim.cmd("set cmdheight=1")
  end
})
vim.api.nvim_create_autocmd({ "RecordingLeave" }, {
  callback = function()
    vim.cmd("set cmdheight=0")
  end
})
