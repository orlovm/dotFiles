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
set fillchars=vert:▕,eob:\ 
set noshowmode
"use system + clipboard
set clipboard+=unnamedplus
" set clipboard+=unnamed
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Mouse config
if has('mouse')
  set mouse=a
endif
set expandtab
set shiftwidth=8
set smarttab

" Use external .vimrc in current folder root
set exrc
" Forbid buffer writing, shell commands
" and autocmd from local dir .vimrc files
set secure

set nu nornu
" show line numbers
" Scrolling config
set scrolljump=8
set scrolloff=8

set pumblend=15
set winblend=15

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
