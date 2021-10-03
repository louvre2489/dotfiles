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

FAST_HIGHLIGHT_STYLES[path]="fg=cyan,underline"
FAST_HIGHLIGHT_STYLES[path-to-dir]="fg=cyan"
FAST_HIGHLIGHT_STYLES[path_pathseparator]="fg=cyan"

# 補完
zinit light "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"

# Ctrl+r でコマンド履歴を検索
zinit light "zdharma/history-search-multi-word"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=''
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS=''

# ssh connection manager
zinit light "gko/ssh-connect"

# gitリポジトリのrootに移動する
zinit light "mollifier/cd-gitroot"
alias cdu="cd-gitroot"

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

# ----------------------------------
# パス関連
# ----------------------------------
# neovim
export XDG_CONFIG_HOME="$HOME/.config"

# Rust
#export PATH="$PATH:$HOME/.cargo/bin"

# Haskell
export PATH="$PATH:$HOME/.local/bin"

# Rust
source $HOME/.cargo/env

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# ----------------------------------
# sbt
# ----------------------------------
if [ -e /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi

export SBT_OPTS="-Xms2048m -Xmx4096m -Xss10M -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:ReservedCodeCacheSize=256m -XX:MaxMetaspaceSize=512m"

#export SBT_NATIVE_CLIENT=true

#----------------------------------
# ls の色付け
# ----------------------------------
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

#alias ls="ls --color"

#----------------------------------
# alias
# ----------------------------------
# 標準
alias vi='nvim'
alias vim='nvim'
alias la='ls -a --color=auto'
alias cls='clear;ls;'
alias ..='cd ..'
alias gr='grep --color'
alias sudovi='sudo nvim -u NONE'
alias sudovim='sudo nvim -u NONE'

# git
alias gis='git status'
alias gch='git switch'
alias gt='git difftool'

# Kubernetes
alias kube='kubectl'

# skanehira/docui
alias docui='docker run --rm -itv /var/run/docker.sock:/var/run/docker.sock skanehira/docui'

alias chatwork_oauth='docker run --rm --env-file ~/workspace/rust/chatwork_oauth/.env chatwork_oauth'

# custom function
alias gl='fshow'

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

    # Linuxではxdg-openでブラウザ起動
    alias open='xdg-open'

    # 開発用のシェル
    source ~/dotfiles/.zshrc.lc
    ;;
esac

# github起動
github() {
  open 'https://github.com/'$1
}

# ----------------------------------
# プロンプト
# ----------------------------------
if ! [ $(which starship) ]; then
  # starshipが無ければダウンロード
  sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi

# tomlはdotfiles内のファイルを直接参照する
export STARSHIP_CONFIG=~/dotfiles/starship.toml
# ログ出力先
export STARSHIP_CACHE=~/.starship/cache

eval "$(starship init zsh)"

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
#  prompt_${prompt_theme}_precmd
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
# Python
# ----------------------------------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ----------------------------------
# asdf
# ----------------------------------
if [ -e $HOME/.asdf/asdf.sh ]; then
  # ファイルがある場合のみ設定
  . $HOME/.asdf/asdf.sh
fi

# ----------------------------------
# 補完を有効にする
# ----------------------------------
# Docker
if [ ! -e ~/.zsh/completion/_docker ]; then
  # ファイルがなければダウンロード
  mkdir -p ~/.zsh/completion
  curl -L https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker > ~/.zsh/completion/_docker
fi

docker_comp(){
  fpath=(~/.zsh/completion $fpath)
}

docker_comp

# Docker-Compose
if [ ! -e ~/.zsh/completion/_docker-compose ]; then
  # ファイルがなければダウンロード
  mkdir -p ~/.zsh/completion
  curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose
fi

docker_compose_comp(){
  fpath=(~/.zsh/completion $fpath)
}

docker_compose_comp

# Kubernetes
kube_comp(){
  # 補完スクリプト
  source <(kubectl completion zsh)

  complete -F __start_kubectl kube
}

# kubectlは頻繁に使わないのに補完設定呼び出しに時間がかかるのでコメントアウト
# 補完がほしければ自分でkube_compを叩くように運用で回避する
#kube_comp

# asdf
asdf_comp(){
  fpath=(${ASDF_DIR}/completions $fpath)
}

asdf_comp

# 補完機能を有効にする
autoload -Uz compinit && compinit -i
