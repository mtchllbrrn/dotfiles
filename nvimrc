" Author: Mitchell Barron

set nocompatible              " be iMproved, required
filetype off                  " required

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-surround'
" Plugin 'w0rp/ale' " Async lint engine
Plugin 'airblade/vim-gitgutter'
Plugin 'tmux-plugins/vim-tmux-focus-events' " restores focus event, allowing better gitgutter func.

" Improved sytax highlighting for modern web.
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'digitaltoad/vim-pug.git'

" All of your Plugins must be added before the following line
call vundle#end()

"-----------------------------------------------------------
" Plugin configuration

" vim-jsx config (enhanced react highlighting)
let g:jsx_ext_required = 1 " only allow jsx highlighting in .jsx files.

" vim-javascript config (enhanced js highlighting)
let g:javascript_enable_domhtmlcss = 1 " Enable html/css syntax in js files

" ctrlp config
let g:ctrlp_show_hidden = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  'node_modules\|DS_Store\|.git\|.meteor',
  \ 'file': '\v\.(exe|so|dll|swp)$',
  \ 'link': '',
  \ }

" NERDTree config
" Close NERDTree if it's the only window in current tab
let g:ctrlp_dont_split = 'NERD'

let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeIgnore = ['.swp']
let NERDTreeQuitOnOpen=1 " Automatically closes NERDTree upon file selection

" Disallow NERDTree from remapping C-j/k. This was conflicting with tmux/vim
" split navigation.
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

"Close NERDTree if it is the last open buffer
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" Easymotion config
let g:Easymotion_do_mapping = 0 " Disable default bindings.
hi EasyMotionTarget ctermbg=none ctermfg=1
hi EasyMotionShade  ctermbg=none ctermfg=236
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search
hi EasyMotionMoveHL ctermbg=green ctermfg=black

" Gitgutter
" Disables gg's bindings
let g:gitgutter_map_keys = 0

" this is not specifically a gitgutter option, but it improves the responsiveness of gutter sign
" updates
set updatetime=100

"------------------------------------------------------------
" Basic Functionality

filetype indent plugin on

colorscheme solarized
if $ITERM_PROFILE == 'Dark'
  set background=dark
else
  set background=light
endif

syntax on

set colorcolumn=100
set wildmenu
set showcmd
set hlsearch
set relativenumber

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

set autoindent
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb= " Disable bell notifications
set mouse=a
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

set lazyredraw

" Folding
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max
set foldmethod=indent   " fold based on indent level

" Disable character hiding, specifically because double quotes were being
" hidden in json files.
set conceallevel=0

" Unite system and vim clipboard
set clipboard=unnamed

" Navigate by screen lines, prevents skipping wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

"------------------------------------------------------------
" Indentation options

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

"------------------------------------------------------------
" Mappings

" ALMIGHTY SPACEBAR LEADER
nnoremap <Space> <NOP>
let mapleader=" "

nnoremap <return> :nohlsearch<return><esc>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" jk / kj to leave insert
inoremap jk <Esc>
inoremap kj <Esc>

" Rebind vim splits to resemble tmux
map <leader>" <C-W>s
map <leader>% <C-W>v

" Plugin Mappings
map <Leader>n :NERDTreeToggle<CR>
nmap <Leader>f <plug>(easymotion-s)
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'
