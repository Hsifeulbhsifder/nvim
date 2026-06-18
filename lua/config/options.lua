-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.cinoptions = "g0,t0,(0" -- Example: no extra indent for visibility labels or parens
vim.o.cindent = false
vim.o.autoindent = false
vim.o.smartindent = false
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver75,r-cr-o:hor20,t:block-blinkon500-blinkoff500-TermCursor"
