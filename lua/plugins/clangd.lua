return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.clangd = opts.servers.clangd or {}
      opts.servers.clangd.cmd = opts.servers.clangd.cmd or { "clangd" }
      opts.servers.clangd.cmd[1] = vim.fn.expand("~/tools/bin/clangd")
    end,
  },
}
