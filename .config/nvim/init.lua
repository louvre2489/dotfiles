-------------------
-- options --------
-------------------
local options = {
  syntax = 'on',

  -----------------
  -- File ---------
  -----------------
  swapfile = false,
  backup = false,
  undofile = false,
  -- ファイルが外部で変更された際に自動で読み込む
  autoread = true,
  -- 未保存ファイルの終了時に保存確認を行なう
  confirm = true,
  -- ファイル変更中に他のファイルを表示可能にする
  hidden = true,

  -----------------
  -- Display ------
  -----------------
  -- 編集中のファイル名を表示する
  title = true,
  -- 行番号
  number = true,
  relativenumber = true,
  ruler = true,
  --タブバーを常に表示する
  showtabline = 2,
  -- ステータスバーを常に表示する
  laststatus = 2,
  -- 256色対応
--  t_Co = 256,
  -- カーソル行の上下へのオフセットを設定する
  scrolloff = 4,

  -----------------
  -- 文字表示 -----
  -----------------
  encoding     = 'utf-8',
  fileencoding = 'utf-8',
  -- 不可視文字の表示方法を設定する
  listchars = 'eol:?',
  -- 曖昧文字幅
  ambiwidth = 'single',
  -- 検索結果をハイライト表示する
  hlsearch = true,
  -- カーソル行を強調表示する
  cursorline = true,
  -- 対応するカッコを強調表示する
  showmatch = true,

  -----------------
  -- Action -------
  -----------------
  -- インデントでずれる幅を設定する
  shiftwidth = 2,
  -- タブやバックスペースで処理するスペースの数を設定する
  softtabstop = 2,
  -- タブ幅を設定する
  tabstop = 2,
  -- 自動インデント
  smartindent = true,
  -- タブの代わりにスペースを挿入する
  expandtab = true,
  -- コンテキストに応じたタブの処理を行なう
  smarttab = true,
  -- 大文字と小文字を区別せず検索する
  ignorecase = true,
  -- インクリメンタルサーチを有効にする
  incsearch = true,
  -- 新しいウィンドウを下/右に開く
  splitbelow = true,
  splitright = true,
  -- バックスペースの影響範囲を設定する
  backspace = 'indent,eol,start',
  -- OSとクリップボードを共有する
  clipboard = 'unnamedplus',
  -- マウスを有効にする
  mouse = 'a',
  -- ビープを無効にする
  visualbell = false,
  whichwrap = 'b,s,h,l,<,>,[,]',
  -- コマンドラインモードで保存する履歴数を設定する
  history = 1000,
  -- コマンドラインモードでの補完を有効にする
  wildmenu = true,
  -- コマンドラインモードでの補完方法を設定する
  wildmode = 'list:longest,full',
  -- 入力中のコマンドを表示する
  showcmd = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

--------------------
-- Window Options --
--------------------
local windowOptions = {
  -- 改行コードを非表示にする
  list = false,
  -- 折り返しなし
  wrap = false,
}

for k, v in pairs(windowOptions) do
  vim.wo[k] = v
end

-------------------
-- autocmd --------
-------------------
local function on_ft(ft, cb)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = ft,
    callback = cb,
  })
end

-- デフォルトvimrc_exampleのtextwidth設定上書き
on_ft('text', function()
  vim.opt_local.textwidth = 0
end)

-- vimgrepの結果をQuickFixで開く
on_ft('QuickFixCmdPost ', function()
  vim.cmd('*grep* cwindow')
end)

-------------------
-- Key Mapping ----
-------------------
-- インサートモードから抜ける
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true })

-- ターミナルモードでインサートモードから抜ける
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', { noremap = true, silent = true })

-- カッコ
vim.api.nvim_set_keymap('i', '{<Enter>', '{}<Left><CR><ESC><S-o>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('i', '[<Enter>', '[]<Left><CR><ESC><S-o>', { noremap = true, silent = false })

-- ウィンドウ
vim.api.nvim_set_keymap('n', 's', '<Nop>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', 'sj', '<C-w>j', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', 'sk', '<C-w>k', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', 'sl', '<C-w>l', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', 'sh', '<C-w>h', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', 'ss', ':<C-u>sp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sv', ':<C-u>vs<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sv', ':<C-u>vs<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sn', ':<C-u>bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sp', ':<C-u>bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'sq', ':<C-u>bd<CR>', { noremap = true, silent = true })

-- vimgrep
vim.api.nvim_set_keymap('n', '[q', ':cprevious<CR>', { noremap = true, silent = false })    -- 前へ
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = false })        -- 次へ
vim.api.nvim_set_keymap('n', '[Q', ':<C-u>cfirst<CR>', { noremap = true, silent = false })  -- 最初へ
vim.api.nvim_set_keymap('n', ']Q', ':<C-u>clast<CR> ', { noremap = true, silent = false })  -- 最後へ

-------------------
-- augroup --------
-------------------
-- Scala Setting
local myScala = vim.api.nvim_create_augroup('MyScala', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.sbt,*.sc',
  group = myScala,
  command = 'set filetype=scala',
})

-- Json Setting
local myJson = vim.api.nvim_create_augroup('MyJson', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'json',
  group = myJson,
  command = 'syntax match Comment +\\/\\/.\\+$+',
})

-- Rust Setting
local myRust = vim.api.nvim_create_augroup('MyRust', { clear = true })
vim.api.nvim_create_autocmd({ 'BufWritePost ' }, {
  pattern = '*.rs',
  group = myRust,
  command = 'silent !cargo fmt',
})

-------------------
-- lazy.nvim ------
-------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = require('plugins')
require('lazy').setup(plugins)

--------------------
-- プラグイン設定 --
--------------------
-- NeoTree
---- ファイラーの起動方法
vim.api.nvim_set_keymap("n", "<C-e>","<cmd>NeoTreeFloatToggle<CR>",{noremap = true, silent = true})

-- catppuccin/nvim
vim.g.catppuccin_flavour = "frappe"
vim.api.nvim_command "colorscheme catppuccin"
