set nocompatible    "turn off Vi compatible mode
syntax on
set background=dark
filetype indent plugin on
set showcmd    "show the current command at the bottom
set number    "show line numbers"
set backspace=indent,eol,start    "set the working of BackSpace"
set hidden    "keep the changes to the buffer without saving
"set the color of cursor in insert mode
if has('multi_byte_ime')||has('xim')
    highlight CursorlM guibg=Purple guifg=NONE
endif
"set browsedir=current    "make the current dir default
set clipboard=unnamed    "enable the clipboard
"set autochdir    "change the current dir automatically
set nrformats=octal    "disable Ctrl-A/X to calculate octal (base-8)
set ruler    "show the ruler
set nostartofline
"set mouse=a    "enable Mouse in the all mode
set t_Co=256
set nowrap
set history=10000
source $VIMRUNTIME/macros/matchit.vim
let g:mapleader = "\<Space>"



""""""""""""""""""""""""""""""""""
"search
""""""""""""""""""""""""""""""""""
set hlsearch    "highlight the search words
set ignorecase
set smartcase    "distinguish only upper-cases"
set incsearch


""""""""""""""""""""""""""""""""""
"indent
""""""""""""""""""""""""""""""""""
set expandtab    "use spaces instead of tabs
set autoindent
set smartindent
set cindent
set smarttab
set shiftwidth=4
set tabstop=4


""""""""""""""""""""""""""""""""""
"visualize
""""""""""""""""""""""""""""""""""
"tab
set list
set listchars=tab:>-,trail:-
highlight SpecialKey ctermfg=237

"zenkaku space
highlight ZenkakuSpace ctermbg=white
match ZenkakuSpace /　/


""""""""""""""""""""""""""""""""""
"mapping
""""""""""""""""""""""""""""""""""
"move tabs
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprevious<CR>
nnoremap <tab> :tabnext<CR>
nnoremap <S-tab> :tabprevious<CR>

"move buffers
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>


"for insert mode
inoremap <C-f> <right>
inoremap <C-b> <left>
inoremap <C-a> <home>
inoremap <C-e> <end>
inoremap <C-j> <down>
inoremap <C-k> <up>

"turn off the highlight of search words
nnoremap <C-l> :nohl<CR><C-l>


""""""""""""""""""""""""""""""""""
"command
""""""""""""""""""""""""""""""""""
:command We :w|:e %

""""""""""""""""""""""""""""""""""
"input completion
""""""""""""""""""""""""""""""""""
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap ' ''<left>
inoremap " ""<left>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>


""""""""""""""""""""""""""""""""""
"status line
""""""""""""""""""""""""""""""""""
set laststatus=2    "show status line"
set cmdheight=2    "set command 2 lines"
"show file encoding and line feed code
set statusline=%<%F\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"change the color of status line in InsertMode
augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
    autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END
"file open
set wildmode=list,full


""""""""""""""""""""""""""""""""""
"template
""""""""""""""""""""""""""""""""""
autocmd BufNewFile *.tex 0r $HOME/.vim/template/tex.txt
autocmd BufNewFile *.py 0r $HOME/.vim/template/python.txt
autocmd BufNewFile *.html 0r $HOME/.vim/template/html.txt
autocmd BufNewFile *.cpp 0r $HOME/.vim/template/cpp.txt


""""""""""""""""""""""""""""""""""
"encoding
""""""""""""""""""""""""""""""""""
set encoding=utf-8    "set default encoding"
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
set fileformats=unix,dos,mac
set ambiwidth=double

""""""""""""""""""""""""""""""""""
"highlight text 80
""""""""""""""""""""""""""""""""""
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/



""""""""""""""""""""""""""""""""""
"color
""""""""""""""""""""""""""""""""""
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21
highlight Comment    ctermfg=22

""""""""""""""""""""""""""""""""""
"plugins
""""""""""""""""""""""""""""""""""
if has('vim_starting')
    set rtp+=~/.vim/plugged/vim-plug
    if !isdirectory(expand('~/.vim/plugged/vim-plug'))
        echo 'install vim-plug'
        call system('mkdir -p ~/.vim/plugged/vim-plug')
        call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
    end
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug', {'dir': '~/.vim/plugged/vim-plug/autoload'}
Plug 'kien/ctrlp.vim' | source ~/.vim/plug-conf/ctrlp.vim
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'digitaltoad/vim-pug', {'for': 'pug'}
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'Chiel92/vim-autoformat' | source ~/.vim/plug-conf/vim-autoformat.vim
call plug#end()

