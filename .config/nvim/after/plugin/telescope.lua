require("telescope").setup {
  defaults = {
    file_ignore_patterns = {"vendor"},
    layout_config = {
      width = 0.9
      -- other layout configuration here
    },
    -- other defaults configuration here
  },
}
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("harpoon")
require('telescope').load_extension('fzf')
require('telescope').load_extension'goimpl'
require("telescope").load_extension "file_browser"
local opts = { noremap = true, silent = true }

-- Grep string from ui input
local function grep(input)
  if input == nil then
    return
  end
  require 'telescope.builtin'.grep_string({ search = input })
end

function grepUI()
  vim.ui.input( { prompt =  "Grep", kind = "grep" }, grep)
end

-- Mappings

-- Vim
vim.api.nvim_set_keymap("n", "<leader>bb", "<cmd>:Telescope buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>km", "<cmd>:Telescope keymaps<CR>", opts)

-- Git
vim.api.nvim_set_keymap("n", "<leader>gb", "<cmd>:Telescope git_branches<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>:Telescope git_status<CR>", opts)

-- Search
vim.api.nvim_set_keymap("n", "<C-p>", "<cmd>:Telescope fd<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>:Telescope grep_string<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>:Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua grepUI()<CR>", opts)

-- LSP
vim.api.nvim_set_keymap("n", "<leader>ds", "<cmd>:Telescope lsp_document_symbols<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>:Telescope lsp_references<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", "<cmd>:Telescope lsp_implementations<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>td", "<cmd>:lua require('telescope.builtin').diagnostics({sort_by = 'severity'})<CR>", opts)
