vim.g.mapleader = ","
vim.opt.termguicolors = true

require "mikhail.disable_builtin"

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

autocmd("StdinReadPre", {
  pattern = "*",
  callback = function()
    vim.g.std_in = 1
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

require 'mikhail.lsp'

local yank_group = augroup('HighlightYank', {})
autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'Search',
      timeout = 100,
    })
  end,
})


command('Gfetch', function() vim.cmd("G fetch -u origin 'refs/heads/*:refs/heads/*'") end, {})

autocmd('FileType', {
  pattern = { "go", "js", "vim", "lua" },
  callback = function()
    vim.api.nvim_set_option_value("colorcolumn", "81", {scope = "local"})
  end,
})
