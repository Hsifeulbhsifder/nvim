return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {
    file_types = { "markdown" },
    completions = { lsp = { enabled = true } },
    heading = {
      sign = false,
      width = "block",
      left_pad = 1,
      right_pad = 2,
    },
    code = {
      sign = false,
      width = "block",
      right_pad = 2,
    },
    checkbox = {
      unchecked = { icon = "󰄱 " },
      checked = { icon = "󰡖 " },
    },
  },
  keys = {
    { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown" },
  },
}