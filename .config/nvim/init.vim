"##############################################################################"
"######################### github.com/OrlovM's init.vim #######################"
"##############################################################################"


"################################ Vim settings ################################"
let mapleader = ","

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'cd '.argv()[0] | endif

"Fix Sizing Bug With Alacritty Terminal
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

autocmd FileType go,js,vim setlocal colorcolumn=81
set termguicolors

"##############################################################################"
"################################## Plugins ###################################"
"##############################################################################"

call plug#begin('~/.nvim/plugged')
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'pwntester/octo.nvim'
Plug 'jbyuki/venn.nvim'
Plug 'shortcuts/no-neck-pain.nvim', { 'branch': 'v1.7.0' }
Plug 'ThePrimeagen/vim-be-good'
Plug 'edolphin-ydf/goimpl.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'nvim-lua/popup.nvim'
"Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'

Plug 'mbbill/undotree'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/virt-column.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'ThePrimeagen/harpoon'

Plug 'tpope/vim-unimpaired'

"Git plugins
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog', {'on': 'Flog'}
Plug 'idanarye/vim-merginal', {'on': 'Merginal'}
Plug 'zivyangll/git-blame.vim'
" GoLang support
Plug 'ray-x/go.nvim'

" Some vim defaults
Plug 'tpope/vim-sensible'

" DB
Plug 'tpope/vim-dadbod'
" Plug 'b4b4r07/vim-sqlfmt', { 'do': 'pip install sqlparse' }
Plug 'pbogut/vim-dadbod-ssh'

Plug 'chrisbra/csv.vim'

" DB UI
Plug 'kristijanhusak/vim-dadbod-ui', {'on': 'DBUIToggle'}
Plug 'kristijanhusak/vim-dadbod-completion'

" Color scheme
Plug 'sainnhe/gruvbox-material'

" SplitJoin
Plug 'Wansmer/treesj'

" Navigation
Plug 'stevearc/oil.nvim'
" Plug 'nvim-neo-tree/neo-tree.nvim'
"auto update buffer
Plug 'https://github.com/chrisbra/vim-autoread.git' 

"lsp
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'b0o/schemastore.nvim'

Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'tamago324/cmp-zsh'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'saadparwaiz1/cmp_luasnip'

" Easy selection pairs via `viv` and `vav`
Plug 'gorkunov/smartpairs.vim'

Plug 'stevearc/dressing.nvim'
Plug 'altermo/ultimate-autopair.nvim', {'branch': 'v0.6'}
" Highlight hex colors like #ff0000 with :ColorHighlight
Plug 'chrisbra/color_highlight'
Plug 'mkitt/tabline.vim'
" Show additiona/deletions/modifications 
Plug 'lewis6991/gitsigns.nvim'
" sneak
Plug 'justinmk/vim-sneak'
" scriptease.vim: A Vim plugin for Vim plugins
Plug 'tpope/vim-scriptease'
" Licenser plugin
Plug 'g4s8/vim-licenser'
" Comment lines in source files
Plug 'tpope/vim-commentary'
" Handlebars
Plug 'mustache/vim-mustache-handlebars'
" parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'
"uppercase SQL
Plug 'jsborjesson/vim-uppercase-sql'
Plug 'tpope/vim-repeat'
Plug 'ThePrimeagen/git-worktree.nvim'

" backticks textobj
Plug 'https://github.com/kana/vim-textobj-user'
Plug 'https://github.com/fvictorio/vim-textobj-backticks'

Plug 'rest-nvim/rest.nvim'
Plug 'zbirenbaum/copilot.lua'
Plug 'zbirenbaum/copilot-cmp'
" Plug 'simrat39/inlay-hints.nvim'
Plug 'folke/neodev.nvim'
Plug 'lambdalisue/suda.vim'
Plug 'm4xshen/hardtime.nvim'
Plug 'tzachar/highlight-undo.nvim'
call plug#end()


"##############################################################################"
"################################## Mappings ##################################"
"##############################################################################"


" DAP
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

"Mapping tab character to Shift+Tab
inoremap <S-Tab> <C-V><Tab>

"TAB = indent, Shift+TAB = dedent
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

"(r)eload vimrc
map <silent> <leader>r :so $MYVIMRC<CR>

"write
nnoremap <silent> <leader>w :w<CR>

"
nnoremap <silent> <leader>u :UndotreeToggle<CR>

"Line text objects
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o^
onoremap al :normal val<CR>

"Rest
nnoremap <leader>rr <Plug>RestNvim
nnoremap <leader>rp <Plug>RestNvimPreview
nnoremap <leader>rl <Plug>RestNvimLast

"Harpoon
nnoremap <silent><leader>h :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

nnoremap <silent><space>j :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><space>k :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><space>l :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><space>; :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <silent>[h :lua require("harpoon.ui").nav_prev()<CR>
nnoremap <silent>]h :lua require("harpoon.ui").nav_next()<CR>

"luasnip
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'

" " greatest remap ever
" xnoremap <leader>p \_dP

" " next greatest remap ever : asbjornHaland
" nnoremap<leader>y \+y
" vnoremap<leader>y \+y
" nmap <leader>Y \+Y

" nnoremap("<leader>d", "\"_d")
" vnoremap("<leader>d", "\"_d")

" vnoremap("<leader>d", "\"_d")

"##############################################################################"
"############################## Plugins config ################################"
"##############################################################################"
"sneak
let g:sneak#label = 1

"DBUI
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_show_database_icon = 1

"git blame config
nnoremap <silent> gb :<C-u>call gitblame#echo()<CR>

" DBUI
nnoremap <silent> <space>d :DBUIToggle<CR>

" nnoremap <silent> <C-n> :NeoTreeRevealToggle<CR>

"SQL formatter config
let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -k upper"
"let g:sqlfmt_auto = 0
" let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_sign_column_background = 'none'
" let g:gruvbox_material_disable_italic_comment = 1
colorscheme gruvbox-material

filetype plugin indent on  

nnoremap <silent> <CR> :noh<CR><CR>

lua << END
  require 'mikhail.lsp'
  vim.api.nvim_set_keymap('n', '<leader>im', [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]], {noremap=true, silent=true})
END

set runtimepath^=~/.config/nvim/lua/fox
command! GitLabIssues lua require('fox.telescope').gitlab_issues()
command! GitLabMr lua require('fox.commands').get_merge_requests()
 " autocmd CursorHold,CursorHoldI * lua require('code_action').code_action_listener1()
 
highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
highlight! link NeoTreeDirectoryName NvimTreeFolderName
highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
highlight! link NeoTreeRootName NvimTreeRootFolder
highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
highlight! link NeoTreeNormal Normal
highlight! link NeoTreeEndOfBuffer NvimTreeFolderIcon

lua << END
  local augroup = vim.api.nvim_create_augroup
  local autocmd = vim.api.nvim_create_autocmd
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

  vim.keymap.set("n", "<C-d>", "<C-d>zz")
  vim.keymap.set("n", "<C-u>", "<C-u>zz")
  vim.keymap.set("n", "n", "nzzzv")
  vim.keymap.set("n", "N", "Nzzzv")
  vim.keymap.set("x", "<leader>p", [["_dP]])
  vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
  vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

  vim.keymap.set("n", "i", function()
    if #vim.fn.getline(".") == 0 then
      return [["_cc]]
    else
      return "i"
    end
  end, { expr = true, desc = "properly indent on empty line when insert" })
END


command! Gfetch :G fetch -u origin 'refs/heads/*:refs/heads/*'
