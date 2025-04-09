vim.opt.number = true
vim.g.have_nerd_font = true
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.opt.background = "dark"
vim.opt.termguicolors = true

-- vim.cmd("colorscheme base46-chocolate")
-- vim.cmd("colorscheme ef-dream")
vim.cmd("colorscheme ef-dark")
