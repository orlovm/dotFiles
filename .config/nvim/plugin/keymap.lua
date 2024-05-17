local set = vim.keymap.set
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
set("x", "<leader>p", [["_dP]])
set({ "n", "v" }, "<leader>d", [["_d]])
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
set("n", "<leader>w", "<cmd>w<CR>")

set("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "properly indent on empty line when insert" })

set("n", "<CR>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.hlsearch:get() then
    vim.cmd.nohl()
    return ""
  else
    return "<CR>"
  end
end, { expr = true, desc = "toggle hlsearch if it's on, otherwise just do ender" })

set("n", "]d", vim.diagnostic.goto_next)
set("n", "[d", vim.diagnostic.goto_prev)

set('n', '<space>e', vim.diagnostic.open_float)
set('n', '<space>q', vim.diagnostic.setloclist)
