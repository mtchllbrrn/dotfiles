" Author: Mitchell Barron

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'mrtazz/simplenote.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/syntastic'
Plugin 'mattn/emmet-vim'
Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'

" All of your Plugins must be added before the following line
call vundle#end()            " required

"-----------------------------------------------------------
" Plugin configuration
"
" simplenote.vim
" source .simplenoterc for Simplenote credentials to keep it out of version
" control.
source ~/.simplenoterc

" ctrlp config
let g:ctrlp_show_hidden = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|meteor)$',
  \ 'file': '\v\.(exe|so|dll|swp)$',
  \ 'link': '',
  \ }

let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeIgnore = ['.swp']

" Disallow NERDTree from remapping C-j/k. This was conflicting with tmux/vim
" split navigation.
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

" Disable error-checking on html files. It's too wonky with stuff like
" template tags.
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" Mark syntax errors with :signs
let g:syntastic_enable_signs=1

" Do not automatically jump to the error when saving the file
" Jump feature is annoying to me as it automatically moves the cursor
let g:syntastic_auto_jump=0

" Show the error list automatically
" Allows you to easily navigate the quick fix list
let g:syntastic_auto_loc_list=1

" This is where the magic happens. Chain together different style checkers
" in order to check for both style flaws and syntax errors.
" Syntax checkers: https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
let g:syntastic_ruby_checkers=['rubocop', 'mri']
let g:syntastic_python_checkers=['pep8', 'pylint', 'python']
let g:syntastic_javascript_checkers=['jshint']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Recommended settings from GH repo.
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Airline settings
let g:airline_powerline_fonts = 1

" Easymotion settings
let g:Easymotion_do_mapping = 0 " Disable default bindings.
" hi EasyMotionTarget2First ctermbg=none ctermfg=3
" hi EasyMotionTarget2Second ctermbg=none ctermfg=3
hi EasyMotionTarget ctermbg=none ctermfg=1
hi EasyMotionShade  ctermbg=none ctermfg=236
hi EasyMotionTarget2First ctermbg=none ctermfg=1
hi EasyMotionTarget2Second ctermbg=none ctermfg=3
hi EasyMotionMoveHL ctermbg=green ctermfg=black

" filetype indent plugin on
set smartindent
syntax on

set background=dark
colorscheme solarized

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=1

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Indentation settings according to personal preference.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Only redraws screen when necessary, e.g. NOT during macros.  This speeds
" them up.
set lazyredraw

"------------------------------------------------------------
" Mappings {{{1

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" jk / kj to leave insert
inoremap jk <Esc>
inoremap kj <Esc>

" Handle wrapped lines sanely
nmap j gj
nmap k gk

" ALMIGHTY SPACEBAR LEADER
nnoremap <Space> <NOP>
let mapleader=" "

" Plugin Mappings
map <Leader>n :NERDTreeToggle<CR>
nmap <Leader>f <plug>(easymotion-s)
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'
