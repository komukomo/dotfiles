[ -z "$PS1" ] && return

export LC_TYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8

autoload -Uz colors
colors

# Emacs key bindings

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# consle prompt
local p_cdir="%B%F{blue}[%~]%f%b"$'\n'
local p_info="%n@%m"
PROMPT=" $p_cdir $ "


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
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_nodups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt auto_menu
setopt extended_glob

########################################
# bind

bindkey -e
bindkey '^R' history-incremental-pattern-search-backward

########################################
# alias

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias nkfu='nkf -w -Lu --overwrite'
alias sudo='sudo '

case ${OSTYPE} in
    darwin*)
        #for Mac
        alias ls='ls -G'
        alias ll='ls -alF'
        alias la='ls -AG'
        alias l='ls -CFG'
        ;;
    linux*)
        alias ls='ls --color=auto'
        alias la='ls -a --color=auto'
        alias ll='ls -l --color=auto'
        ;;
esac