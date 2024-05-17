return {
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_sign_column_background = 'none'
      vim.cmd.colorscheme('gruvbox-material')
    end,
  }
}
