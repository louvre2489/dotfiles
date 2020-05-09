#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

## Source Prezto.
#if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
#fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    "zinit-zsh/z-a-patch-dl" \
    "zinit-zsh/z-a-as-monitor"\
    "zinit-zsh/z-a-bin-gem-node"
### End of Zinit's installer chunk

# Preztoのセットアップ
#zinit snippet "PZT::modules/helper/init.zsh"

# oh-my-zshのセットアップ
zinit snippet "OMZL::git.zsh"
zinit snippet "OMZP::git"
zinit cdclear -q

# ----------------------------------
# プラグイン
# ----------------------------------
# 256カラー
zplugin light "chrissicool/zsh-256color"

# シンタックスハイライト
zinit light "zdharma/fast-syntax-highlighting"
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    "zdharma/fast-syntax-highlighting" \
 blockf \
    "zsh-users/zsh-completions"\
 atload"!_zsh_autosuggest_start" \
    "zsh-users/zsh-autosuggestions"

# 補完
zinit light "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=12"

# Ctrl+r でコマンド履歴を検索
zinit light "zdharma/history-search-multi-word"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS=''

# git completion by fzf
# usage) git checkout **
zinit light "hschne/fzf-git"

# ssh connection manager
zinit light "gko/ssh-connect"

# ----------------------------------
# シェル設定
# ----------------------------------
# 起動時にtmuxを起動する
if [ $SHLVL = 1 ]; then
  tmux
fi

# emacsのキーバインド
bindkey -e

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
#export EDITOR=vim
export EDITOR=nvim

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
#    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

# ----------------------------------
# パス関連
# ----------------------------------
export PATH="$PATH:$HOME/installApp/activator-dist-1.3.12/bin"
export PATH="$PATH:/usr/lib/jvm/java-8-oracle/jre/lib/ext"

# neovim
export XDG_CONFIG_HOME="$HOME/.config"

# webpack
export PATH="$PATH:./node_modules/.bin"

# LSP for Elm
export PATH="$PATH:$HOME/LSP/elm-language-server"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

 #----------------------------------
# alias
# ----------------------------------
# 標準
alias vi='nvim'
alias vim='nvim'
alias la='ls -a --color=auto'
alias ..='cd ..'
alias gr='grep --color'
alias sudovi='sudo nvim -u NONE'
alias sudovim='sudo nvim -u NONE'
alias kube='kubectl'

# skanehira/docui
alias docui='docker run --rm -itv /var/run/docker.sock:/var/run/docker.sock skanehira/docui'

# custom function
alias gl='fshow'

# ----------------------------------
# プロンプト
# ----------------------------------
zinit snippet OMZT::gnzh
zinit light agnoster/agnoster-zsh-theme

# prompt_end をオーバーライド
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''

  #Adds the new line and ➜ as the start character.
  printf "\n >";
}

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
# fzf
# ----------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 60% --reverse --border'

# アクセスしたことのあるディレクトリの一覧
function fzf-z-search() {
    local res=$(z | sort -rn | cut -c 12- | fzf)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}
zle -N fzf-z-search
bindkey '^@' fzf-z-search

# Git log をキレイに見せる
fshow() {
  local out shas sha q k
  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --color=always $shas | less -R
    else
      for sha in $shas; do
        git show --color=always $sha | less -R
      done
    fi
  done
}

# ----------------------------------
# z
# ----------------------------------
# 設定読み込み
source ~/z/z.sh

# ----------------------------------
# kubectl
# ----------------------------------
# 補完スクリプト
source <(kubectl completion zsh)

# ----------------------------------
# Macの場合だけ読み込み
# ----------------------------------
case ${OSTYPE} in
  darwin*)
    # Mac向けの設定
    #
    # rmはゴミ箱に送る
    alias rm='rmtrash'

    # 開発用のシェル
    source ~/dotfiles/.zshrc.cw
    ;;
  linux*)
    # Linux向けの設定
    #
    # rmはゴミ箱に送る
    alias rm='trash'
    ;;
esac

