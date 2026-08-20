-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.autoformat = false

vim.opt.cinoptions = "g0,t0,(0" -- Example: no extra indent for visibility labels or parens
vim.opt.cindent = false
vim.opt.autoindent = false
vim.opt.smartindent = false
vim.opt.undofile = true
vim.opt.scrolloff = 989
vim.opt.tabstop = 4 -- A TAB character looks like 4 spaces
vim.opt.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.opt.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver75,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"
