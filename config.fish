# PATH
set -x PATH $PATH $HOME/installApp/activator-dist-1.3.12/bin
set -x PATH $HOME/.pyenv/bin $PATH
set -x JAVAFX_HOME /usr/lib/jvm/java-8-oracle/jre/lib/ext

# PYENV
. (pyenv init - | psub)

# エンコード
set -x LANG ja_JP.UTF-8

# rmはゴミ箱へ
alias rm='trash'

# fzf
alias fff='fzf'
status --is-login; and status --is-interactive; and exec byobu-launcher
