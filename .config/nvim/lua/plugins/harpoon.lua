return {
  "ThePrimeagen/harpoon",
  lazy = false,
  config = function()
    require("harpoon").setup({
        nav_first_in_list = true,
        projects = {
            ["/home/mikhail/go/src/sfa.git/"] = {
                term = {
                    cmds = {
                        'make build_all && make restart',
                    }
                }
            }
        }
    })

    vim.keymap.set("n", "<leader>h", require("harpoon.mark").add_file)
    vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu)
    vim.keymap.set("n", "<leader>tc", require("harpoon.cmd-ui").toggle_quick_menu)
    vim.keymap.set("n", "<space>j", function() require("harpoon.ui").nav_file(1) end)
    vim.keymap.set("n", "<space>k", function() require("harpoon.ui").nav_file(2) end)
    vim.keymap.set("n", "<space>l", function() require("harpoon.ui").nav_file(3) end)
    vim.keymap.set("n", "<space>;", function() require("harpoon.ui").nav_file(4) end)
  end,
}
