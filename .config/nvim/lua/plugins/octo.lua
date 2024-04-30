return {
  {
    "pwntester/octo.nvim",
    config = function()
      require "octo".setup({
        suppress_missing_scope = {
          projects_v2 = true,
        }
      })
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
