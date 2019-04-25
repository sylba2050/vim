" dein.vim
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:rc_dir = expand('~/.vim')

" Install dein.vim if it is not downloaded
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml      = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

syntax on

set splitbelow
set signcolumn=yes

" backup
set backup
set backupdir=~/.vim/tmp

" dont create swap file
set noswapfile
set directory=~/.vim/tmp

" save undofile
set undofile
set undodir=~/.vim/tmp

set belloff=all
set laststatus=2
set scrolloff=4

set number

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

set showcmd
set wildmenu

set backspace=indent,eol,start

set incsearch
set hlsearch
set ignorecase

set cursorline

set gdefault
set virtualedit=onemore

" scroll margin
set scrolloff=4

nnoremap ; :

" Ctrl+j associate to ESC
noremap! <C-j> <Esc>
noremap <C-j> :noh<CR>

" increment number
nnoremap <C-c> <C-a>

" make line break possible in the middle of the line
nnoremap <CR> A<CR><ESC>

" movement on display instead of actual line
nnoremap j gj
nnoremap k gk

" open link file
nnoremap <space>n <C-w>gf

" change cursor shape when insert mode
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Ctrl+l associate to Right arrow
inoremap <C-l> <Right>

" move the cursor to end of line by Ctrl+e
inoremap <C-e> <Esc><S-a>
nnoremap <C-e> $

" move the cursor to begin of line by Ctrl+a
inoremap <C-a> <Esc><S-i>
nnoremap <C-a> ^

" don't use arrow key
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Down> <Nop>
noremap <Up> <Nop>

noremap ZZ <Nop>
noremap ZQ <Nop>
noremap Q <Nop>
noremap <MiddleMouse> <Nop>

" splitting screen
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

" moving screen
nnoremap sH <C-w>H
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L

" tab
nnoremap st :tabnew<CR>
nnoremap sn gt
nnoremap su gT
" s<N> jump to N tab
for n in range(1, 9)
    execute 'nnoremap <silent> s'.n ':<C-u>tabnext' .n.'<CR>'
endfor

" reload file
set autoread
augroup vimrc-checktime
    autocmd!
    autocmd CursorMoved * checktime
augroup END

" tailing blanks removed
augroup AutoDeleteSpace
    autocmd!
    autocmd BufWritePre * if &ft != 'markdown' | :%s/\s\+$//ge | endif
augroup END

" Restore the last cursor position when opening a file
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif

" tag jump
nnoremap go %

colorscheme mstn3
