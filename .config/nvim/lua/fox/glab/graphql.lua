local M = {}

M.mr_query = [[
query {
  mergeRequest(id: "%s") {
    id
    iid
    title
    author {
      username
    }
    project {
      fullPath
    }
    state
    createdAt
    updatedAt
    description
    targetBranch
    sourceBranch
    webUrl
  }
}
]]

M.mrs_query = [[
query($endCursor: String) {
  project(fullPath: "%s") {
    name
    mergeRequests (first: 100, after: $endCursor) {
      pageInfo {
        # type: PageInfo (from the public schema)
        endCursor
        hasNextPage
      }
      nodes {
        id
        iid
        title
        state
        author {
          name
          username
        }
      }
    }
  }
}
]]
local function escape_char(string)
  local escaped, _ = string.gsub(string, '["\\]', {
    ['"'] = '\\"',
    ["\\"] = "\\\\",
  })
  return escaped
end

return function(query, ...)
  local opts = { escape = true }
  for _, v in ipairs { ... } do
    if type(v) == "table" then
      opts = vim.tbl_deep_extend("force", opts, v)
      break
    end
  end
  local escaped = {}
  for _, v in ipairs { ... } do
    if type(v) == "string" and opts.escape then
      local encoded = escape_char(v)
      table.insert(escaped, encoded)
    else
      table.insert(escaped, v)
    end
  end
  return string.format(M[query], unpack(escaped))
end
