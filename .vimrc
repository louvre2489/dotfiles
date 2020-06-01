"unlet! skip_defaults_vim
"source $VIMRUNTIME/defaults.vim

" ---------------------------------------
" encoding
" ---------------------------------------
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
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

colorscheme landscape
"colorscheme seoul256

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

" 改行コードを非表示にする
set nolist

" 強調表示する列を設定する
"set colorcolumn=80

" 対応するカッコを強調表示する
set showmatch

" FloatWindow用にNormalFloatグループを設定
highlight NormalFloat ctermfg=231 ctermbg=240  cterm=NONE

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

" ターミナルモードでインサートモードから抜ける
tnoremap <ESC> <C-\><C-n>

" キー移動
noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

" カッコ
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap ({<Enter> ({})<Left><Left><CR><ESC><S-o>

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

" vimgrep
nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR>  " 最後へ
" vimgrepの結果をQuickFixで開く
autocmd QuickFixCmdPost *grep* cwindow

" NORMALモードに戻るときにIMEをOFFにする
function! ImInActivate()
  call system('fcitx-remote -c')
endfunction
inoremap <silent> jj <ESC>:call ImInActivate()<CR>
inoremap <silent> っｊ <ESC>:call ImInActivate()<CR>
inoremap <silent> <C-j> <ESC>:call ImInActivate()<CR>

" ---------------------------------------
" Scala Setting
" ---------------------------------------
augroup MyScala
  autocmd!
augroup END

function! EnableScala()
  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " Used in the tab autocompletion for coc
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap keys for gotos
  nmap <silent> cgd <Plug>(coc-definition)
  nmap <silent> cgy <Plug>(coc-type-definition)
  nmap <silent> cgi <Plug>(coc-implementation)
  nmap <silent> cgr <Plug>(coc-references)

  nnoremap <silent> cK :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
endfunction
autocmd MyScala FileType scala,sbt call EnableScala()


" ---------------------------------------
" javaScript Setting
" ---------------------------------------
augroup MyJsRc
  autocmd!
augroup END

function! EnableJavascript()
  " ---------------------------------------
  " tigris.nvim
  " ---------------------------------------
  let g:tigris#enabled = 1
  let g:tigris#on_the_fly_enabled = 1
  let g:tigris#delay = 300

  " ---------------------------------------
  " javascript-librariws-syntax
  " ---------------------------------------
  let g:used_javascript_libs = 'jquery,react,flux,vue'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_vue = 1

  " ---------------------------------------
  " vim-vue
  " ---------------------------------------
  autocmd FileType vue syntax sync fromstart
  set ttyfast
  set lazyredraw

endfunction
autocmd MyJsRc FileType html,javascript,javascript.jsx,vue,typescript call EnableJavascript()

" ---------------------------------------
" HTML Setting
" ---------------------------------------
augroup MyHTML
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" ---------------------------------------
" Json Setting
" ---------------------------------------
augroup MyJson
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

" ---------------------------------------
" Python Setting
" ---------------------------------------
" 設定方法
" インストール可能なPythonのバージョンを確認
" $ pyenv install --list
" インストール済みのPythonバージョンを確認
" $ pyenv versions

" python2環境
" $ pyenv install 2.X.X
" $ pyenv virtualenv 2.X.X neovim2
" $ pyenv activate neovim2
" $ pip2 install neovim
" $ pyenv which python
"
" python3環境
" $ pyenv install 3.X.X
" $ pyenv virtualenv 3.X.X neovim3
" $ pyenv activate neovim3
" $ pip install neovim
" $ pyenv which python
"
" .zshrc には以下の設定を
" export PYENV_ROOT="$HOME/.pyenv"
" export PATH="$PYENV_ROOT/bin:$PATH"
" eval "$(pyenv init -)"
" eval "$(pyenv virtualenv-init -)"
let g:python_host_prog = $PYENV_ROOT.'/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim3/bin/python'
