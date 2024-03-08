# zmodload zsh/zprof
# skip_global_compinit=1

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx;
fi
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/sbin:/usr/local/sbin:/sbin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.local/share/nvim/mason/bin/: $HOME/.rustup/"
# export FPATH="$zshDir/eza/completions/zsh:$FPATH"

autoload -Uz is-at-least

autoload -Uz compinit
ZSH_COMPDUMP=${ZSH_COMPDUMP:-${ZDOTDIR:-~}/.zcompdump}

# cache .zcompdump for about a day
if [[ $ZSH_COMPDUMP(#qNmh-20) ]]; then
  compinit -C -d "$ZSH_COMPDUMP"
else
  compinit -i -d "$ZSH_COMPDUMP"; touch "$ZSH_COMPDUMP"
fi
{
  # compile .zcompdump
  if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
    zcompile "$ZSH_COMPDUMP"
  fi
} &!

########################################################
#                       ANTIDOTE                      ##
########################################################

zstyle ':antidote:bundle' use-friendly-names 'yes'

source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
# antidote load ${ZDOTDIR:} ${ZDOTDIR:-~}/zplugins.txt
antidote load ${ZDOTDIR:-~}/.zplugins.conf

# antidoteDir="$HOME/.cache/antidote"
# source "$antidoteDir/romkatv/powerlevel10k/powerlevel10k.zsh-theme"

# # More performant version (requires manual resourcing changes)
# zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.zsh
# [[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt
#
# # Lazy-load antidote.
# fpath+=(${ZDOTDIR:-~}/.antidote)
# autoload -Uz $fpath[-1]/antidote
#
# if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
#   (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
# fi
# source $zsh_plugins



########################################################
#                        OPTIONS                      ##
########################################################

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
setopt +o nomatch

# setopt multios              # enable redirect to multiple streams: echo >file1 >file2
# setopt long_list_jobs       # show long list format job notifications
# setopt interactivecomments  # recognize comments

# The following lines were added by compinstall
zstyle :compinstall filename '/home/xempt/.zshrc'

export EDITOR=nvim
export VISUAL=nvim
export GCM_CREDENTIAL_STORE=cache
export DOOMWADDIR=$HOME/.config/gzdoom/WADS
export RIPGREP_CONFIG_PATH="/home/xempt/.config/ripgrep/.ripgreprc"
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export BAT_THEME="Catppuccin-mocha"
export EXA_COLORS="da=38;5;240"
export EZA_COLORS="da=38;5;240"
export ZSH_AUTOSUGGEST_STRATEGY=(completion)
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
export ZVM_CLIP_COPY=xclip
export ZVM_CLIP_PASTE=xclip

# _evalcache dircolors
eval "$(dircolors)"
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

########################################################
#                       ALIASES                       ##
########################################################

# eza aliases
alias l="eza -1 --icons --color=always"
alias ls="eza --icons --color=always"
alias la='eza -a --icons --color=always'
alias ld='eza -D --icons --color=always'
alias ll='eza -l --icons --git --color=always --no-user --time-style long-iso'
alias lla='eza -la --icons --git --color=always --no-user --time-style long-iso'
alias lS='eza -las size --icons --git --color=always --no-user --time-style long-iso --total-size'
alias lSd='eza -lDas size --icons --git --color=always --no-user --time-style long-iso --total-size'
alias l2='eza -TL 2 --icons --git --color=always --no-user --time-style long-iso'
alias l3='eza -TL 3 --icons --git --color=always --no-user --time-style long-iso'

#bat aliases
alias bat='bat'
alias less='bat'
alias cat='bat --paging never'
alias bathelp='bat --plain --language=help'
alias lc='lolcat'

# #fzf aliases
# alias fd="cd \$(find . -type d -print | fzf)"
alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias fv="nvim \$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')"
alias fcd="cd \$(dirname ./\$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'))"

alias md='mkdir -p'
alias rd='rmdir'
alias python="python3"
alias py="python3"
alias cpwd="pwd | tr -d '\n' | pbcopy && echo 'pwd copied to clipboard'"
alias nv="nvim"
alias nvi="nvim -u $HOME/.config/nvim/vi.lua"
alias nvdb="nvim '+:DBUI'"
alias nvsql="nvim '+:SQLua'"
alias vi="nvim --clean"
alias nvs="nvim -u $HOME/.config/nvim/simple.lua"
alias tard="tar_peek"
alias open="xdg-open"

alias shutdown="systemctl poweroff"
alias reboot='systemctl reboot'

alias picom="picom -b --config /home/xempt/.config/i3/picom.conf"
alias ':q'="exit"
# alias i3lock="i3lock-color"
# alias cl="clear"
# alias 'cd..'='cd_up'
# alias java8="/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java"
# alias vm="start_vm"

########################################################
#                      FUNCTIONS                      ##
########################################################

# bat-colored man pages
function help() {
    "$@" --help 2>&1 | bathelp
}

# counts lines of given files (extensions or names)
# and gives lines/file as well as total
function countl() {
    if [[ $# -eq 1 ]]; then
        find . -name "*$1" | sed 's/.*/"&"/' | xargs wc -l;
    elif [[ $# -eq 2 ]]; then
        find . -name "*$1" -o -name "*$2" | sed 's/.*/"&"/' | xargs wc -l;
    else
        for ext in "$@"; do
            find . -name "$ext" | sed 's/.*/"&"/' | xargs wc -l;
        done
    fi
}

# function to peek inside archives
# and see if suitable to extract in cwd
function tar_peek() {
    depth="*/*";
    tarReg="(.*((\.tar)|(\.tgz)|(\.tar.gz)))";
    # tarReg=".*((\.tar)|(\.tgz)|(\.tar.gz))";
    zipReg=".*(\.zip)$"
    for file in "$@"; do
        if [[ "$file" =~ $tarReg ]]; then
            tar --exclude="$depth" -tf "$file"
        elif [[ "$file" =~ $zipReg ]]; then
            zipinfo -1 "$file" | grep -v "/."
        fi
    done;
}

function hideTitle() {
    if [[ "$#" -eq 0 ]]; then
        winid=$(xdotool getactivewindow)
        xprop -id "$winid" -format _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS 2
    else
        xprop -name "$1" -format _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS 2
    fi
}

# helper to start VM with net opt
# function start_vm() {
#     sudo virsh net-start default;
#     virt-manager;
# }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# zprof
