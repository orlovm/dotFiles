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
    -- vim.cmd('BufferCloseAllButCurrent')
    -- vim.cmd('e')
  end
end)