local curl = require('plenary.curl')
-- local git = require('fox.git')
local glab = require('fox.glab')
local utils = require('fox.utils')
local graphql = require('fox.glab.graphql')
-- local conf = require('fox.config')

local M = {}

-- Get the GitLab issues for the current repository


function M.get_gitlab_issues(callback)
  -- local url = string.format('%s/projects/%s/issues', conf.gitlab_api_base, conf.project_id)
  local url = string.format('%s/v4/projects/%s/issues', 'gitlab.com', '32117495')

  local response = curl.get(url, {
    headers = {
      -- ["PRIVATE-TOKEN"] = conf.private_token,
      ["PRIVATE-TOKEN"] =  'glpat-2Cs2ULMu-djzyXE4wqn4',
    },
  })

  if response.status >= 400 then
    print(url)
    print("Error: ", response.status)
    print("Error: ", response.body)
    return
  end

  local issues = vim.fn.json_decode(response.body)
  callback(issues)
end
-- function M.get_gitlab_merge_requests(callback)
--   glab.run({
--     args = {'api', 'projects/:id/merge_requests'},
--     cb = function(output, stderr)
--       if stderr and not utils.is_blank(stderr) then
--         utils.error(stderr)
--       elseif output then
--         local merge_requests = vim.fn.json_decode(output)
--         callback(merge_requests)
--       end
--     end,
--   })
-- end

function M.get_gitlab_merge_requests(callback)
  utils.info("Getting merge requests...")
  glab.run({
    args = {'api', 'graphql',  '--paginate', '-f', 'query='..graphql('mrs_query', 'orlovma/1') },
    cb = function(output, stderr)
      if stderr and not utils.is_blank(stderr) then
        utils.error(stderr)
      elseif output then
        local resp = utils.aggregate_pages(output, "data.project.mergeRequests.nodes")
        local merge_requests = resp.data.project.mergeRequests.nodes
        if #merge_requests == 0 then
          utils.error(string.format("There are no matching merge requests in %s.", opts.repo))
          return
        end
        callback(merge_requests)
      end
    end,
  })
end
-- function M.get_gitlab_merge_requests(callback)
--   local url = string.format("%s/v4/projects/%s/merge_requests?state=opened", 'https://www.gitlab.com',  '32117495')

--   local response = curl.get(url, {
--     headers = {
--       -- ["PRIVATE-TOKEN"] = conf.private_token,
--       ["PRIVATE-TOKEN"] =  'glpat-2Cs2ULMu-djzyXE4wqn4',
--     },
--   })

--   if response.status >= 400 then
--     print(url)
--     print("Error: ", response.status)
--     print("Error: ", response.body)
--     return
--   end

--   -- print(response.body)
--   local merge_requests = vim.fn.json_decode(response.body)
--     callback(merge_requests)
-- end

return M
