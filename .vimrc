""""""""""""""""""""""""" 表示関連 """""""""""""""""""""""""""""""""""""""" 
"行数表示
set number

"ステータスバーを常に表示
set laststatus=2

" スクロール時の余白
set scrolloff=4

""""""""""""""""""""""""" 編集関連 """"""""""""""""""""""""""""""""""""""""

" tabの代わりに半角スペース
set expandtab

" タブを表示するときの幅
set tabstop=4

" タブを挿入するときの幅
set shiftwidth=4

"改行時に前の行のインデントを継続する
set autoindent

"改行時に次の行のインデントを増減する
set smartindent

" スワップファイルを作らない
set noswapfile

" マウス有効化
" set mouse=a

" 置換の際のgオプションをデフォルトで有効化する
set gdefault

" 編集中のファイルが変更されたら自動で読み直す
set autoread

""""""""""""""""""""""""" 検索関連 """"""""""""""""""""""""""""""""""""""""

" 検索時に大文字小文字を区別しない
set ignorecase

"検索結果をすべてハイライト
set hlsearch

"ハイライト解除
noremap <Esc><Esc> :noh<CR>

""""""""""""""""""""""""" キーバインド """"""""""""""""""""""""""""""""""""""""
" 実際の行移動ではなく表示上の行移動
noremap j gj
noremap k gk
" HHKBで:は打ちにくい
noremap ; :
noremap : ;
" 行の途中で改行可能に
noremap <CR> A<CR><ESC>

" Ctrl + jでもESCしたい
noremap! <C-j> <Esc>
noremap <C-j> :noh<CR>

inoremap <C-l> <Right>

" Insertモードのときカーソルの形状を変更
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"行頭（^)と行末($)にカーソルを移動
inoremap <C-e> <Esc><S-a>
inoremap <C-a> <Esc><S-i>
noremap <C-e> $
noremap <C-a> ^

"十字キーはいらないんや
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Down> <Nop>
inoremap <Up> <Nop>

noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Down> <Nop>
noremap <Up> <Nop>

"画面分割関連
noremap ss :split<CR>
noremap sv :vsplit<CR>
noremap sh <C-w>h
noremap sj <C-w>j
noremap sk <C-w>k
noremap sl <C-w>l
noremap sw <C-w>w

noremap st :tabnew<CR>
noremap sn gt
noremap su gT

"末尾の空白削除
noremap <F2> :%s/\s\s*$<CR>

" dein.vim
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

filetype plugin on
runtime macros/matchit.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neoyank.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('sjl/gundo.vim')
call dein#add('Yggdroot/indentLine')
call dein#add('bling/vim-airline')
call dein#add('hail2u/vim-css3-syntax')
call dein#add('pangloss/vim-javascript')
call dein#add('mattn/emmet-vim')
call dein#add('othree/html5.vim')
call dein#add('nvie/vim-flake8')
call dein#add('simeji/winresizer')
call dein#add('tomtom/tcomment_vim')

call dein#end()

if dein#check_install()
  call dein#install()
endif


""""""""""""""""""""""""" dein.vim """"""""""""""""""""""""""""""""""""""""

" DeinClean command
command! -bang DeinClean call s:dein_clean(<bang>0)

function! s:dein_clean(force) abort "{{{
    let del_all = a:force
    for p in dein#check_clean()
        if !del_all
            let answer = s:input(printf('Delete %s ? [y/N/a]', fnamemodify(p, ':~')))

            if type(answer) is type(0) && answer <= 0
                " Cancel (Esc or <C-c>)
                break
            endif

            if answer !~? '^\(y\%[es]\|a\%[ll]\)$'
                continue
            endif

            if answer =~? '^a\%[ll]$'
                let del_all = 1
            endif
        endif

        " Delete plugin dir
        call dein#install#_rm(p)
    endfor
endfunction "}}}

function! s:input(...) abort "{{{
    new
    cnoremap <buffer> <Esc> __CANCELED__<CR>
    try
        let input = call('input', a:000)
        let input = input =~# '__CANCELED__$' ? 0 : input
    catch /^Vim:Interrupt$/
        let input = -1
    finally
        bwipeout!
        return input
    endtry
endfunction "}}}

""""""""""""""""""""""""" deoplete.vim"""""""""""""""""""""""""""""""
" python3を有効化
set pyxversion=3
" " NeoCompleteを有効にする
let g:deoplete#enable_at_startup = 1
" " 補完が自動で開始される文字数
let g:deoplete#auto_completion_start_length = 1
" " smart case有効化。 大文字が入力されるまで大文字小文字の区別を無視する
let g:deoplete#enable_smart_case = 1
" " camle caseを有効化。大文字を区切りとしたワイルドカードのように振る舞う
let g:deoplete#enable_camel_case_completion = 1
" " _(アンダーバー)区切りの補完を有効化
let g:deoplete#enable_underbar_completion = 1
" " シンタックスをキャッシュするときの最小文字長を3に
let g:deoplete#min_syntax_length = 3
" " -入力による候補番号の表示
let g:deoplete#enable_quick_match = 1
" " 補完候補の一番先頭を選択状態にする(AutoComplPopと似た動作)
let g:deoplete#enable_auto_select = 1
" "ポップアップメニューで表示される候補の数。初期値は100
let g:deoplete#max_list = 20

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><CR> pumvisible() ? deoplete#close_popup() :"\<CR>"

"""""""""""""""""""""""""""" denite.vim""""""""""""""""""""""""""""""""""""
" 最近使用したファイル一覧
noremap <silent> <space>s :<C-u>Denite file_mru<CR>
noremap <silent> <space>a :<C-u>Denite file_rec<CR>
noremap <silent> <C-s> :<C-u>Denite neoyank<CR>
nnoremap <silent> / :<C-u>Denite -buffer-name=search -auto-resize line<CR>
call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')

"""""""""""""""""""""""""""""""NERDTree""""""""""""""""""""""""""""""""""""
""起動
noremap <silent> <space>n :NERDTree<CR>

""起動時にNERDTreeを表示
""ファイル名が指定されてvimが起動した場合はNERDTreeを表示しない
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

""不可視ファイル
let NERDTreeShowHidden = 1

""""""""""""""""""""""""""""""Gundo"""""""""""""""""""""""""""""""""""
nnoremap <F5> :GundoToggle<CR>
let g:gundo_prefer_python3 = 1

""""""""""""""""""""""""""""""indentline"""""""""""""""""""""""""""""""""""
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'
let g:indentLine_char = '|'

""""""""""""""""""""""""""""""airline"""""""""""""""""""""""""""""""""""
let g:airline_enable_branch = 0
let g:airline_section_b = "%t %M"
let g:airline_section_c = ''
let s:sep = " %{get(g:, 'airline_right_alt_sep', '')} "
let g:airline_section_x =
\ "%{strlen(&fileformat)?&fileformat:''}".s:sep.
\ "%{strlen(&fenc)?&fenc:&enc}".s:sep.
\ "%{strlen(&filetype)?&filetype:'no ft'}"
let g:airline_section_y = '%3p%%'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
let g:airline#extensions#whitespace#enabled = 0

" タブラインにもairlineを適用
let g:airline#extensions#tabline#enabled = 1
" （タブが一個の場合）バッファのリストをタブラインに表示する機能をオフ
let g:airline#extensions#tabline#show_buffers = 0
" 0でそのタブで開いてるウィンドウ数、1で左のタブから連番
let g:airline#extensions#tabline#tab_nr_type = 1
" タブに表示する名前（fnamemodifyの第二引数）
let g:airline#extensions#tabline#fnamemod = ':t'

""""""""""""""""""""""""""""""emmet"""""""""""""""""""""""""""""""""""
let g:user_emmet_mode = 'iv'
let g:user_emmet_leader_key = '<C-Y>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
  \ 'lang' : 'ja',
  \ 'html' : {
    \   'filters' : 'html',
    \ },
  \ 'css' : {
    \   'filters' : 'fc',
    \ },
  \ 'php' : {
    \   'extends' : 'html',
    \   'filters' : 'html',
    \ },
  \}
augroup EmmitVim
  autocmd!
  autocmd FileType * let g:user_emmet_settings.indentation = '               '[:&tabstop]
augroup END

""""""""""""""""""""""""" winresizer.vim """"""""""""""""""""""""""""""""""""""""
let g:winresizer_start_key = '<C-q>'

set t_Co=256
syntax on

"カラースキーマを自作のものに設定
colorscheme mstn2
