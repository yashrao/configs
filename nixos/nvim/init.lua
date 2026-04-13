
require("lspconfig")
require("plugins")

vim.opt.termguicolors = true
vim.cmd('colorscheme minicyan')
vim.cmd('set nowrap')

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.g.nowrap = true

vim.opt.updatetime = 300 -- doesn't seem to do anything
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "ga", ":b#\n", { desc = "Switch to previous buffer" })

vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
-- copying to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])
