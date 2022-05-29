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
set signcolumn=yes
" Set split separator to Unicode box drawing character
if has('nvim')
  set fillchars=vert:▕,eob:\ 
  set noshowmode
endif

" Override color scheme to make split the same color as tmux's default
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=233 ctermbg=NONE
autocmd ColorScheme * highlight ColorColumn ctermbg=235
autocmd ColorScheme * highlight VirtColumn ctermfg=234
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

if has('nvim')
  call plug#begin('~/.nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Plug install coc extensions
function! InstallCocPlugs(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    :CocInstall coc-sh
    :CocInstall coc-go
    :CocInstall coc-db
    :CocInstall coc-tsserver
    :CocInstall coc-vetur
    :CocInstall coc-json
    :CocInstall coc-yaml
    :CocInstall coc-vimlsp
    :CocInstall coc-snippets
    :CocInstall coc-eslint
    :CocInstall coc-webview
    :CocInstall coc-markdown-preview-enhanced
    :CocInstall coc-spell-checker
    :CocInstall coc-cspell-dicts
    :CocInstall coc-pyright
    :CocInstall coc-lua
  endif
endfunction

"tagbar
Plug 'liuchengxu/vista.vim'

"Debugger
if has('nvim')
  Plug 'mfussenegger/nvim-dap'
  Plug 'leoluz/nvim-dap-go'
  Plug 'rcarriga/nvim-dap-ui'
endif
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'

Plug 'mbbill/undotree'

if has('nvim')
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  Plug 'fannheyward/telescope-coc.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  " If you want to have icons in your statusline choose one of these
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'lukas-reineke/virt-column.nvim'
  Plug 'nvim-lua/plenary.nvim' " don't forget to add this one if you don't have it yet!
  Plug 'ThePrimeagen/harpoon'
endif

" Fzf - finder
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-unimpaired'

"Git plugins
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog', {'on': 'Flog'}
Plug 'idanarye/vim-merginal', {'on': 'Merginal'}
Plug 'zivyangll/git-blame.vim'
" GoLang support
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Some vim defaults
Plug 'tpope/vim-sensible'

" Coc - completion. 
"Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': function('InstallCocPlugs')}

" DB
Plug 'tpope/vim-dadbod'
Plug 'b4b4r07/vim-sqlfmt', { 'do': 'pip install sqlparse' }

Plug 'chrisbra/csv.vim'

" DB UI
Plug 'kristijanhusak/vim-dadbod-ui', {'on': 'DBUIToggle'}

" Color scheme
Plug 'junegunn/seoul256.vim'

" SplitJoin
Plug 'AndrewRadev/splitjoin.vim'

" Navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Git status for files in NERDTree
Plug 'Xuyuanp/nerdtree-git-plugin'
if !has('nvim')
    "auto update buffer
    Plug 'https://github.com/chrisbra/vim-autoread.git' 
endif

if has('nvim')
  "lsp
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
"  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
"  Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
  Plug 'onsails/lspkind-nvim'
  Plug 'nvim-lua/lsp_extensions.nvim'
  Plug 'simrat39/symbols-outline.nvim'
  " Neovim Tree shitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  " Snippets
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'rafamadriz/friendly-snippets'
endif
" Easy selection pairs via `viv` and `vav`
Plug 'gorkunov/smartpairs.vim'

" Insert pairs [ -> []
Plug 'jiangmiao/auto-pairs'
" Highlight hex colors like #ff0000 with :ColorHighlight
Plug 'chrisbra/color_highlight'
Plug 'mkitt/tabline.vim'
" Show additiona/deletions/modifications 
Plug 'airblade/vim-gitgutter'
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

"Plug 'antoinemadec/coc-fzf'
call plug#end()


"##############################################################################"
"################################## Mappings ##################################"
"##############################################################################"

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

" Vista config
let g:vista_default_executive = 'coc'
let g:vista_echo_cursor_strategy = 'scroll'
let g:vista_close_on_jump = 1
let g:vista_disable_statusline = 1
let g:vista_keep_fzf_colors = 1
nnoremap <leader>v :Vista!!<CR>

"git blame config
nnoremap gb :<C-u>call gitblame#echo()<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
"inoremap <silent><expr> <Tab>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<Tab>" :
"      \ coc#refresh()

" Coc Config 
" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)
"
" Use <leader>x for convert visual selected code to snippet
" xmap <leader>x  <Plug>(coc-convert-snippet)

function! s:show_documentation()
  if (index(['help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap <C-j> and <C-k> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"  nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
"  nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
"  inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"  inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"  vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
"  vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
"endif

" Telescope config
if has('nvim')
lua <<EOF
  require("telescope").setup {
  }
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('coc')
EOF
  command! -nargs=? Tgrep lua require 'telescope.builtin'.grep_string({ search = vim.fn.input("Grep For > ")})
endif

" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr :Telescope lsp_references<CR>

" Symbol renaming.
"nmap <space>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
" nmap <leader>cl  <Plug>(coc-codelens-action)

map <leader>bb :Telescope buffers<CR>
map <leader>bd :BD<CR>

" DBUI
nnoremap <leader>d :DBUIToggle<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  "autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  "autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"SQL formatter config
let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -k upper"
"let g:sqlfmt_auto = 0

"gopls
let g:go_gopls_enabled = 1
let g:go_gopls_options = ['-remote=auto']
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_referrers_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_doc_keywordprg_enabled = 0

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

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 0


if has('nvim')
  lua require('dap-go').setup()
  lua require("dapui").setup()
  nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
  nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
  nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
  nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
  nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
  nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
  nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
  nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
  nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
endif


if has('nvim')
lua <<EOF
  local dap, dapui = require("dap"), require("dapui")
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
EOF
endif

function! NearestMethodOrFunction() abort
  let func = get(b:, 'vista_nearest_method_or_function', '')
  if func != ''
    return ':'.func
  endif
  return &fileencoding

endfunction

if has('nvim')
lua << END
local function vista()
  return [[Vista]]
end
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
local vista = { sections = { lualine_a = { vista } }, filetypes = {'vista'} }
local blame = { sections = { lualine_a = { fugitive_branch }, lualine_z = { 'location' } }, filetypes = {'fugitiveblame'} }
local db = { sections = { lualine_a = { db }}, filetypes = {'dbui'} }
require('lualine').setup { 
  extensions = {nerd, 'fzf', 'fugitive', vista, blame, db},
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diagnostics'},
    lualine_c = {{ 'filename', path = 1 }},
    lualine_x = {'NearestMethodOrFunction', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  }
require("virt-column").setup{ char = "▏" }
END
endif

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
let g:seoul256_background = 235
colorscheme seoul256
let g:seoul256_srgb = 1
hi StatusLine ctermfg=236
hi StatusLineNC ctermfg=236

filetype plugin indent on  

"FZF Buffer Delete

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

"Find files
nnoremap <silent> <C-p> :Telescope fd<CR>
nnoremap <silent> <Leader>f :Telescope grep_string<CR>
nnoremap <silent> <Leader>g :Tgrep<CR>
"Find (t)ags
nnoremap <silent> <Leader>t :Vista finder fzf<CR>

"##############################################################################"
"################################### Utils ####################################"
"##############################################################################"

" Function to make headers
function Header(width, word)
    let l:hash_line = repeat('#', a:width - 2)

    :put ='\"'.l:hash_line.'\"'
    call SubHeader(a:width, a:word)
    :put ='\"'.l:hash_line.'\"'
endfunction

function SubHeader(width, word)
    let l:inserted_word = ' ' . a:word . ' '
    let l:word_width = strlen(l:inserted_word)
    let l:length_before = (a:width - l:word_width) / 2
    let l:hashes_before = repeat('#', l:length_before - 1)
    let l:hashes_after = repeat('#', a:width - (l:word_width + l:length_before) - 1)
    let l:length_before = (a:width - l:word_width) / 2
    let l:word_line = l:hashes_before . l:inserted_word . l:hashes_after

    :put ='\"'.l:word_line.'\"'
endfunction

" TODO override syntax
hi! default link VistaScope Keyword
hi! default link VistaTag Function
hi! default link VistaLineNr SpecialKey

hi! CocHighlightText ctermbg=237
"function! SetColorInsert(mode)
"    " Insert mode: blue
"    if a:mode == "i"
"        highlight StatusLine ctermfg=108
"
"    " Replace mode: red
"    elseif a:mode == "r"
"        highlight StatusLine ctermfg=168
"
"    endif
"endfunction
"
"function! SetColorVisual()
"    " Visual mode: orange
"    highlight StatusLine ctermfg=181
"endfunction
"
"
"function! ResetColor()
"    highlight StatusLine  ctermfg=109
"endfunction
"
"
"vnoremap <silent> <expr> <SID>SetColorVisual SetColorVisual()
"nnoremap <silent> <script> v v<SID>SetColorVisual
"nnoremap <silent> <script> V V<SID>SetColorVisual
"nnoremap <silent> <script> <C-v> <C-v><SID>SetColorVisual
"
"
"augroup CursorLineNrColorSwap
"    autocmd!
"    autocmd InsertEnter * call SetColorInsert(v:insertmode)
"    autocmd InsertLeave * call ResetColor()
"    autocmd CursorHold * call ResetColor()
"augroup END


if has('nvim')
lua << END

  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end
    -- Setup nvim-cmp.
  local cmp = require'cmp'

-- cmp.setup({
--   preselect = cmp.PreselectMode.None,
--   snippet = {
--     -- REQUIRED - you must specify a snippet engine
--     expand = function(args)
--       vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--       -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--       -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--       -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--     end,
--   },
--   window = {
--     -- completion = cmp.config.window.bordered(),
--     -- documentation = cmp.config.window.bordered(),
--   },
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--   }),
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' }, -- For vsnip users.
--     -- { name = 'luasnip' }, -- For luasnip users.
--     -- { name = 'ultisnips' }, -- For ultisnips users.
--     -- { name = 'snippy' }, -- For snippy users.
--   }, {
--     { name = 'buffer' },
--   })
-- })
--
-- -- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
--   }, {
--     { name = 'buffer' },
--   })
-- })
--
-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' }
--   }
-- })
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })
  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  local servers = { 'gopls', 'pyright', 'tsserver' }
  for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
      on_attach = on_attach,
      flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
      },
      capabilities = capabilities
    }
  
  end

END
endif
