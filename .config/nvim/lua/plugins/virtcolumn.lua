return {
  {
    "lukas-reineke/virt-column.nvim",
    lazy = false,
    config = function()
      require("virt-column").setup { char = "▏" }
    end,
  },

}
