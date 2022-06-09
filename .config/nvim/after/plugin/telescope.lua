require("telescope").setup {
}
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("harpoon")
require('telescope').load_extension('fzf')

local opts = { noremap = true, silent = true }

-- Grep string from ui input
local function grep(input)
  if input == nil then
    return
  end
  require 'telescope.builtin'.grep_string({ search = input })
end

function grepUI()
  vim.ui.input( { prompt =  "Grep For > ", kind = "grep" }, grep)
end

-- Mappings

-- Vim
vim.api.nvim_set_keymap("n", "<leader>bb", "<cmd>:Telescope buffers<CR>", opts)

-- Git
vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>:Telescope git_branches", opts)
vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>:Telescope git_status", opts)

-- Search
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>:Telescope fd<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>:Telescope grep_string<CR>", opts)

-- LSP
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>:Telescope lsp_document_symbols<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>:Telescope lsp_references<CR>", opts)