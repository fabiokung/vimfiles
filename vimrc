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
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

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
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#mixed_indent_format = 'mix[%s]'
let g:airline#extensions#whitespace#trailing_format = 'trl[%s]'

let base16colorspace=256
set background=light
colorscheme base16-tomorrow
"colorscheme solarized
"colorscheme wombat256mod
"colorscheme beauty256
if has("gui")
    set guitablabel=%M%t
endif
if has("gui_running")
    set guitablabel=%M%t

    if has("gui_gnome")
        set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14
        colorscheme github
    endif

    if has("gui_mac") || has("gui_macvim")
        set lines=50
        set columns=85
        set guifont=Monaco\ for\ Powerline:h14

        "set guifont=Menlo:h14
        " make Mac's Option key behave as the Meta key
        set invmmta
        " comma as the leader key
    endif

    if has("gui_win32") || has("gui_win32s")
        set guifont=Consolas:h12
        set enc=utf-8
    endif
endif
"set t_Co=256

nmap <silent> <Leader>p :NERDTreeToggle<CR>
nmap <silent> <Leader>t :TagbarToggle<CR>
"let g:tagbar_type_go = {
"            \ 'ctagstype': 'go',
"            \ 'kinds' : [
"            \'p:package',
"            \'f:function',
"            \'v:variables',
"            \'t:type',
"            \'c:const'
"            \]
"        \}

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <leader>f :BufExplorer<CR>

"map for Gundo
nnoremap <leader>u :GundoToggle<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"quicksilver in fuzzy mode by default
let g:QSMatchFn = "fuzzy"

"bindings for ragtag
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

"let g:syntastic_disabled_filetypes = ['cpp']

"key mapping for vimgrep result navigation
map <A-o> :copen<CR>
map <A-q> :cclose<CR>
map <A-j> :cnext<CR>
map <A-k> :cprevious<CR>

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

"minitest
set completefunc=syntaxcomplete#Complete

"snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"Gists
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

"Golang
let g:go_fmt_command = "goimports"

"Reveal.js
let g:reveal_root_path = '$HOME/Documents/Talks/QConSP/escalabilidade-heroku/'

