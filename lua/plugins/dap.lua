return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()
      require("nvim-dap-virtual-text").setup() -- show variable values inline while debugging

      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: toggle [B]reakpoint on this line" })
      vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Debug: run until cursor line" })

      vim.keymap.set("n", "<leader>?", function()
        require("dapui").eval(nil, { enter = true })
      end, { desc = "Debug: evaluate variable under cursor" })

      vim.keymap.set("n", "<F1>", dap.continue, { desc = "Debug: start / continue" })
      vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug: step into function" })
      vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Debug: step over line" })
      vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debug: step out of function" })
      vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Debug: step back" })
      vim.keymap.set("n", "<F13>", dap.restart, { desc = "Debug: restart session (Shift+F1)" })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
}
