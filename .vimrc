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

" Syntax detection
syntax on
" Give more space for displaying messages.
"set cmdheight=2
" Highlight search
set hlsearch
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
"show the cursor position
set ruler
"display incomplete commands
set showcmd
" Show matched pattern when typing search command
set incsearch
" smart search case
set ignorecase smartcase

" Set split separator to Unicode box drawing character
if has('nvim')
  set fillchars=vert:│,eob:\ 
endif

" Override color scheme to make split the same color as tmux's default
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=233 ctermbg=NONE
autocmd ColorScheme * highlight ColorColumn ctermbg=235
autocmd ColorScheme * highlight VirtColumn ctermfg=234
"use system + clipboard
set clipboard=unnamedplus
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

autocmd FileType go,js,vim setlocal colorcolumn=80

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

if has('nvim')
  Plug 'nvim-lualine/lualine.nvim'
  " If you want to have icons in your statusline choose one of these
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'lukas-reineke/virt-column.nvim'
endif

" Fzf - finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-unimpaired'

"Git plugins
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
" GoLang support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Some vim defaults
Plug 'tpope/vim-sensible'

" Coc - completion. 
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': function('InstallCocPlugs')}

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

" Easy selection pairs via `viv` and `vav`
Plug 'gorkunov/smartpairs.vim'

" Dark powered asynchronous unite all interfaces for Neovim/Vim8 
"Plug 'https://github.com/Shougo/denite.nvim'

" Tag bar panel
Plug 'majutsushi/tagbar'
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
" File navigation
Plug 'ctrlpvim/ctrlp.vim'
" git blame
Plug 'zivyangll/git-blame.vim'
" Handlebars
Plug 'mustache/vim-mustache-handlebars'
" parentheses, brackets, quotes, XML tags, and more
Plug 'tpope/vim-surround'
"uppercase SQL
Plug 'jsborjesson/vim-uppercase-sql'
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

nnoremap <Space> <PageDown>

nnoremap tg :TagbarToggle<CR>

autocmd FileType go nmap <leader>e :GoIfErr<CR>

"##############################################################################"
"############################## Plugins config ################################"
"##############################################################################"

let g:db_ui_use_nerd_fonts = 1
let g:db_ui_show_database_icon = 1

" Vista config
let g:vista_default_executive = 'coc'
let g:vista_echo_cursor_strategy = 'scroll'
nnoremap <leader>v :Vista!!<CR>

"git blame config
nnoremap gb :<C-u>call gitblame#echo()<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Coc Config 
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
"
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

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
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
  nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
  inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-j>"
  vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-k>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <space>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

map <leader>b :Buffers<CR>

" DBUI
nnoremap <leader>d :DBUIToggle<CR>




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

if has('nvim')
lua << END
require('lualine').setup { 
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  extensions = {'nerdtree', 'fzf'} 
  }
require("virt-column").setup{ char = "│" }
END
endif
augroup NERDTree
  autocmd!
  " open NERDTree if open directory
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
  " close NERDTree if it's a last window
  autocmd BufEnter * nested if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " Open the existing NERDTree on each new tab.
  "autocmd BufWinEnter * silent NERDTreeMirror 
augroup END

" tag-bar config
let g:tagbar_width = 50

" seoul256 config
let g:seoul256_background = 235
colorscheme seoul256
let g:seoul256_srgb = 1
"hi link CocFloating markdown

" ctrl-p config
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|target)$',
  \ 'file': '\v\.(so|class|o)$',
  \ }

" tagbar config
nnoremap <F4> :TagbarToggle<CR>

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
