return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    workspaces = {
      {
        name = "Apple",
        path = "/Users/zaeem/Library/Mobile Documents/com~apple~icloud~applecorporate/Documents/Apple",
      },
    },
    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },
    picker = { name = "snacks.pick" },
    ui = { enable = false },
    daily_notes = {
      folder = "Daily",
      date_format = "%Y.%m.%d",
    },
    disable_frontmatter = true,
  },
  keys = {
    { "<leader>o", nil, desc = "Obsidian" },
    { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch note" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search vault" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Tags" },
    { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Today's daily note" },
    { "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday's daily note" },
    { "<leader>of", "<cmd>Obsidian follow_link<cr>", desc = "Follow link under cursor" },
    { "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "Paste image" },
    { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename note" },
    { "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>Obsidian follow_link<cr>"
        end
        return "gf"
      end, expr = true, desc = "Follow link (Obsidian-aware)" },
  },
}