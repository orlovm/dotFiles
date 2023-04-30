local glab = require "fox.glab"
local graphql = require "fox.glab.graphql"
local writers = require "fox.writers"
local utils = require "fox.utils"
local previewers = require "telescope.previewers"
local ts_utils = require "telescope.utils"
local defaulter = ts_utils.make_default_callable

local issue = defaulter(function(opts)
  return previewers.new_buffer_previewer {
    title = "Merge Request Preview",
    get_buffer_by_name = function(_, entry)
      return entry.value
    end,
    define_preview = function(self, entry)
      local bufnr = self.state.bufnr
      if self.state.bufname ~= entry.value or vim.api.nvim_buf_line_count(bufnr) == 1 then
        -- local number = entry.value
        -- local owner, name = utils.split_repo(entry.repo)
        local query
        if entry.kind == "issue" then
          query = graphql("issue_query", entry.value.id)
        elseif entry.kind == "pull_request" then
          query = graphql("mr_query", entry.value.id)
        end
        glab.run {
          args = { "api", "graphql", "-f", string.format("query=%s", query) },
          cb = function(output, stderr)
            if stderr and not utils.is_blank(stderr) then
              vim.api.nvim_err_writeln(stderr)
            elseif output and vim.api.nvim_buf_is_valid(bufnr) then
              local result = vim.fn.json_decode(output)
              local obj
              if entry.kind == "issue" then
                obj = result.data.issue
              elseif entry.kind == "pull_request" then
                obj = result.data.mergeRequest
              end
              writers.write_title(bufnr, obj.title, 1)
              writers.write_details(bufnr, obj)
              writers.write_body(bufnr, obj)
              writers.write_state(bufnr, obj.state:upper(), number)
              local reactions_line = vim.api.nvim_buf_line_count(bufnr) - 1
              writers.write_block(bufnr, { "", "" }, reactions_line)
              writers.write_reactions(bufnr, obj.reactionGroups, reactions_line)
              vim.api.nvim_buf_set_option(bufnr, "filetype", "octo")
            end
          end,
        }
      end
    end,
  }
end)




return {
  issue = issue,
}
