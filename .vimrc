if &compatible
  set nocompatible
endif

" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" vimprocだけは最初にインストール
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
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
set lines=40
set columns=120
set nowrap

" file
set noswapfile
set nobackup
set noundofile
" indent
set smartindent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
" etc
set enc=japan
set smartcase
set history=50

syntax on
syntax enable
set background=dark
colorscheme material-theme

" デフォルトvimrc_exampleのtextwidth設定上書き
autocmd FileType text setlocal textwidth=0

" NERDTree
nmap <silent> <C-e> :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
omap <silent> <C-e> :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeShowHidden=1
