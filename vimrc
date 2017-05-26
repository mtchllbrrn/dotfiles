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
Plugin 'scrooloose/nerdcommenter'
Plugin 'spf13/vim-autoclose'
Plugin 'edsono/vim-matchit'
Plugin 'vim-scripts/closetag.vim'
Plugin 'reedes/vim-pencil'
" Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-surround'
Plugin 'mxw/vim-jsx'
Plugin 'vim-scripts/YankRing.vim'
Plugin 'SirVer/ultisnips'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'ternjs/tern_for_vim'
Plugin 'rking/ag.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'junegunn/goyo.vim'
Plugin 'suan/vim-instant-markdown'
Plugin 'tomlion/vim-solidity'

" Snippets
Plugin 'honza/vim-snippets'
" Plugin 'greg-js/vim-react-es6-snippets'

"Plugin 'nathanaelkane/vim-indent-guides'

" All of your Plugins must be added before the following line
call vundle#end()            " required

"-----------------------------------------------------------
" Plugin configuration
"-----------------------------------------------------------

" show diff between current buffer & saved version.
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" vim-jsx config (enhanced react highlighting)
let g:jsx_ext_required = 1 " only allow jsx highlighting in .jsx files.

" vim-javascript config (enhanced js highlighting)
let g:javascript_enable_domhtmlcss = 1 " Enable html/css syntax in js files

" simplenote.vim
" source .simplenoterc for Simplenote credentials to keep it out of version
" control.
source ~/.simplenoterc

" vim-pencil config
" Enable airline pencil-status display
let g:airline_section_x = '%{PencilMode()}'
" Enable soft line-wrapping (default is hard)
let g:pencil#wrapModeDefault = 'soft'

" Configure vim-pencil to auto-initialize on markdown/text buffers
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" ctrlp config
let g:ctrlp_show_hidden = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  'node_modules\|DS_Store\|.git\|.meteor',
  \ 'file': '\v\.(exe|so|dll|swp)$',
  \ 'link': '',
  \ }

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

" NERDCommenter settings
" Include space after comment operator
let g:NERDSpaceDelims = 1

" Mark syntax errors with :signs
let g:syntastic_enable_signs=1

" Do not automatically jump to the error when saving the file
" Jump feature is annoying to me as it automatically moves the cursor
let g:syntastic_auto_jump=0

" Show the error list automatically
" Allows you to easily navigate the quick fix list
let g:syntastic_auto_loc_list=0

" This is where the magic happens. Chain together different style checkers
" in order to check for both style flaws and syntax errors.
" Syntax checkers: https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers
let g:syntastic_solidity_checkers=['solc']
let g:syntastic_ruby_checkers=['rubocop', 'mri']
let g:syntastic_python_checkers=['pep8', 'pylint', 'python']
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_javascript_eslint_args="--ext .js,.jsx"

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
hi EasyMotionTarget ctermbg=none ctermfg=1
hi EasyMotionShade  ctermbg=none ctermfg=236
hi link EasyMotionTarget2First Search
hi link EasyMotionTarget2Second Search
"hi EasyMotionTarget2First ctermbg=none ctermfg=35
"hi EasyMotionTarget2Second ctermbg=none ctermfg=35
"hi link EasyMotionTarget2First ErrorMsg
"hi link EasyMotionTarget2Second ErrorMsg
hi EasyMotionMoveHL ctermbg=green ctermfg=black

" Autoclose settings
let g:autoclose_vim_commentmode = 1

" yggdroot/indentLine settings
" Set indent-line character
let g:indentLine_char = '¦'

" vim config options
" ==================

" Disable character hiding, specifically because double quotes were being
" hidden in json files.
set conceallevel=0

" Highlight 100th column
set colorcolumn=100

" filetype indent plugin on
filetype plugin on
set smartindent
syntax on

set background=dark
colorscheme solarized
"
" If the current iTerm tab has been
" created using the **dark** profile:
if $ITERM_PROFILE == 'Solarized Light'
  set background=light
endif

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
"
"This unsets the 'last search pattern' register by hitting return
nnoremap <silent><CR> :noh<CR>

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
" Using this to enable vim split resizing with mouse drag
set ttymouse=xterm2

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

" Enable relative line numbers.
set relativenumber

" Automatically strip trailing whitespace on :w
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,javascript,sol autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Configure scroll-wheel to scroll one line at a time, rather than three
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Unify vim & system clipboard
set clipboard=unnamed

"------------------------------------------------------------
" Mappings {{{1

" ALMIGHTY SPACEBAR LEADER
nnoremap <Space> <NOP>
let mapleader=" "

" Diff saved version of buffer
nmap <leader>d :DiffSaved<CR>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" jk / kj to leave insert
inoremap jk <Esc>
inoremap kj <Esc>

" Handle wrapped lines sanely
nmap j gj
nmap k gk

" Make splitting vim windows easier
map <leader>" <C-W>s
map <leader>% <C-W>v

" Plugin Mappings
map <Leader>n :NERDTreeToggle<CR>
nmap <Leader>f <plug>(easymotion-s)
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'

" vim-pencil
map <Leader>w :TogglePencil<CR>

" Syntastic
map <Leader>ss :SyntasticToggleMode<CR>

" UltiSnips
" Trigger configuration.
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" YouCompleteMe
let g:ycm_key_list_select_completion = ['<C-j>']
let g:ycm_key_list_previous_completion = ['<C-k>']
