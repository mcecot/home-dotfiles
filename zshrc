#-------------------------------------------------------------------
# Kuetemeier.NET GmbH - System configuration set
# http://www.kuetemeier.net
#
# (c) Copyright 2009-2013 by Jörg Kütemeier - all rights are reserved
#

# path definitions
export PATH=/opt/jk-sys/bin:/opt/kn-sys/bin:~/bin:$PATH:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/icinga/libexec:/opt/play:/opt/scala/bin

#-------------
# zsh options
setopt no_beep auto_cd complete_in_word correct rm_star_wait
setopt correct                  # command correction

#--------
# history

export HISTFILE=~/.zsh_history
export SAVEHIST=10000
export HISTSIZE=12000

setopt append_history           # use history for multiple zsh instances
setopt extended_history         # puts timestamps in the history
setopt hist_allow_clobber
setopt hist_reduce_blanks       # remov unneeded blanks
setopt inc_append_history
setopt share_history
setopt hist_no_store            # commands like history or fc are no longer stored
setopt hist_ignore_all_dups     # no duplicated entries like ls,cd,pwd etc.
setopt hist_ignore_space        # do not save commands with leading space in history


# search environment for editor and take the first
export EDITOR=${$(whence -p vim vi nano)[1]}
export PAGER=less
autoload -U compinit && compinit
compinit

export TZ='Europe/Berlin'

# report stats after 2 seconds
export REPORTTIME=2

# info - DO NOT: eval `dircolors`
# color ls for linux:
export LS_OPTIONS='--color=auto'

# color ls for mac:

alias l="ls -la"
alias v="vim"
alias icc="/usr/local/icinga/bin/icinga -v /usr/local/icinga/etc/icinga.cfg"
alias icr="service icinga restart"
alias icl="service icinga reload"
# always load vim if awailable, else use plain vi
alias vi=${$(whence -p vim vi)[1]}

# emacs style line editing
bindkey -e

# mac terminal config:
bindkey "^[[3~" delete-char
bindkey '^?' backward-delete-char
bindkey '^r' backward-delete-char

#bindkey '^r' history-incremental-search-backward
#bindkey '^?' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand


#history only on first substring of command you're typing
#bindkey "\e[A" up-line-or-search
#bindkey "\e[B" down-line-or-search
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
#new iterm binds up arrow to this, wtf, ^[[A is standard on all other xterm's
bindkey "\eOA" history-beginning-search-backward
bindkey "\eOB" history-beginning-search-forward

autoload up-line-or-beginning-search \
down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

# Xterm resizing-fu.
# Based on http://svn.kitenet.net/trunk/home-full/.zshrc?rev=11710&view=log (by Joey Hess)
  alias hide='echo -en "\033]50;nil2\007"'
  alias tiny='echo -en "\033]50;-misc-fixed-medium-r-normal-*-*-80-*-*-c-*-iso8859-15\007"'
  alias small='echo -en "\033]50;6x10\007"'
  alias medium='echo -en "\033]50;-misc-fixed-medium-r-normal--13-120-75-75-c-80-iso8859-15\007"'
  alias default='echo -e "\033]50;-misc-fixed-medium-r-normal-*-*-140-*-*-c-*-iso8859-15\007"'
  alias large='echo -en "\033]50;-misc-fixed-medium-r-normal-*-*-150-*-*-c-*-iso8859-15\007"'
  alias huge='echo -en "\033]50;-misc-fixed-medium-r-normal-*-*-210-*-*-c-*-iso8859-15\007"'
  alias smartfont='echo -en "\033]50;-artwiz-smoothansi-*-*-*-*-*-*-*-*-*-*-*-*\007"'
  alias semifont='echo -en "\033]50;-misc-fixed-medium-r-semicondensed-*-*-120-*-*-*-*-iso8859-15\007"'


status() {
        print ""
        print "Date..: "$(date "+%Y-%m-%d %H:%M:%S")""
        print "Shell.: Zsh $ZSH_VERSION (PID = $$, $SHLVL nests)"
        print "Term..: $TTY ($TERM), $BAUD bauds, $COLUMNS x $LINES cars"
        print "Login.: $LOGNAME (UID = $EUID) on $HOST"
        print "System: $(cat /etc/[A-Za-z]*[_-][rv]e[lr]*)"
        print "Uptime:$(uptime)"
        print ""
  }

if [ -d /usr/local/kuetemeier.net ] ; then
    export MIBDIRS="/usr/share/snmp/mibs:/usr/local/kuetemeier.net/monitoring/snmp/mibs/dell:/usr/local/kuetemeier.net/monitoring/snmp/mibs/vmware"
fi

if [ -f /etc/debian_version ] ; then

    #-------------
    # LINUX part (ubuntu)

    alias  LS='ls $LS_OPTIONS'

    export LANG="de_DE.utf8"
    export LC_COLLATE="de_DE.utf8"
    export LC_CTYPE="de_DE.utf8"
    export LC_MESSAGES="de_DE.utf8"
    export LC_MONETARY="de_DE.utf8"
    export LC_NUMERIC="de_DE.utf8"
    export LC_TIME="de_DE.utf8"
    export LC_ALL=

    export JAVA_HOME=/opt/java
    export SCALA_HOME=/opt/scala

else if [ -e /etc/yum.conf ] ; then


    #-------------
    # LINUX part (fedora/centos/rhel)

    alias  LS='ls $LS_OPTIONS'

    export LANG="de_DE.utf8"
    export LC_COLLATE="de_DE.utf8"
    export LC_CTYPE="de_DE.utf8"
    export LC_MESSAGES="de_DE.utf8"
    export LC_MONETARY="de_DE.utf8"
    export LC_NUMERIC="de_DE.utf8"
    export LC_TIME="de_DE.utf8"
    export LC_ALL=

    export JAVA_HOME=/opt/java
    export SCALA_HOME=/opt/scala

else

    #------------
    # Mac part

    alias ls="ls -G"

    export LANG="de_DE.UTF-8"
    export LC_COLLATE="de_DE.UTF-8"
    export LC_CTYPE="de_DE.UTF-8"
    export LC_MESSAGES="de_DE.UTF-8"
    export LC_MONETARY="de_DE.UTF-8"
    export LC_NUMERIC="de_DE.UTF-8"
    export LC_TIME="de_DE.UTF-8"
    export LC_ALL=

    export JAVA_HOME=/Library/Java/Home
    export JAVAFX_HOME=/Library/Java/Home
    export SCALA_HOME=/opt/scala


fi fi

#---------------
# suffix aliase

alias -s txt=vim
alias -s pl=vim
alias -s php=vim

#---------------
# named dirs

hash -d log=/var/log
hash -d doc=/usr/share/doc
#hash -d www=/var/www
hash -d typo3=/var/www/typo3


#---------------
# test section

#setopt MENUCOMPLETE
# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"
#PS1="[$PR_MAGENTA%n$PR_NO_COLOR@$PR_GREEN%U%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
#RPS1="$PR_MAGENTA(%D{%m-%d %H:%M})$PR_NO_COLOR"
#RPS1="(%D{%m-%d %H:%M})$PR_NO_COLOR"

# style definition of completions
zmodload -i zsh/complist
# categories completions with red headings
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# complete special dirs (like ..) with tab
zstyle ':completion:*' special-dirs true

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
#zstyle ':completion:*' menu select=1 _complete _ignored _approximate
#zstyle -e ':completion:*:approximate:*' max-errors \
#    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
#zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:processes' command 'ps -axw'
zstyle ':completion:*:processes-names' command 'ps -awxho command'
# Completion Styles
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# list of completers to use
#zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
#zstyle -e ':completion:*:approximate:*' max-errors \
#    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
#zstyle ':completion:*:expand:*' tag-order all-expansions
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
#zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') 
# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
#zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
##zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
##zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
#zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
#    '*?.old' '*?.pro'
# the same for old style completion
##fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
#zstyle ':completion:*:functions' ignored-patterns '_*'
#zstyle ':completion:*:scp:*' tag-order \
#   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
#zstyle ':completion:*:scp:*' group-order \
#   files all-files users hosts-domain hosts-host hosts-ipaddr
#zstyle ':completion:*:ssh:*' tag-order \
#   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
#zstyle ':completion:*:ssh:*' group-order \
#   hosts-domain hosts-host users hosts-ipaddr
#zstyle '*' single-ignored show


is_root_shell() { [[ $USER == root ]] }


# inspired from 
# http://sebastiancelis.com/2009/11/16/zsh-prompt-git-users/

function update_current_git_vars () {
unset __CURRENT_GIT_BRANCH
unset __CURRENT_GIT_BRANCH_STATUS
unset __CURRENT_GIT_BRANCH_IS_DIRTY

local st="$(git status 2>/dev/null)"
if [[ -n "$st" ]]; then
    local -a arr
    arr=(${(f)st})

    if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
        __CURRENT_GIT_BRANCH='no-branch'
    else
        __CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
    fi

    if [[ $arr[2] =~ 'Your branch is' ]]; then
        if [[ $arr[2] =~ 'ahead' ]]; then
            __CURRENT_GIT_BRANCH_STATUS='ahead'
        elif [[ $arr[2] =~ 'diverged' ]]; then
            __CURRENT_GIT_BRANCH_STATUS='diverged'
        else
            __CURRENT_GIT_BRANCH_STATUS='behind'
        fi
    fi

    if [[ ! $st =~ 'nothing to commit' ]]; then
        __CURRENT_GIT_BRANCH_IS_DIRTY='1'
    fi
fi
}

function prompt_git_info () {
if [ -n "$__CURRENT_GIT_BRANCH" ]; then
    local s="("
    s+="$__CURRENT_GIT_BRANCH"
    case "$__CURRENT_GIT_BRANCH_STATUS" in
        ahead)
        s+="↑"
        ;;
        diverged)
        s+="↕"
        ;;
        behind)
        s+="↓"
        ;;
    esac
    if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
        s+="⚡"
    fi
    s+=")"
 
    printf " %s%s" "%{${fg[cyan]}%}" $s
fi
}

function chpwd_update_git_vars () {
    update_current_git_vars
}

function preexec_update_git_vars () {
  case "$1" in
    git*)
    __EXECUTE_GIT_COMMAND=1
    ;;
    play*)
    __EXECUTE_GIT_COMMAND=1
    ;;
    sbt*)
    __EXECUTE_GIT_COMMAND=1
    ;;
  esac
}

function precmd_update_git_vars () {
  if [ -n "$__EXECUTE_GIT_COMMAND" ]; then
    update_current_git_vars
    unset __EXECUTE_GIT_COMMAND
  fi
}



# Initialize colors.
autoload -U colors
colors

# Allow for functions in the prompt.
setopt PROMPT_SUBST

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

#---------

isroot=`whoami`
if [[ "$isroot" == "root" ]]; then
    export PROMPT=$'%(?..%{\e[41;38m%}%B-%?-%b%{\e[0m%} )%(1j.%{\e[01;33m%}[%j] .)%{\e[01;31m%}%n%{\e[01;33m%}@%{\e[01;36m%}%m%{\e[0m%} %{\e[01;33m%}%2~%{\e[0m%}$(prompt_git_info)%{${fg[default]}%} %B%#%b '
else
    export PROMPT=$'%(?..%{\e[41;38m%}%B-%?-%b%{\e[0m%} )%(1j.%{\e[01;33m%}[%j] .)%{\e[01;32m%}%n%{\e[01;33m%}@%{\e[01;36m%}%m%{\e[0m%} %{\e[01;33m%}%2~%{\e[0m%}$(prompt_git_info)%{${fg[default]}%} %B%#%b '
fi

export PATH="~/.rbenv/bin:$PATH"
export PATH="~/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

#export PATH="/Library/Frameworks/Python.framework/Versions/3.3/bin:$PATH"
#alias python="python3.3"

export PATH="/usr/local/share/npm/bin:$PATH"
