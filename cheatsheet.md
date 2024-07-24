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
## ナビゲーション
シンボルの定義場所の検索     sah
定義箇所に飛ぶ               sagd
アウトライン                 sao

## ドキュメント
定義を参照する               sap
型定義を参照する             sagt
ヘッダコメントを参照する     K

## その他
コードアクション             saca
リネーム                     sar
リネーム（プロジェクト全体） sagr
フォーマット                 FormatCode

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
