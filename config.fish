# PATH
set -x PATH $PATH $HOME/installApp/activator-dist-1.3.12//bin
set -x PATH $HOME/.pyenv/bin $PATH

# PYENV
. (pyenv init - | psub)

# エンコード
set -x LANG ja_JP.UTF-8

# rmはゴミ箱へ
alias rm='trash'

# fzf
alias fff='fzf'
