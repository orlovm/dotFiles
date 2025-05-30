return {
  {
    "rcarriga/nvim-notify",
    config = function()
      require('notify').setup({
        level = vim.log.levels.INFO,
        merge_duplicates = true,
        timeout = 2500,
        background_colour = "NotifyBackground",
        minimum_width = 50,
        fps = 30,
        top_down = true,
        time_formats = {
          notification_history = "%FT%T",
          notification = "%T",
        },
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        }
      })
      vim.notify = require("notify")
    end,
    priority = 1000,
   lazy = false,
  },
}
