"Fabio Kung <fabio.kung@gmail.com>
"
"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

set backupdir=/tmp,/var/tmp,.,./.backup
set directory=/tmp,/var/tmp,.,./.backup

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

"old regexp engine (faster)
set re=1

set lazyredraw  "slow vim hack :(

set showcmd     "show incomplete cmds down the bottom
set noshowmatch
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
set number      "add line numbers
set cursorline  "hilight current line
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

"display tabs and trailing spaces
set list
set listchars=tab:\ \ ,trail:⋅,nbsp:⋅

set showbreak=...
set nowrap linebreak

set laststatus=2

"mapping for command key to map navigation thru display lines instead
"of just numbered lines
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

"disable visual bell
set visualbell t_vb=

"try to make possible to navigate within lines of wrapped lines
nmap <Down> gj
nmap <Up> gk
set fo=l

set encoding=utf-8

"turn off needless toolbar/menubar/scrollbars on gvim/mvim
set guioptions-=T
set guioptions-=r
set guioptions-=L
set guioptions-=m

"indent settings
"set shiftwidth=4
"set softtabstop=4
"set expandtab
set autoindent

set smartcase
set smarttab

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load pathogen managed plugins
call pathogen#infect()

"load ftplugins and indent files
filetype plugin indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"hide buffers when not displayed
set hidden

set textwidth=80
set colorcolumn=+1

let mapleader=","

let base16colorspace=256
set background=light
colorscheme base16-tomorrow

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_format = 'mix[%s]'
let g:airline#extensions#whitespace#trailing_format = 'trl[%s]'
let g:airline#extensions#tmuxline#enabled = 0

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 3
let g:indent_guides_guide_size = 1

"syntastic is slow for Golang
"let g:syntastic_mode_map = { 'passive_filetypes': ['go'] }
let g:syntastic_go_checkers = ['govet', 'errcheck']

if has("gui")
    set guitablabel=%M%t
endif
if has("gui_running")
    set guitablabel=%M%t

    if has("gui_gnome")
        set guifont=Hack\ 13
    endif

    if has("gui_mac") || has("gui_macvim")
        set guifont=Hack:h15
        " make Mac's Option key behave as the Meta key
        set invmmta
    endif

    if has("gui_win32") || has("gui_win32s")
        set guifont=Consolas:h12
        set enc=utf-8
    endif
endif

"make Y consistent with C and D
nnoremap Y y$

nmap <silent> <Leader>p :NERDTreeToggle<CR>
nmap <silent> <Leader>t :TagbarToggle<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

nnoremap <leader>f :BufExplorer<CR>
nnoremap <leader>u :GundoToggle<CR>

"Error list nav
map <C-j> :lnext<CR>
map <C-k> :lprevious<CR>

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

function! SoftLineWrap()
    setlocal wrap linebreak nolist wrapmargin=0 formatoptions-=tc
endfunction

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

autocmd BufRead mutt* execute 'normal gg/\n\nj'

"Gists
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

"Golang
let g:go_fmt_command = "goimports"

"Reveal.js
let g:reveal_root_path = '$HOME/Documents/Talks/QConSP/escalabilidade-heroku/'

