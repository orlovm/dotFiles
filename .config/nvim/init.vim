"##############################################################################"
"######################### github.com/OrlovM's vimrc ##########################"
"##############################################################################"


"################################ Vim settings ################################"
"no beep
set visualbell
"Unicode
scriptencoding utf-8
set encoding=utf-8
" Not compatible with vi
set nocompatible
set noswapfile
" Undo
set undodir=$HOME/.vim/undo   
set undofile
" Syntax detection
syntax on
" Give more space for displaying messages.
"set cmdheight=2
" Highlight search
set hlsearch
" Completion
set completeopt=menu,menuone,noselect
" Menu config
set wildmode=longest,list,full
" set wildmode=
" Backspace behaviour
" indent  allow backspacing over autoindent
" eol     allow backspacing over line breaks (join lines)
" start   allow backspacing over the start of insert; CTRL-W and CTRL-U
"         stop once at the start of insert.
set backspace=indent,eol,start
" No backup files
set nobackup
" History size
set history=500 
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
"show the cursor position
set ruler
"display incomplete commands
set showcmd
" Show matched pattern when typing search command
set incsearch
" smart search case
set ignorecase smartcase
" set signcolumn=yes
" Set split separator to Unicode box drawing character
if has('nvim')
  set fillchars=vert:▕,eob:\ 
  set noshowmode
endif

" Override color scheme to make split the same color as tmux's default
" autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=NONE ctermbg=NONE
autocmd ColorScheme * highlight ColorColumn ctermbg=NONE
autocmd ColorScheme * highlight signcolumn ctermbg=NONE
" autocmd ColorScheme * set pumblend=15
" autocmd ColorScheme * set winblend=15
" autocmd ColorScheme * highlight VirtColumn ctermfg=234
"use system + clipboard
set clipboard+=unnamedplus
set clipboard+=unnamed
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Mouse config
if has('mouse')
  set mouse=a
endif

" Scrolling config
set scrolljump=8
set scrolloff=8

"Fix Sizing Bug With Alacritty Terminal
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

autocmd FileType go,js,vim setlocal colorcolumn=81

" Tabs config
set expandtab
set shiftwidth=2
set smarttab

" Use external .vimrc in current folder root
set exrc
" Forbid buffer writing, shell commands
" and autocmd from local dir .vimrc files
set secure

set nu nornu
" show line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END


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
Plug 'fannheyward/telescope-coc.nvim'
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
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

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

", is closer...
let mapleader = ","

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

" Arrows
nnoremap <left> b
nnoremap <right> e
nnoremap <up> <PageUp>
nnoremap <down> <PageDown>
inoremap <S-left> ←
inoremap <S-right> →
inoremap <S-up> ↑
inoremap <S-down> ↓

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

autocmd FileType go nmap <leader>e :GoIfErr<CR>

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

" Telescope config
if has('nvim')
lua <<EOF
  require("telescope").setup {
  }
  require("telescope").load_extension("git_worktree")
EOF
  command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})
endif

nmap <silent> gr :Telescope lsp_references<CR>

map <leader>bb :Telescope buffers<CR>
map <leader>bd :BD<CR>

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

lua << END
require("virt-column").setup{ char = "▏" }
END

augroup NERDTree
  autocmd!
  " open NERDTree if open directory
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
  " close NERDTree if it's a last window
  autocmd BufEnter * nested if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
  autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
augroup END


" seoul256 config
" let g:seoul256_background = 235
colorscheme gruvbox-material
let g:seoul256_srgb = 1
" hi StatusLine ctermfg=236
" hi StatusLineNC ctermfg=236

filetype plugin indent on  

"Find files
nnoremap <silent> <C-p> :Telescope fd<CR>
nnoremap <silent> <Leader>f :Telescope grep_string<CR>
nnoremap <silent> <Leader>g :Tgrep<CR>
"Find (t)ags
nnoremap <silent> <Leader>t :Telescope lsp_document_symbols<CR>


if has('nvim')
lua << END
  require 'mikhail.lsp'
  -- require('gitsigns').setup()
END
endif
