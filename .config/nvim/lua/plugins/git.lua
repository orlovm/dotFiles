return {
  {
    "tpope/vim-fugitive",
    init = function()
    vim.api.nvim_create_user_command('Gfetch', function() vim.cmd("G fetch -u origin 'refs/heads/*:refs/heads/*'") end, {})
    end,
    cmd = "G",
  },
  {
    "rbong/vim-flog",
    cmd = "Flog",
  },
  {
    "zivyangll/git-blame.vim",
    keys = {
      { "gb", [[:<C-u>call gitblame#echo()<CR>]], { noremap = true, silent = true } }
    },
  },
}
