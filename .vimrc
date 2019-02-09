"unlet! skip_defaults_vim
"source $VIMRUNTIME/defaults.vim

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
inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

" カッコ
"inoremap {<Enter> {}<Left><CR><ESC><S-o><TAB>
"inoremap [<Enter> []<Left><CR><ESC><S-o><TAB>
"inoremap (<Enter> ()<Left><CR><ESC><S-o><TAB>
"inoremap ({<Enter> ({})<Left><Left><CR><ESC><S-o><TAB>

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
" prefix
" ---------------------------------------
" denite
nmap <Space> [denite]

" NERDTree
nmap <C-e> [nerdtree]

" ---------------------------------------
" gtags
" ---------------------------------------
let g:Gtags_Auto_Map = 0
let g:Gtags_OpenQuickfixWindow = 1

" キーマップ
" Show definetion of function cousor word on quickfix
nmap <silent> <C-]> :<C-u>exe("Gtags ".expand('<cword>'))<CR>
" Show reference of cousor word on quickfix
nmap <silent> <C-t> :<C-u>exe("Gtags -r ".expand('<cword>'))<CR>

" ---------------------------------------
" gen_tags
" ---------------------------------------
let g:gen_tags#gtags_auto_gen = 1

" ---------------------------------------
" denite
" ---------------------------------------
" キーマップ
" カレントディレクトリを表示
nnoremap <silent> [denite]a :Denite file_rec<CR>

" バッファを表示
nnoremap <silent> [denite]b :Denite buffer<CR>

" ファイル一覧を表示
nnoremap <silent> [denite]f :Denite -buffer-name=file file<CR>

" 最近使ったファイルの一覧
nnoremap <silent> [denite]fr :Denite file_old<CR>

" プロンプトの左端に表示される文字を指定
call denite#custom#option('default', 'prompt', '>')
" deniteの起動位置をtopに変更
call denite#custom#option('default', 'direction', 'top')

" denite/insert モードのときは，C- で移動できるようにする
call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>')

" ESCキーでdeniteを終了
call denite#custom#map('insert', '<esc>', '<denite:enter_mode:normal>', 'noremap')

" C-N,C-Pで上下移動
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

" grep検索
nnoremap <silent> [denite],g :<C-u>Denite -buffer-name=search -mode=normal grep<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> [denite],cg :<C-u>DeniteCursorWord grep -buffer-name=search line<CR><C-R><C-W><CR>

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
\  neosnippet#expandable_or_jumpable() ?
\   "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"

" ---------------------------------------
" neosnippet
" ---------------------------------------
" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=niv
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
let g:airline#extensions#default#layout = [
	\ [ 'z', 'a', 'b', 'c' ],
	\ [ 'y', 'x', 'error', 'warning']
	\ ]
" ---------------------------------------
" vim-gitgutter
" ---------------------------------------
" diffを縦分割
set diffopt+=vertical

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

" ---------------------------------------
" ale
" ---------------------------------------
" 保存時のみ実行する
let g:ale_lint_on_text_changed = 0
" Lint
let g:ale_linters = {
      \ 'css': ['stylelint'],
      \ 'javascript': ['eslint'],
      \ 'vue': ['eslint'],
      \ }
" 整形
let g:ale_fixers = {
      \ 'javascript': ['prettier-eslint'],
      \ 'css': ['stylelint'],
      \ 'scss': ['stylelint'],
      \ }
let g:ale_fix_on_save = 1

" Ctrl + kで次の指摘へ、Ctrl + jで前の指摘へ移動
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ---------------------------------------
" caw
" ---------------------------------------
" <Leader> is \
" 行の最初の文字の前にコメント文字をトグル
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" 行頭にコメントをトグル
nmap <Leader>, <Plug>(caw:zeropos:toggle)
vmap <Leader>, <Plug>(caw:zeropos:toggle)

" ---------------------------------------
" LanguageClient-neovim
" ---------------------------------------
"let g:LanguageClient_serverCommands = {
"    \ 'vue': ['vls'],
"    \ 'html': [],
"    \ 'javascript': [],
"    \ 'css': [],
"    \ }
"let g:LanguageClient_autoStart = 1
"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
"
"setlocal iskeyword+=$
"setlocal iskeyword+=-

" ---------------------------------------
" tern-js
" ---------------------------------------
let g:deoplete#sources#ternjs#tern_bin = '/usr/local/bin/tern'
let g:deoplete#sources#ternjs#timeout = 1
let g:deoplete#sources#ternjs#filetypes = ['jsx', 'javascript.jsx', 'vue']

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
