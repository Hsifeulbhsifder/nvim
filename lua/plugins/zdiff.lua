return {
  "martindur/zdiff.nvim",
  cmd = "Zdiff",
  config = function()
    require("zdiff").setup({})

    local function set_diff_hl()
      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#374539" })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#453737" })
    end

    set_diff_hl()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_diff_hl })
  end,
  keys = {
    {
      "<leader>zd",
      function()
        local last_branch = vim.g.zdiff_last_branch or ""
        vim.ui.input({ prompt = "Diff against branch: ", default = last_branch }, function(branch)
          if branch then
            vim.g.zdiff_last_branch = branch
            vim.cmd("Zdiff " .. branch)
          end
        end)
      end,
      desc = "Diff <branch>",
    },
  },
}
