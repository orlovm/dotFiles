local gitlab = require('fox.gitlab')
-- local telescope = require('telescope')
local entry_display = require "telescope.pickers.entry_display"
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local action_state = require("telescope.actions.state")
local previewers = require('fox.telescope.previewers')

local M = {}

local function issue_previewer(opts)
  return previewers.new_buffer_previewer {
    title = "Issue Preview",
    define_preview = function(self, entry)
      if not entry or not entry.value then
        return
      end

      -- Set up the preview buffer options
      vim.api.nvim_buf_set_option(self.state.bufnr, 'bufhidden', 'wipe')
      vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'markdown')

      local issue = entry.value
      local issue_details = {
        ('# %s'):format(issue.title),
        ('- ID: %s'):format(issue.iid),
        ('- State: %s'):format(issue.state),
        ('- Author: %s'):format(issue.author.username),
        ('- Created at: %s'):format(issue.created_at),
        ('- Web URL: %s'):format(issue.web_url),
        '',
        '## Description',
        '',
        issue.description,
      }

      -- Update the preview buffer with issue details
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, issue_details)
    end,
  }
end

local function mr_previewer(opts)
  return previewers.new_buffer_previewer {
    title = "Merge request Preview",
    define_preview = function(self, entry)
      if not entry or not entry.value then
        return
      end

      -- Set up the preview buffer options
      vim.api.nvim_buf_set_option(self.state.bufnr, 'bufhidden', 'wipe')
      vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'markdown')

      local mr = entry.value
      local issue_details = {
        ('# %s'):format(mr.title),
        ('- ID: %s'):format(mr.iid),
        ('- State: %s'):format(mr.state),
        ('- Author: %s'):format(mr.author.username),
        ('- Created at: %s'):format(mr.created_at),
        ('- Web URL: %s'):format(mr.web_url),
        '',
        '## Description',
        '',
        mr.description,
      }

      -- Update the preview buffer with issue details
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, issue_details)
    end,
  }
end

local function open_issue(prompt_bufnr)
  local entry = action_state.get_selected_entry(prompt_bufnr)
  actions.close(prompt_bufnr)
  local issue = entry.value

  -- Create a new empty buffer and set its options
  vim.cmd('enew')
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(bufnr, 'filetype', 'markdown')

  -- Insert the issue details into the new buffer
  local issue_details = {
    ('# %s'):format(issue.title),
    ('- ID: %s'):format(issue.iid),
    ('- State: %s'):format(issue.state),
    ('- Author: %s'):format(issue.author.name),
    ('- Created at: %s'):format(issue.created_at),
    ('- Web URL: %s'):format(issue.web_url),
    '',
    '## Description',
    '',
    issue.description,
  }
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, issue_details)
end

M.gitlab_issues = function()
  gitlab.get_gitlab_issues(function(issues)
    pickers.new({}, {
      prompt_title = 'GitLab Issues',
      finder = finders.new_table {
        results = issues,
        entry_maker = function(issue)
          return {
            value = issue,
            display = issue.title,
            ordinal = issue.title,
          }
        end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        map('i', '<CR>', function()
          open_issue(prompt_bufnr)
        end)

        return true
      end,
      previewer = issue_previewer(opts),
    }):find()
  end)
end

local function open_buffer(title, description, additional_details)
  -- Create a new empty buffer and set its options
  vim.cmd('enew')
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(bufnr, 'filetype', 'markdown')

  -- Insert the details into the new buffer
  local content = vim.list_extend(title, additional_details)
  content = vim.list_extend(content, description)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
end

local function open_merge_request(prompt_bufnr)
  local entry = action_state.get_selected_entry(prompt_bufnr)
  actions.close(prompt_bufnr)
  local mr = entry.value

  -- Format merge request details
  local title = {('# %s'):format(mr.title)}
  local additional_details = {
    ('- ID: %s'):format(mr.iid),
    ('- State: %s'):format(mr.state),
    ('- Author: %s'):format(mr.author.name),
    ('- Created at: %s'):format(mr.created_at),
    ('- Web URL: %s'):format(mr.web_url),
    '',
    '## Description',
    '',
  }
  local description = {mr.description}

  open_buffer(title, description, additional_details)
end

local function displayer_from_mr(results, print_repo)
  local max_number = -1
  for _, mr in ipairs(results) do
    if #tostring(mr.iid) > max_number then
      max_number = #tostring(mr.iid)
    end
  end

  local layout = { separator = " " }

  if print_repo then
    layout.items = {
        { width = max_number},
        { width = 35 },
        { remaining = true },
      }
  else
    layout.items = {
        { width = max_number},
        { remaining = true },
      }
  end
  return entry_display.create(layout)
end

local function gen_from_mr(displayer, print_repo)
  local make_display = function(entry)
    if not entry then
      return nil
    end

    local  columns
    -- TODO
    -- local icon = entry.value.state == "merged" and "" or entry.value.state ==  "closed" and "" or entry.value.state ==  "opened" and ""
    local icon = ""
    if print_repo then
      columns = {
        { entry.value.iid, "TelescopeResultsNumber" },
        { entry.repo, "OctoDetailsLabel" },
        { icon .. " " .. entry.value.title },
      }
    else
      columns = {
        { entry.value.iid, "TelescopeResultsNumber" },
        { icon .. " " .. entry.value.title },
      }
    end

    return displayer(columns)
  end

  return function(entry)
    if not entry or vim.tbl_isempty(entry) then
      return nil
    end
    local kind = entry.__typename == "Issue" and "issue" or "pull_request"
    local filename
    -- if kind == "issue" then
    --   filename = utils.get_issue_uri(obj.repository.nameWithOwner, obj.number)
    -- else
    --   filename = utils.get_pull_request_uri(obj.repository.nameWithOwner, obj.number)
    -- end
    return {
      filename = filename,
      kind = kind,
      value = entry,
      ordinal = entry.id .. " " .. entry.title,
      display = make_display,
      -- repo = obj.repository.nameWithOwner,
    }
  end
end

-- local function gen_from_mr(print_repo)
--   local make_display = function(entry)
--     if not entry then
--       return nil
--     end

--     local layout, columns
--     if print_repo then
--       columns = {
--         { entry.iid, "TelescopeResultsNumber" },
--         { entry.repo, "OctoDetailsLabel" },
--         { entry.obj.title },
--       }
--       layout = {
--         separator = " ",
--         items = {
--           { width = string.len( entry.value.id ) },
--           { width = 35 },
--           { remaining = true },
--         },
--       }
--     else
--       -- TODO
--       local icon = entry.value.state == "merged" and "" or entry.value.state ==  "closed" and "" or entry.value.state ==  "opened" and ""
--       columns = {
--         -- { entry.value.iid, "TelescopeResultsNumber" },
--         { entry.value.iid, "TelescopeResultsNumber" },
--         { icon .. " " .. entry.value.title },
--       }
--       layout = {
--         separator = " ",
--         items = {
--           -- { width = string.len( entry.value.iid ) },
--           { width =  string.len( entry.value.iid ) },
--           { remaining = true },
--         },
--       }
--     end

--     local displayer = entry_display.create(layout)

--     return displayer(columns)
--   end

--   return function(entry)
--     if not entry or vim.tbl_isempty(entry) then
--       return nil
--     end
--     local kind = entry.__typename == "Issue" and "issue" or "pull_request"
--     local filename
--     -- if kind == "issue" then
--     --   filename = utils.get_issue_uri(obj.repository.nameWithOwner, obj.number)
--     -- else
--     --   filename = utils.get_pull_request_uri(obj.repository.nameWithOwner, obj.number)
--     -- end
--     return {
--       filename = filename,
--       kind = kind,
--       value = entry,
--       ordinal = entry.id .. " " .. entry.title,
--       display = make_display,
--       -- repo = obj.repository.nameWithOwner,
--     }
--   end
-- end

M.gitlab_merge_requests = function()
  gitlab.get_gitlab_merge_requests(function(merge_requests)
    pickers.new({}, {
      prompt_title = "GitLab Merge Requests",
      finder = finders.new_table {
        results = merge_requests,
        -- TODO print repo
        -- entry_maker = gen_from_mr(),
        entry_maker = gen_from_mr(displayer_from_mr(merge_requests, false), false),
        -- entry_maker = function(mr)
        --   return {
        --     display = ('%s [%s]'):format(mr.title, mr.iid),
        --     ordinal = mr.title,
        --     value = mr
        --   }
        -- end
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        map('i', '<CR>', function()
          open_merge_request(prompt_bufnr)
        end)
        return true
      end,
      previewer = previewers.issue.new({}),
      -- previewer = mr_previewer(),
    }):find()
  end)
end


return M
