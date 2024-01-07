local function fugitive_branch()
  local icon = ''
  return icon .. ' ' .. vim.fn.FugitiveHead()
end
local function get_short_cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

local function db()
  local icon = ''
  return icon .. ' DBUI'
end

local transform_line = function(line)
  return line:gsub("%s*[%[%(%{]*%s*$", "")
end

local function current_treesitter_context()
  local f = require'nvim-treesitter'.statusline({
    indicator_size = 300,
    type_patterns = {"function", "method"},
    trensfor_fn = transform_line
  })
  local context = string.format("%s", f) -- convert to string, it may be a empty ts node

  if context == "vim.NIL" then
    return ""
  end
  return "f: " .. context

end

local blame = { sections = { lualine_a = { fugitive_branch }, lualine_z = { 'location' } }, filetypes = {'fugitiveblame'} }
local db = { sections = { lualine_a = { db }}, filetypes = {'dbui'} }
local nnp = { sections = {}, filetypes = {'no-neck-pain'} }
require('lualine').setup {
  extensions = {'neo-tree', 'fzf', 'fugitive', blame, db, nnp},
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diagnostics'},
    lualine_c = {{ 'filename', path = 1 }},
    lualine_x = {'filetype', {'diagnostics', sources = {'nvim_workspace_diagnostic'}, sections = {'error'}}},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  }
