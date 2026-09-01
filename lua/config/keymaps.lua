-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

local opts = { noremap = true, silent = true }

keymap("n", "<leader>rc", ":Compile<CR>", opts)
keymap("n", "<leader>rr", ":Recompile<CR>", opts)
keymap("n", "<leader>rn", ":NextError<CR>", opts)
keymap("n", "<leader>rN", ":PrevError<CR>", opts)
keymap("n", "<leader>ut", function()
  vim.opt.scrolloff = 999 - vim.o.scrolloff
end, { desc = "Toggle scroll lock" })

local function toggle_hex()
  if vim.b.hex_mode then
    vim.api.nvim_clear_autocmds({ event = { "BufWritePre", "BufWritePost" }, buffer = 0 })
    vim.cmd("silent! %!xxd -r")
    vim.opt_local.binary = false
    vim.bo.filetype = ""
    vim.bo.modified = false
    vim.b.hex_mode = false
  else
    vim.opt_local.binary = true
    vim.cmd("silent! %!xxd")
    vim.bo.filetype = "xxd"
    vim.b.hex_mode = true

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        vim.cmd("silent! %!xxd -r")
      end,
    })
    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = 0,
      callback = function()
        vim.cmd("silent! %!xxd")
        vim.bo.modified = false
      end,
    })
  end
end

keymap("n", "<leader>hx", toggle_hex, { desc = "Toggle hex view (xxd)" })
