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
local nerd = { sections = { lualine_a = { get_short_cwd } }, inactive_sections = { lualine_b = { get_short_cwd } }, filetypes = {'nerdtree'} }
local blame = { sections = { lualine_a = { fugitive_branch }, lualine_z = { 'location' } }, filetypes = {'fugitiveblame'} }
local db = { sections = { lualine_a = { db }}, filetypes = {'dbui'} }
require('lualine').setup { 
  extensions = {nerd, 'fzf', 'fugitive', blame, db},
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diagnostics'},
    lualine_c = {{ 'filename', path = 1 }},
    lualine_x = {'NearestMethodOrFunction', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  }
