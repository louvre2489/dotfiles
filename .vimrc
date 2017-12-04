" dein.vimのディレクトリ
let s:dein_dir=expand('~/.cache/dein')
let s:dein_repo_dir=s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(shellescape(s:dein_dir))
  call dein#begin(s:dein_dir)

  let s:toml='~/.dein.toml'
  let s:lazy_toml='~/.dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" その他インストールしていないものはこちらに入れる
if dein#check_install()
  call dein#install()
endif

" display
set showmatch
set number
set ruler
set cursorline
set showmode
set nowrap
set t_Co=256

" file
set noswapfile
set nobackup
set noundofile
" indent
set autoindent
set expandtab
" etc
set enc=japan
set smartcase
set history=50

" syntax
syntax on

" ファイルが外部で変更された際に自動で読み込む
set autoread
" バックスペースの影響範囲を設定する
set backspace=indent,eol,start
" OSとクリップボードを共有する
"set clipboard=unnamed,autoselect
set clipboard=unnamedplus
" 強調表示する列を設定する
"set colorcolumn=80
" 未保存ファイルの終了時に保存確認を行なう
set confirm
" カーソル行を強調表示する
set cursorline
" 文字コードを設定する
set encoding=utf8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
" タブの代わりにスペースを挿入する
set expandtab
" ファイル変更中に他のファイルを表示可能にする
set hidden
" コマンドラインモードで保存する履歴数を設定する
set history=1000
" 検索結果をハイライト表示する
set hlsearch
" 大文字と小文字を区別せず検索する
set ignorecase
" インクリメンタルサーチを有効にする
set incsearch
" ステータスバーを常に表示する
set laststatus=2
" 不可視文字の表示方法を設定する
set listchars=eol:?
" マウスを有効にする
set mouse=a
" ルーラーを表示する
set ruler
" カーソル行の上下へのオフセットを設定する
set scrolloff=4
" タブ幅を設定する
set tabstop=2
" タブやバックスペースで処理するスペースの数を設定する
set softtabstop=2
" インデントでずれる幅を設定する
set shiftwidth=2
" 入力中のコマンドを表示する
set showcmd
" 対応するカッコを強調表示する
set showmatch
" タブバーを常に表示する
set showtabline=2
" コンテキストに応じたタブの処理を行なう
set smarttab
" 新しいウィンドウを下/右に開く
set splitbelow
set splitright
" 編集中のファイル名を表示する
set title
" ビープを無効にする
set visualbell t_vb=
" 行頭・行末の左右移動で行を移動する
set whichwrap=b,s,h,l,<,>,[,]
" コマンドラインモードでの補完を有効にする
set wildmenu
" コマンドラインモードでの補完方法を設定する
set wildmode=list:longest,full
" 文字崩れの発生を抑止
set ambiwidth=double

" デフォルトvimrc_exampleのtextwidth設定上書き
autocmd FileType text setlocal textwidth=0

" ---------------------------------------
" キーマップ
" ---------------------------------------
" インサートモードから抜ける
inoremap <silent>jj <ESC>

" キー移動
noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $
inoremap <M-H> <Left>
inoremap <M-l> <Right>
inoremap <M-j> <Down>
inoremap <M-k> <Up>

" カッコ
inoremap {<Enter> {}<Left><CR><ESC><S-o><TAB>
inoremap [<Enter> []<Left><CR><ESC><S-o><TAB>
inoremap (<Enter> ()<Left><CR><ESC><S-o><TAB>

" ウィンドウ
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sn gt
nnoremap sp gT
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

" ---------------------------------------
" dein
" ---------------------------------------
nmap du :call dein#update()<cr>

" ---------------------------------------
" Unite
" ---------------------------------------
nnoremap sT :<C-u>Unite tab<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" ---------------------------------------
" neocomplete
" ---------------------------------------
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Use neocomplete.
let g:neocomplete#enable_at_startup=1
j
" Use smartcase.
let g:neocomplete#enable_smart_case=1

" ３文字以上の単語に対して補完
let g:neocomplete#min_keyword_length=3

 " Use underbar completion.
let g:neocomplete#enable_underbar_completion=1

" 辞書の場所
let g:neocomplete#sources#dictionary#dictionaries = {
\   'default' : '',
\   'scala' : '$HOME/.vim/dict/scala.dict',
\ }

" ---------------------------------------
" NERDTree
" ---------------------------------------
nmap nt :NERDTree<cr>
nmap <silent> <C-e> :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
omap <silent> <C-e> :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeShowHidden=1

" ---------------------------------------
" indentLine
" ---------------------------------------
set list listchars=tab:\¦\
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'

" ---------------------------------------
" airline
" ---------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

" ---------------------------------------
" Rust
" ---------------------------------------
let g:rustfmt_autosave = 1
let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'
set hidden
let g:racer_cmd = '$HOME/.cargo/bin/racer'
