# ~/.bashrc: executed by bash(1) for non-login shells
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# /usr/bin/autorandr --change --default default

# If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#       *) return;;
# esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
# case ${TERM} in
#      alacritty)
#         PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"' ;;
# esac
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte-2.91.sh
fi
# export PATH="${PATH}:~/local/bin"
export PATH=$PATH:$HOME/.cargo/bin
set -o vi

export VISUAL=nvim-qt
export EDITOR=nvim
export DE="gnome"
export PAGER=less

# export MOST_SWITCHES="-s, -w"

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else 
    export BROWSER=links
fi

# kitty stuff
source <(kitty + complete setup bash)
# make terminals ignore ctrl-s
stty -ixon
# [[ $- == *i* ]] && stty -ixon
# ranger stuff
export TERMCMD=kitty

source /home/cba/.config/broot/launcher/bash/br

export XDG_CONFIG_HOME="$HOME/.config"
# eval $(thefuck --alias)
# [[ $- = *i* ]] && source ~/liquidprompt/liquidprompt

# # Only load liquidprompt in interactive shells, not from a script or from scp
# echo $- | grep -q i 2>/dev/null && . /usr/share/liquidprompt/liquidprompt
# fix error with starting applets
export NO_AT_BRIDGE=1

alias hc='herbstclient'
source /home/cba/Downloads/herbstclient-completion

# set default shell without editing /etc/shells
# if [ "${XONSH_VERSION:-unset}" = "unset" ] ; then
#     export SHELL=$HOME/.local/bin/xonsh
#     exec $HOME/.local/bin/xonsh -l
# fi

whatinstalled () { local cmdpath=$(realpath -eP $(which -a $1 | grep -E "^/" | tail -n 1) 2>/dev/null) && [ -x "$cmdpath" ] && dpkg -S $cmdpath 2>/dev/null | grep -E ": $cmdpath\$" | cut -d ":" -f 1; }

alias fd=fdfind
export FZF_DEFAULT_COMMAND="fd --type f --color=never"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d . --color=never"

#I like a top-down 75% fzf window that enables multi-selection and also responds to control-f/control-b keys.
export FZF_DEFAULT_OPTS="
  --height 75% --multi --reverse
  --bind ctrl-f:page-down,ctrl-b:page-up
"

export ARDUINO_PATH="/usr/share/arduino"

# PATH="/home/cba/perl5/bin${PATH:+:${PATH}}"; export PATH;
export PATH="$PATH:$PATH/perl5/bin"
PERL5LIB="/home/cba/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/cba/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/cba/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/cba/perl5"; export PERL_MM_OPT;

# alias skim="sk --ansi -i -c \"(rg --files | rg -S \"{}\" & rg -S -l \"{}\" & echo {}.txt) | sort | uniq\" --bind 'ctrl-x:execute(vim {})+abort,enter:execute(vim {})+abort' --preview \"preview.sh {}\" --preview-window down:wrap"

# source /usr/share/autojump/autojump.bash
# eval "$(fasd --init auto)"

export NVR_CMD="nvim-qt"
export NVIM_LISTEN_ADDRESS="localhost:12345"
# unalias z 2> /dev/null
# FZ_HISTORY_CD_CMD="_zlua"
# source /path/to/fz.sh
# if [ -d ~/.bash_completion.d ]; then
#   for file in ~/.bash_completion.d/*; do
#     . $file
#   done
# fi
# eval "$(lua ~/.local/bin/z.lua --init bash enhanced once echo fzf)"
# source ~/projects/czmod/czmod.bash
# export RANGER_ZLUA="/home/cba/.local/bin/z.lua"
# export RANGER_LUA="/home/cba/.local/bin/z.lua"

# shellcheck shell=sh

# Compatible with ranger 1.4.2 through 1.9.*
#
# Automatically change the current working directory after closing ranger
#
# This is a shell function to automatically change the current working
# directory to the last visited one after ranger quits. Either put it into your
# .zshrc/.bashrc/etc or source this file from your shell configuration.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.

# ranger_cd() {
#     temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
#     ranger --choosedir="$temp_file" -- "${@:-$PWD}"
#     if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
#         cd -- "$chosen_dir"
#     fi
#     rm -f -- "$temp_file"
# }

# # This binds Ctrl-O to ranger-cd:
# bind '"\C-o":"ranger-cd\C-m"'

alias arr="/usr/bin/autorandr --change --default default"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# if [ -n "$DESKTOP_SESSION" ];then
#     eval $(gnome-keyring-daemon --start)
#     export SSH_AUTH_SOCK
# fi

# ctrl-G to invoke navi cheatsheets
# source <(echo "$(navi widget bash)")

# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# # ensure synchronization between bash memory and history file
# export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
export HISTIGNORE="ls:ps:history"
# Store multi-line commands in one history entry:
shopt -s cmdhist
# # if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\e^ihstr -- \n"'; fi
# # if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\e^ihstr -k \C-j"'; fi

# . /usr/share/autojump/autojump.sh
# eval "$(zoxide init bash)"

# deep fuzzy cd
function dcd {
    br --only-folders --cmd "$1 :cd"
}
. "$HOME/.cargo/env"
alias fuz='/home/cba/projects/fuz/fuz --path "/home/cba/sync/pkb"'
alias fuz='/home/cba/projects/fuz/fuz --path ""'
alias fz='fuz --sorttime'
alias fze='fuz --edit'
