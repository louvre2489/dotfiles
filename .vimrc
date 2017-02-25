if &compatible
  set nocompatible
endif

" dein.vim�̃f�B���N�g��
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" �Ȃ����git clone
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

" vimproc�����͍ŏ��ɃC���X�g�[��
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

" ���̑��C���X�g�[�����Ă��Ȃ����̂͂�����ɓ����
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

" ���s���Ɏ����ŃC���f���g���s�Ȃ�
set autoindent
" �t�@�C�����O���ŕύX���ꂽ�ۂɎ����œǂݍ���
set autoread
" �o�b�N�X�y�[�X�̉e���͈͂�ݒ肷��
set backspace=indent,eol,start
" OS�ƃN���b�v�{�[�h�����L����
set clipboard=unnamed,autoselect
" �����\��������ݒ肷��
set colorcolumn=80
" ���ۑ��t�@�C���̏I�����ɕۑ��m�F���s�Ȃ�
set confirm
" �J�[�\���s�������\������
set cursorline
" �����R�[�h��ݒ肷��
set encoding=utf8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
" �^�u�̑���ɃX�y�[�X��}������
set expandtab
" �t�@�C���ύX���ɑ��̃t�@�C����\���\�ɂ���
set hidden
" �R�}���h���C�����[�h�ŕۑ����闚�𐔂�ݒ肷��
set history=1000
" �������ʂ��n�C���C�g�\������
set hlsearch
" �啶���Ə���������ʂ�����������
set ignorecase
" �C���N�������^���T�[�`��L���ɂ���
set incsearch
" �X�e�[�^�X�o�[����ɕ\������
set laststatus=2
" �s�������̕\�����@��ݒ肷��
set listchars=eol:?
" �}�E�X��L���ɂ���
set mouse=a
" ���[���[��\������
set ruler
" �J�[�\���s�̏㉺�ւ̃I�t�Z�b�g��ݒ肷��
set scrolloff=4
" �C���f���g�ł���镝��ݒ肷��
set shiftwidth=2
" ���͒��̃R�}���h��\������
set showcmd
" �Ή�����J�b�R�������\������
set showmatch
" �^�u�o�[����ɕ\������
set showtabline=2
" ���s���͍s�̖����ɂ��킹�ăC���f���g�𑝌�����
set smartindent
" �R���e�L�X�g�ɉ������^�u�̏������s�Ȃ�
set smarttab
" �^�u��o�b�N�X�y�[�X�ŏ�������X�y�[�X�̐���ݒ肷��
set softtabstop=2
" �V�����E�B���h�E����/�E�ɊJ��
set splitbelow
set splitright
" �^�u����ݒ肷��
set tabstop=2
" �ҏW���̃t�@�C������\������
set title
" �r�[�v�𖳌��ɂ���
set visualbell t_vb=
" �s���E�s���̍��E�ړ��ōs���ړ�����
set whichwrap=b,s,h,l,<,>,[,]
" �R�}���h���C�����[�h�ł̕⊮��L���ɂ���
set wildmenu
" �R�}���h���C�����[�h�ł̕⊮���@��ݒ肷��
set wildmode=list:longest,full
" �F
syntax on
syntax enable
set background=dark
colorscheme material-theme

" �f�t�H���gvimrc_example��textwidth�ݒ�㏑��
autocmd FileType text setlocal textwidth=0

" �L�[�}�b�v
" �C���T�[�g���[�h���甲����
inoremap jj <ESC>
" �L�[�ړ�
noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $
" �E�B���h�E
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
" dein
nmap du :call dein#update()<cr>
" NERDTree
nmap nt :NERDTree<cr>
" Unite
nnoremap sT :<C-u>Unite tab<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" NERDTree
nmap <silent> <C-e> :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
omap <silent> <C-e> :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeShowHidden=1