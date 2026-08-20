local function launch(adapter_type)
  return function()
    local dap = require("dap")
    local configs = dap.configurations[vim.bo.filetype] or {}
    for _, cfg in ipairs(configs) do
      if cfg.type == adapter_type then
        dap.run(cfg)
        return
      end
    end
    vim.notify("No " .. adapter_type .. " configuration for filetype " .. vim.bo.filetype, vim.log.levels.WARN)
  end
end

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>dll", launch("lldb-dap"), desc = "Launch (lldb-dap)" },
      { "<leader>dld", launch("gdb"), desc = "Launch (gdb)" },
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run last",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- requires GDB >= 12, which speaks DAP natively via `-i=dap`
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" },
      }

      -- resolve via xcrun so it tracks whichever Xcode/CLT toolchain is selected
      local lldb_dap_path = vim.fn.trim(vim.fn.system("xcrun -f lldb-dap 2>/dev/null"))
      if vim.v.shell_error ~= 0 or lldb_dap_path == "" then
        lldb_dap_path = "lldb-dap"
      end
      dap.adapters["lldb-dap"] = {
        type = "executable",
        command = lldb_dap_path,
      }

      dap.configurations.c = {
        {
          name = "Launch (gdb)",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
        {
          name = "Launch (lldb-dap)",
          type = "lldb-dap",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.cpp = dap.configurations.c
    end,
  },
}
