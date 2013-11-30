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

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set number      "add line numbers

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

"turn off needless toolbar on gvim/mvim
set guioptions-=T

"indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
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

let mapleader=","
let g:airline_powerline_fonts=1

if has("gui_running")
    set t_Co=256
    set guitablabel=%M%t
    colorscheme xoria256
    "colorscheme railscasts
    "colorscheme mac_classic

    if has("gui_gnome")
        set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
    else
    endif
    if has("gui_mac") || has("gui_macvim")
        set lines=50
        set columns=85
        set guifont=Monaco\ for\ Powerline:h14
        "set guifont=Menlo:h14
        " make Mac's Option key behave as the Meta key
        set invmmta
        " comma as the leader key
        set guioptions-=r
    endif
    if has("gui_win32") || has("gui_win32s")
        set guifont=Consolas:h12
        set enc=utf-8
    endif
else
    "dont load csapprox if there is no gui support - silences an annoying warning
    let g:CSApprox_loaded = 1
    if has("gui")
        set t_Co=256
        set guitablabel=%M%t
        colorscheme xoria256
    endif
endif

nmap <silent> <Leader>p :NERDTreeToggle<CR>
nmap <silent> <Leader>t :TlistToggle<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <leader>f :BufExplorer<CR>

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

"mark syntax errors with :signs
let g:syntastic_enable_signs=1
let g:syntastic_disabled_filetypes = ['cpp']

"key mapping for vimgrep result navigation
map <A-o> :copen<CR>
map <A-q> :cclose<CR>
map <A-j> :cnext<CR>
map <A-k> :cprevious<CR>

"snipmate setup
try
  source ~/.vim/snippets/support_functions.vim
catch
  source $HOMEPATH\vimfiles\snippets\support_functions.vim
endtry
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()

    "if we're in a rails env then read in the rails snippets
    if filereadable("./config/environment.rb")
        call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
        call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
    endif

    call ExtractSnips("~/.vim/snippets/html", "eruby")
    call ExtractSnips("~/.vim/snippets/html", "xhtml")
    call ExtractSnips("~/.vim/snippets/html", "php")
endfunction

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

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

"snipmate settings
let g:snips_author = "Fabio Kung"

" minitest
set completefunc=syntaxcomplete#Complete

let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

let g:reveal_root_path = '$HOME/dev/talks/reveal.js/'

