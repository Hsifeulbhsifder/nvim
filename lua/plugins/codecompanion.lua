return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
      "CodeCompanionCmd",
    },
    opts = {
      adapters = {
        http = {
          floodgate = function()
            return require("codecompanion.adapters.http").extend("anthropic", {
              env = {
                api_key = "cmd:/usr/local/bin/appleconnect getToken -C hvys3fcwcteqrvw3qzkvtk86viuoqv --token-type=oauth --interactivity-type=none -E prod -G pkce -o openid,dsid,accountname,profile,groups | awk '/oauth-id/ {print $2}'",
              },
              url = "https://floodgate.g.apple.com/api/anthropic/v1/messages",
              headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer ${api_key}",
                ["User-Agent"] = "codecompanion.nvim",
              },
              schema = {
                model = {
                  default = "anthropic.claude-opus-4-7",
                  choices = {
                    "anthropic.claude-opus-4-7",
                    "anthropic.claude-sonnet-4-6",
                    "anthropic.claude-opus-4-1",
                    "anthropic.claude-haiku-4-5",
                  },
                },
              },
            })
          end,
        },
      },
      interactions = {
        chat = { adapter = "floodgate" },
        inline = { adapter = "floodgate" },
        cmd = { adapter = "floodgate" },
        cli = {
          agent = "claude_code",
          agents = {
            claude_code = {
              cmd = "claude",
              args = {},
              description = "Claude Code CLI",
              provider = "terminal",
            },
          },
        },
      },
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.4,
          },
        },
      },
    },
    keys = {
      { "<leader>C", nil, desc = "CodeCompanion" },
      { "<leader>Cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle chat" },
      { "<leader>Ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Actions palette" },
      { "<leader>Ci", ":CodeCompanion ", mode = { "n", "v" }, desc = "Inline prompt" },
      { "<leader>Cq", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "Add selection to chat" },
      { "<leader>Cl", "<cmd>CodeCompanionCLI<cr>", mode = { "n", "v" }, desc = "Open Claude Code CLI" },
      { "<leader>CL", ":CodeCompanionCLI ", mode = { "n", "v" }, desc = "Send prompt to Claude Code CLI" },
    },
  },
}