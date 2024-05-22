vim.opt.updatetime = 50
vim.g.mapleader = ","
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undo"

vim.opt.expandtab = true

vim.opt.swapfile = false

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.wildmode = { "longest", "list", "full" }

vim.opt.shortmess:append("c")

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"

vim.opt.scrolljump = 8
vim.opt.scrolloff = 8

vim.opt.pumblend = 15
vim.opt.winblend = 10

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 25

vim.opt.fillchars = {
  vert = '▕',
  eob = ' '
}
