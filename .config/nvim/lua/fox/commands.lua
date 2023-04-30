local picker = require('fox.telescope.telescope')

local M = {}

function M.get_merge_requests()
  picker.gitlab_merge_requests()
end

return M
