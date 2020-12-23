[ -z "$PS1" ] && return

autoload -Uz colors
colors

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_no_store

# consle prompt
local p_info="%B%F{blue}%n@%m%f%b"
local p_cdir="%B%F{blue}%~%f%b"$'\n'
PROMPT="$p_info $p_cdir $ "


autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# completion
autoload -Uz compinit
compinit

# ignoreCase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# without the current directory
zstyle ':completion:*' ignore-parents parent pwd ..

# after sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# select by cursor
zstyle ':completion:*:default' menu select=1

# spelling
setopt correct

########################################
# vcs_info

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|)"

########################################
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt magic_equal_subst
setopt auto_menu
setopt extended_glob

########################################
# bind

# Emacs key bindings
bindkey -e

bindkey '^R' history-incremental-pattern-search-backward

function cd-up { zle push-line && LBUFFER='builtin cd ..' && zle accept-line }
zle -N cd-up
bindkey "^O" cd-up

########################################
# alias

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias nkfu='nkf -w -Lu --overwrite'
alias sudo='sudo '
alias cdd='cd `git rev-parse --show-toplevel`'
alias tigs='tig status'
alias tigb='tig refs'
alias rg='rg -S'
alias ds='docker-compose'
alias lad='lazydocker'
alias ku='kubectl'
alias g='git'
alias v='code'

alias -g L='| less'
alias -g G='| grep'

function set_apt() {
    function apt() {
        case $1 in
            i*)
                pacman -S $2;;
            se*)
                pacman -Ss $2;;
            sh*)
                pacman -Si $2;;
            *)
                echo "This '$0' is an alias for pacman"
                echo "Support: $0 [install|search|show] <package>"
                echo
                pacman -h;;
        esac
    }
}

case ${OSTYPE} in
    darwin*)
        #for Mac
        alias ls='ls -G'
        alias ll='ls -alF'
        alias la='ls -AG'
        alias l='ls -CFG'
        alias vi='vim'
        ;;
    linux*)
        alias ls='ls --color=auto'
        alias la='ls -a --color=auto'
        alias ll='ls -l --color=auto'
        alias l='ls -CF'
        ;;
    msys*)
        alias ls='ls --color=auto'
        alias la='ls -a --color=auto'
        alias ll='ls -l --color=auto'
        alias vi='vim'
        set_apt
        ;;
esac

function f() {
    find $1 -iname "*$2*"
}

[ -s "$HOME/.zshrc-after" ] && \. "$HOME/.zshrc-after"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
