return {
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("hardtime").setup(
        {
          disabled_filetypes = { "dbout", "dbui", "neo-tree", "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
          disable_mouse = false,
          allow_different_key = true,
        }
      )
    end,
  },
}
