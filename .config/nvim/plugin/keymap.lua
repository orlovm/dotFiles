local kmap = vim.keymap.set
kmap("n", "<C-d>", "<C-d>zz")
kmap("n", "<C-u>", "<C-u>zz")
kmap("n", "n", "nzzzv")
kmap("n", "N", "Nzzzv")
kmap("x", "<leader>p", [["_dP]])
kmap({ "n", "v" }, "<leader>d", [["_d]])
kmap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
kmap("n", "<CR>", "<cmd>noh<CR><CR>")

kmap("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "properly indent on empty line when insert" })

