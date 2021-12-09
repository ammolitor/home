" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible    " set nocp

set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=50		       " keep 50 lines of command line history
set hlsearch
set incsearch		       " do incremental searching
set nowrap
set number
set ruler		       " show the cursor position all the time
set softtabstop=4 shiftwidth=4 tabstop=4 expandtab
set showcmd		       " display incomplete commands
set laststatus=2
set smartcase
set t_Co=256
syntax on
let g:vim_json_syntax_conceal = 0

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
  set backupdir=/tmp/.vim_backup,/tmp,.
  set directory=/tmp/.vim_tmp,/tmp,.
endif

if has("gui_running")
  set lines=40 columns=132
  set guifont=JetBrains\ Mono:h10
endif

set background=dark
colorscheme jellybeans
