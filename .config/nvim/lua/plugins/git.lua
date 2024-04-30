return {
  {
    "tpope/vim-fugitive",
    init = function()
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
