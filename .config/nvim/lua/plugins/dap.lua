return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
      "folke/neodev.nvim",
    },
    config = function()
      require('dap-go').setup()
      require("dapui").setup()

      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    keys = {
      { "<F5>", function () require'dap'.continue() end},
      { "<F10>", function () require'dap'.step_over() end},
      { "<F11>", function () require'dap'.step_into() end},
      { "<F12>", function () require'dap'.step_out() end},
      { "<F9>", function () require'dap'.toggle_breakpoint() end},
      { "<leader>B", function () require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end},
      { "<leader>lp", function () require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end},
      { "<leader>dr", function () require'dap'.repl.open() end},
      { "<leader>dl", function () require'dap'.run_last() end},
    }
  }
}
