return {
  {
    -- "ThePrimeagen/git-worktree.nvim",
    "awerebea/git-worktree.nvim",
    branch = "handle_changes_in_telescope_api",
    config = function()
      require("git-worktree").setup()
      local Worktree = require("git-worktree")

      -- op = Operations.Switch, Operations.Create, Operations.Delete
      -- metadata = table of useful values (structure dependent on op)
      --      Switch
      --          path = path you switched to
      --          prev_path = previous worktree path
      --      Create
      --          path = path where worktree created
      --          branch = branch name
      --          upstream = upstream remote name
      --      Delete
      --          path = path where worktree deleted

      Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Switch then
          vim.notify("Switched from " .. metadata.prev_path .. " to " .. metadata.path)

          if vim.bo.filetype == 'oil' then
            require('oil').open(metadata.path)
          end
        end
      end)
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
