scriptencoding utf-8

" ---------------------------------------
" dein
" ---------------------------------------
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

" キーマップ
nmap du :call dein#update()<cr>

" ---------------------------------------
" color scheme
" ---------------------------------------
colorscheme landscape

" ---------------------------------------
" File
" ---------------------------------------
set noswapfile
set nobackup
set noundofile

" ファイルが外部で変更された際に自動で読み込む
set autoread

" 未保存ファイルの終了時に保存確認を行なう
set confirm

" ファイル変更中に他のファイルを表示可能にする
set hidden

" ---------------------------------------
" Display
" ---------------------------------------
" [基本的な見た目]
" syntax
syntax on

" 編集中のファイル名を表示する
set title

" 行番号
set number

" ルーラーを表示する
set ruler

" タブバーを常に表示する
set showtabline=2

" ステータスバーを常に表示する
set laststatus=2

" 折り返しなし
set nowrap

" 256色対応
set t_Co=256

" カーソル行の上下へのオフセットを設定する
set scrolloff=4

" デフォルトvimrc_exampleのtextwidth設定上書き
autocmd FileType text setlocal textwidth=0

" [文字表示関連]
" 文字コードを設定する
set encoding=utf8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
"set enc=japan

" 不可視文字の表示方法を設定する
set listchars=eol:?

" 文字崩れの発生を抑止
set ambiwidth=double

" [強調]
" 検索結果をハイライト表示する
set hlsearch

" カーソル行を強調表示する
set cursorline

" 強調表示する列を設定する
"set colorcolumn=80

" 対応するカッコを強調表示する
set showmatch

" ---------------------------------------
" Action
" ---------------------------------------
" [インデント/タブ/スペース]
" 自動インデント
set autoindent

" タブの代わりにスペースを挿入する
set expandtab

" インデントでずれる幅を設定する
set shiftwidth=2

" タブやバックスペースで処理するスペースの数を設定する
set softtabstop=2

" タブ幅を設定する
set tabstop=2

" コンテキストに応じたタブの処理を行なう
set smarttab

" [検索]
" 大文字と小文字を区別せず検索する
set ignorecase

" インクリメンタルサーチを有効にする
set incsearch

" [その他]
" 新しいウィンドウを下/右に開く
set splitbelow
set splitright

" バックスペースの影響範囲を設定する
set backspace=indent,eol,start

" OSとクリップボードを共有する
"set clipboard=unnamed,autoselect
set clipboard=unnamedplus

" マウスを有効にする
set mouse=a

" ビープを無効にする
set visualbell t_vb=

" 行頭・行末の左右移動で行を移動する
set whichwrap=b,s,h,l,<,>,[,]

" コマンドラインモードで保存する履歴数を設定する
set history=1000

" コマンドラインモードでの補完を有効にする
set wildmenu

" コマンドラインモードでの補完方法を設定する
set wildmode=list:longest,full

" 入力中のコマンドを表示する
set showcmd

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

" NORMALモードに戻るときにIMEをOFFにする
function! ImInActivate()
  call system('fcitx-remote -c')
endfunction
inoremap <silent> jj <ESC>:call ImInActivate()<CR>
inoremap <silent> っｊ <ESC>:call ImInActivate()<CR>
inoremap <silent> <C-j> <ESC>:call ImInActivate()<CR>

" ---------------------------------------
" prefix
" ---------------------------------------
" Unite
nmap <Space> [unite]

" NERDTree
nmap <C-e> [nerdtree]

" neosnippet
nmap <C-k> [neosnippet]

" ---------------------------------------
" unite
" ---------------------------------------
" 挿入モードで開始する
let g:unite_enable_start_insert=1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" キーマップ
" カレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>

" バッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>

" 最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>

" バッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>

" レジストリを表示
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>

" タブを表示
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>

" ヒストリ/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>

" outline
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>

" grep検索
nnoremap <silent> [unite]g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> [unite]wg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> [unite]rg  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
    " ESCでuniteを終了
    nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}

" ---------------------------------------
" deoplete
" ---------------------------------------
" 起動時に有効にする
let g:deoplete#enable_at_startup = 1

" 補完を開始する文字数
let g:deoplete#auto_complete_start_length = 1

" 大文字小文字を無視する
let g:deoplete#enable_ignore_case = 1

" バッファからも補完候補を読む
let g:deoplete#file#enable_buffer_path = 1

inoremap <expr><tab> pumvisible() ? "\<C-n>" :
\ neosnippet#expandable_or_jumpable() ?
\    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"

" ---------------------------------------
" neosnippet
" ---------------------------------------
" Plugin key-mappings.
imap [neosnippet] <Plug>(neosnippet_expand_or_jump)
smap [neosnippet] <Plug>(neosnippet_expand_or_jump)
xmap [neosnippet] <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" ---------------------------------------
" NERDTree
" ---------------------------------------
"nmap nt :NERDTree<cr>
nmap nt <plug>NERDTreeTabsToggle<cr>
nmap <silent> [nerdtree] <plug>NERDTreeTabsToggle<CR>
vmap <silent> [nerdtree] <Esc> <plug>NERDTreeTabsToggle<CR>
omap <silent> [nerdtree] <plug>NERDTreeTabsToggle<CR>
imap <silent> [nerdtree] <Esc> :<plug>NERDTreeTabsToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeShowHidden=1

" ---------------------------------------
" Vim-NERDTree-Tabs
" ---------------------------------------
" ファイルが指定されていなければNERD treeを有効にする
if argc() == 0
  let g:nerdtree_tabs_open_on_console_startup = 1
end

" ---------------------------------------
" nerdtree-git-plugin
" ---------------------------------------
let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "➤",
\ "Staged"    : "✚",
\ "Untracked" : "✭",
\ "Renamed"   : "➜",
\ "Unmerged"  : "═",
\ "Deleted"   : "✖",
\ "Dirty"     : "✗",
\ "Clean"     : "✔︎",
\ 'Ignored'   : '☒',
\ "Unknown"   : "?"
\ }

" ---------------------------------------
" indentLine
" ---------------------------------------
set list listchars=tab:\¦\
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'

" ---------------------------------------
" vim-airline
" ---------------------------------------
" タブバーのカスタマイズを有効にする
let g:airline#extensions#tabline#enabled = 1

" タブバーの右領域を非表示にする
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0

" テーマ
let g:airline_theme='jellybeans'
let g:airline_powerline_fonts = 1

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#vcs_priority = ["git", "mercurial"]

" ---------------------------------------
" vim-gitgutter
" ---------------------------------------
" 表示列の背景色変更
let gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg = lightgrey

" 表示するマークのカスタマイズ
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➤'
let g:gitgutter_sign_removed = '✘'
let g:gitgutter_sign_modified_removed = "➜"

" 変更箇所に着色
let g:gitgutter_highlight_lines = 1
autocmd Vimenter,Colorscheme * :hi GitGutterAddLine ctermfg=none ctermbg=17
autocmd Vimenter,Colorscheme * :hi GitGutterChangeLine ctermfg=none ctermbg=53
autocmd Vimenter,Colorscheme * :hi GitGutterDeleteLine ctermfg=none ctermbg=52
autocmd Vimenter,Colorscheme * :hi GitGutterChangeDeleteLine ctermfg=none ctermbg=53

" ---------------------------------------
" emmet-vim
" ---------------------------------------
let g:user_emmet_settings = {
\    'variables': {
\      'lang': "ja"
\    },
\   'indentation': '  '
\ }
