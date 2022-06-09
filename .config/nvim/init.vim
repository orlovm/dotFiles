"##############################################################################"
"######################### github.com/OrlovM's vimrc ##########################"
"##############################################################################"


"################################ Vim settings ################################"

", is closer...
let mapleader = ","

autocmd ColorScheme * highlight ColorColumn ctermbg=NONE guibg=NONE
" autocmd ColorScheme * highlight signcolumn ctermbg=NONE


"Fix Sizing Bug With Alacritty Terminal
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

autocmd FileType go,js,vim setlocal colorcolumn=81
set termguicolors



"##############################################################################"
"################################## Plugins ###################################"
"##############################################################################"

call plug#begin('~/.nvim/plugged')

"Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'

Plug 'mbbill/undotree'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lukas-reineke/virt-column.nvim'
Plug 'nvim-lua/plenary.nvim'
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
Plug 'b4b4r07/vim-sqlfmt', { 'do': 'pip install sqlparse' }

Plug 'chrisbra/csv.vim'

" DB UI
Plug 'kristijanhusak/vim-dadbod-ui', {'on': 'DBUIToggle'}
Plug 'kristijanhusak/vim-dadbod-completion'

" Color scheme
Plug 'junegunn/seoul256.vim'

"test
Plug 'luisiacc/gruvbox-baby'
Plug 'sainnhe/sonokai'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'


" SplitJoin
Plug 'AndrewRadev/splitjoin.vim'

" Navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Git status for files in NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'
"auto update buffer
Plug 'https://github.com/chrisbra/vim-autoread.git' 

"lsp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-cmdline'

Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'tamago324/cmp-zsh'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
"' Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'onsails/lspkind-nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'tjdevries/colorbuddy.nvim'
" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
" Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'
" Easy selection pairs via `viv` and `vav`
Plug 'gorkunov/smartpairs.vim'

Plug 'stevearc/dressing.nvim'
" Insert pairs [ -> []
Plug 'jiangmiao/auto-pairs'
" Highlight hex colors like #ff0000 with :ColorHighlight
Plug 'chrisbra/color_highlight'
Plug 'mkitt/tabline.vim'
" Show additiona/deletions/modifications 
"Plug 'airblade/vim-gitgutter'
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
map <leader>r :so $MYVIMRC<CR>

"write
nnoremap <leader>w :w<CR>

"
nnoremap <leader>u :UndotreeToggle<CR>

nnoremap <Space> <PageDown>

"Line text objects
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o^
onoremap al :normal val<CR>

"Harpoon
nnoremap <silent><leader>h :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent><C-e> :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent><leader>tc :lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>

nnoremap <silent><space>h :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><space>j :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><space>k :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><space>l :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <silent>[h :lua require("harpoon.ui").nav_prev()<CR>
nnoremap <silent>]h :lua require("harpoon.ui").nav_next()<CR>

imap kj <Esc>

"##############################################################################"
"############################## Plugins config ################################"
"##############################################################################"
"sneak
let g:sneak#label = 1

"DBUI
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_show_database_icon = 1

"git blame config
nnoremap gb :<C-u>call gitblame#echo()<CR>

" DBUI
nnoremap <leader>d :DBUIToggle<CR>

"SQL formatter config
let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -k upper"
"let g:sqlfmt_auto = 0


" nerd-tree config
nnoremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeAutoCenter          = 1
let g:NERDTreeAutoCenterThreshold = 8
let g:NERDTreeChDirMode           = 2
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeIgnore              = [
  \ '.git$[[dir]]', 'target$[[dir]]', '.idea$[[dir]]',
  \ '\.iml$[[file]]', 'build$[[dir]]',
  \ ]
let g:NERDTreeStatusline          = -1
let g:NERDTreeWinSize             = 40
let g:NERDTreeShowHidden          = 1
let g:NERDTreeShowLineNumbers     = 0
let g:NERDTreeMinimalUI           = 1

augroup NERDTree
  autocmd!
  " open NERDTree if open directory
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
  " close NERDTree if it's a last window
  autocmd BufEnter * nested if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
  autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 2 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
  autocmd DirChanged * NERDTreeCWD
augroup END


" seoul256 config
" let g:seoul256_background = 235
" let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_sign_column_background = 'none'
" let g:gruvbox_material_disable_italic_comment = 1
colorscheme gruvbox-material
let g:seoul256_srgb = 1
" hi StatusLine ctermfg=236
" hi StatusLineNC ctermfg=236

filetype plugin indent on  

nnoremap <CR> :noh<CR><CR>

lua << END
  require 'mikhail.lsp'
END
