#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# emacsのキーバインド
bindkey -e

# Customize to your needs...
alias rm='trash'

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# ビープを鳴らさない
setopt no_beep

# 色を使う
setopt prompt_subst

# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# Ctrl+Dでログアウトしないようにする
setopt IGNOREEOF

# 日本語を使用するための設定
export LANG=ja_JP.UTF-8

setopt MULTIOS              # Write to multiple descriptors.

setopt EXTENDED_GLOB        # Use extended globbing syntax.

# ls 時の色を設定する
export CLICOLOR=true
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32p:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

# 標準エディタを設定する
export EDITOR=vim

# ----------------------------------
# autoload
# ----------------------------------
# 補完機能を有効にする
autoload -Uz compinit
compinit

# フック機能を有効にする
autoload -Uz add-zsh-hook

# URLをエスケープする
autoload -Uz url-quote-magic
# 文字入力時にURLをエスケープする
zle -N self-insert url-quote-magic

# VCS情報の表示を有効にする
autoload -Uz vcs_info

# 色を使用出来るようにする
autoload -Uz colors
colors

# ----------------------------------
# zstyle
# ----------------------------------
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*:default' menu select=1 matcher-list 'm:{a-z}={A-Z}'

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

# ----------------------------------
# プラグイン
# ----------------------------------
# autosuggestionsの色
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

# ----------------------------------
# パス関連
# ----------------------------------
export PATH="$PATH:$HOME/installApp/activator-dist-1.3.12/bin"
export PATH="$PATH:/usr/lib/jvm/java-8-oracle/jre/lib/ext"

# neovim
export XDG_CONFIG_HOME="$HOME/.config"

# ----------------------------------
# プロンプト
# ----------------------------------
function _git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
  echo "${ref/refs\/heads\// }$(parse_git_dirty)"
}

function parse_git_dirty() {
  local STATUS=''
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ $POST_1_7_2_GIT -gt 0 ]]; then
      FLAGS+='--ignore-submodules=dirty'
    fi
    if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

function _git_info() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    local BG_COLOR=green
    if [[ -n $(parse_git_dirty) ]]; then
      BG_COLOR=yellow
      FG_COLOR=black
    fi

    if [[ ! -z $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        BG_COLOR=red
        FG_COLOR=white
    fi
    echo "%{%K{$BG_COLOR}%}%{%F{$FG_COLOR}%} $(_git_prompt_info) %{%F{$BG_COLOR}%K{blue}%}"
  else
    echo "%{%K{blue}%}"
  fi
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT_HOST='%{%b%F{gray}%K{black}%} %(?.%{%F{green}%}✔.%{%F{red}%}✘)%{%F{yellow}%} %n %{%F{black}%}'
PROMPT_DIR='%{%F{white}%} %~%  '
PROMPT_SU='%(!.%{%k%F{blue}%K{black}%}%{%F{yellow}%} ⚡ %{%k%F{black}%}.%{%k%F{blue}%})%{%f%k%b%}'
PROMPT_TIME='%{%F{green}%} [%*]%{%F{white}%}'

PROMPT='$(_git_info)$PROMPT_DIR$PROMPT_SU$PROMPT_TIME
$(virtualenv_info) > '

# ----------------------------------
# Ctrl-PとCtrl-Nで前方一致検索
# ----------------------------------
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# ----------------------------------
# Ctrl-^ で cd ..
# ----------------------------------
function cdup() {
  echo
  cd ..
  prompt_${prompt_theme}_precmd
  zle reset-prompt
  return 0
}
zle -N cdup
bindkey '^\^' cdup

# ----------------------------------
# peco
# ----------------------------------
function peco-select-history() {
  BUFFER=$(\history -n 1 | tac | peco)
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# ----------------------------------
# z
# ----------------------------------
# 設定読み込み
source ~/z/z.sh

# pecoとの連動
function peco-z-search
{
  local res=$(z | sort -rn | cut -c 12- | peco)
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
    zle accept-line
  else
    return 1
  fi
}
zle -N peco-z-search
bindkey '^@' peco-z-search

