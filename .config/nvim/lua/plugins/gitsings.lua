return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      require('gitsigns').setup {
        auto_attach = true,
        signcolumn = true,
        signs = {
          add          = { text = '▏' },
          change       = { text = '▏' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
        },
      }
    end,
  },
}
