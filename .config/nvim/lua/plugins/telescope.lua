return {
  {
    "nvim-telescope/telescope.nvim",
    -- version = 'v0.1.5',
    config = function()
      require("telescope").setup {
        defaults = {
          file_ignore_patterns = { "vendor" },
          layout_config = { width = 0.9 },
        },
      }
      require("telescope").load_extension("git_worktree")
      require("telescope").load_extension("harpoon")
      require('telescope').load_extension('fzf')
      require('telescope').load_extension 'goimpl'

      local opts = { noremap = true, silent = true }

      -- Grep string from ui input
      local function grepUI()
        vim.ui.input({ prompt = "Grep", kind = "grep" }, function(input)
          if input == nil then
            return
          end
          require 'telescope.builtin'.grep_string({ search = input })
        end)
      end

      -- Mappings
      local builtin = require("telescope.builtin")

      -- Vim
      vim.keymap.set("n", "<leader>bb", builtin.buffers, opts)
      vim.keymap.set("n", "<leader>km", builtin.keymaps, opts)

      -- Git
      vim.keymap.set("n", "<leader>gb", builtin.git_branches, opts)
      vim.keymap.set("n", "<leader>gs", builtin.git_status, opts)

      -- Search
      vim.keymap.set("n", "<C-p>", builtin.find_files, opts)
      vim.keymap.set("n", "<leader>f", builtin.grep_string, opts)
      vim.keymap.set("n", "<leader>lg", builtin.live_grep, opts)
      vim.keymap.set("n", "<leader>gg", grepUI, opts)
      vim.keymap.set("n", "<leader>tr", builtin.resume, opts)

      -- LSP
      vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, opts)
      vim.keymap.set("n", "gr", function() builtin.lsp_references({ include_declaration = true }) end, opts)
      vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)
      vim.keymap.set("n", "<leader>td", function() builtin.diagnostics({ sort_by = "severity" }) end, opts)
      vim.keymap.set('n', '<leader>gw', require('telescope').extensions.git_worktree.git_worktrees, opts)
      vim.keymap.set('n', '<leader>gc', require('telescope').extensions.git_worktree.create_git_worktree, opts)
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
}
