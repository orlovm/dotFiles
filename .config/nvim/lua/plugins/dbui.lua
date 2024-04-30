return {
  {
    "tpope/vim-dadbod",
    dependencies = {
      "pbogut/vim-dadbod-ssh",
    },
    cmd = {
      "DB",
    },
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = {
      "DBUIToggle",
      "DBUI",
    },
    dependencies = {
      "kristijanhusak/vim-dadbod-completion",
      "tpope/vim-dadbod",
    },
    keys = {
      { "<space>d", [[<cmd>DBUIToggle<CR>]], { noremap = true, silent = true } }
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
    end,
  },
}
