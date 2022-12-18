=========================
== 編集方法：Space + E ==
=========================

# 忘れそうなVimの基本操作方法
カットせずに削除する     "____d
タブの移動               sp / sn
タブを閉じる             sq

# バッファ管理
バッファ一覧を開く           :BB
バッファ削除                 d

# Color ハイライト
色をハイライトする           :CA

# LSP
## エラー関連
エラー詳細を確認する         （エラー発生箇所で）<Space> + e
次のエラー箇所へ移動する     [d
前のエラー箇所へ移動する     ]d

## ナビゲーション
定義箇所に飛ぶ               gd
実装に飛ぶ                   gi
型定義                       gy
参照元一覧を表示する         gr

## ドキュメント
ヘッダコメントを参照する     K
メソッドシグネチャのヘルプ   Ctrl + k

## Metals 専用
### with telescope.nvim
バッファ内シンボル検索       Space gw
コードアクション             Space ca
  - 変数/メソッドの型を自動補完
  - Importの追加
  - などなど

## その他
コードアクション             Space ca
フォーマット                 Space f

# エラー一覧
エラー一覧の呼び出し(全体のエラー)          Shift + t Shift + t
エラー一覧の呼び出し(当バッファーのエラー)  Shift + t Shift + d
エラー一覧を閉じる                          TC

# deol - ターミナル
ターミナルを起動する         Ctrl + o
ターミナルを終了する         Esc

# telescope - ファジーファインダー
ファイルを検索する                      Space Space
ファイルを検索する（隠しファイル含む）  Space h
バッファーを検索する                    Space b
Grep                                    Space gr
git statusのプレビュー                  Space gs
LSPのコードアクション一覧を表示する     Space in

# blamer.nvim
git blame の表示ON/OFF       :BlamerToggle

# gitsigns.nvim
git 変更箇所のハイライト     :GWD

# caw.vim - コメント補助
行の先頭でコメント           <Leader> + c
コードの先頭でコメント       <Leader> + ,

# denops-addsymbols
ダブルクォートで囲む         :DSQ
シングルクォートで囲む       :DDQ
{} で囲む                    :DB
[] で囲む                    :DS
<> で囲む                    :DA
() で囲む                    :DP
