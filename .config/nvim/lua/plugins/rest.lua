return {
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = true,
    keys = {
      {
        "<leader>rr", "<cmd>Rest run<cr>", "Run request under the cursor",
      },
      {
        "<leader>rl", "<cmd>Rest run last<cr>", "Re-run latest request",
      },
    }
  }
}
