# we can use the command zprof to show a very rich output on Zsh startup loading
# zmodload zsh/zprof

load-our-ssh-keys() {
  # Fun with SSH
  if [ $(ssh-add -l | grep -c "The agent has no identities." ) -eq 1 ]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
      # macOS allows us to store ssh key pass phrases in the keychain, so try
      # to load ssh keys using pass phrases stored in the macOS keychain.
      #
      # You can use ssh-add -K /path/to/key to store pass phrases into
      # the macOS keychain
      ssh-add -A # load all ssh keys that have pass phrases stored in macOS keychain
    fi

    for key in $(find ~/.ssh -type f -a \( -name '*id_rsa' -o -name '*id_dsa' -name '*id_ecdsa' \))
    do
      if [ -f ${key} -a $(ssh-add -l | grep -c "${key//$HOME\//}" ) -eq 0 ]; then
        ssh-add ${key}
      fi
    done
  fi
}

# load-our-ssh-keys

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit promptinit
compinit
promptinit

#
# zinit has a wide range of options for optimizing performance. If you notice the plugin impacting the performance of new terminals, and if you don't need the plugin to be available the moment you're able to type at a prompt, a good place to start is

# zinit ice wait lucid
# zinit light <owner>/<repo>

# That will silently delay loading the plugin until after the shell has started up.
# echo "line 22"
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
### End of Zinit's installer chunk

##########################
# OMZ Libs and Plugins   #
##########################

# IMPORTANT:
# Ohmyzsh plugins and libs are loaded first as some these sets some defaults which are required later on.
# Otherwise something will look messed up
# ie. some settings help zsh-autosuggestions to clear after tab completion

setopt promptsubst

# Explanation:
# - History plugin is loaded early (as it has some defaults) to prevent empty history stack for other plugins
# zinit wait lucid for \
# 	OMZL::clipboard.zsh \
# 	OMZL::compfix.zsh \
# 	OMZL::directories.zsh \
# 	OMZL::git.zsh \
# 	OMZL::grep.zsh \
# 	OMZL::key-bindings.zsh \
# 	OMZL::spectrum.zsh \
# 	OMZL::termsupport.zsh \
#     atload"
#         alias gcd='gco dev'
#     " \
# 	OMZP::git \
# 	OMZP::fzf \
    # atload"
        # alias dcupb='docker-compose up --build'
    # " \
	# OMZP::docker-compose \
	# OMZP::ripgrep \
	# as"completion" \
    # OMZP::docker/_docker \
	# OMZP::fd \
    # hlissner/zsh-autopair \
    # chriskempson/base16-shell \
	# OMZL::completion.zsh \
	# OMZL::correction.zsh \
    # atload"
    #     alias ..='cd ..'
    #     alias ...='cd ../..'
    #     alias ....='cd ../../..'
    #     alias .....='cd ../../../..'
    # " \

# omz_libraries=(
#     # prompt_info_functions.zsh
#     # key-bindings.zsh
#     history.zsh
#     # completion.zsh
# )
# for library in ${omz_libraries[@]}; do
#     zinit snippet OMZL::$library
#     done

# omz_plugins=(
# 	debian
#     # fd
#     systemd
#     colorize
#     command-not-found
#     # emacs
#     sudo
#     colored-man-pages
#     # git
#     github
#     python
#     pip
#     # ripgrep
#     rsync
#     sudo
#     # vi-mode
#     # per-directory-history
#     # z
# )
# for plugin in ${omz_plugins[@]}; do
#     zinit snippet OMZ::plugins/$plugin/$plugin.plugin.zsh
#     zinit snippet OMZP::$plugin
#     done

#####################
# PLUGINS           #
#####################
# @source: https://github.com/crivotz/dot_files/blob/master/linux/zplugin/zshrc

# IMPORTANT:
# These plugins should be loaded after ohmyzsh plugins

# more shortcuts for z

zinit wait lucid for \
    light-mode atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20" atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    light-mode atinit"
        typeset -gA FAST_HIGHLIGHT;
        FAST_HIGHLIGHT[git-cmsg-len]=100;
        zpcompinit;
        zpcdreplay;
    " \
        zdharma/fast-syntax-highlighting \
    light-mode blockf atpull'zinit creinstall -q .' \
    atinit"
        zstyle ':completion:*' completer _expand _complete _ignored _approximate
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        zstyle ':completion:*' menu select=2
        zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
        zstyle ':completion:*:descriptions' format '-- %d --'
        zstyle ':completion:*:processes' command 'ps -au$USER'
        zstyle ':completion:complete:*:options' sort false
        zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm,cmd -w -w'
        zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
        zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'
    " \
        zsh-users/zsh-completions #\
    # bindmap"^R -> ^H" atinit"
    #     zstyle :history-search-multi-word page-size 10
    #     zstyle :history-search-multi-word highlight-color fg=red,bold
    #     zstyle :plugin:history-search-multi-word reset-prompt-protect 1
    # " \
    #     zdharma/history-search-multi-word \
    # reset \
    # atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
    #         \${P}sed -i \
    #         '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
    #         \${P}dircolors -b LS_COLORS > c.zsh" \
    # atpull'%atclone' pick"c.zsh" nocompile'!' \
    # atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
    #     trapd00r/LS_COLORS
    #
# load to use https://github.com/NICHOLAS85/z-a-linkbin ice mods to symlink executablesO
# zinit light NICHOLAS85/z-a-linkbin

# echo "line 277"
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit light-mode for \
#     zinit-zsh/z-a-rust \
#     zinit-zsh/z-a-as-monitor \
#     zinit-zsh/z-a-patch-dl \
#     zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
#
# source ~/.p10k.zsh
# source $ZDOTDIR/.zinit-local-plugins

# zinit light zinit-zsh/z-a-man

zinit light zdharma/zui
zinit light zdharma/zplugin-crasis

CRASIS_THEME="zdharma-256" CRASIS_LAYOUT="contract" 
#
# fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting.
# https://github.com/Aloxaf/fzf-tab - great plugin!
zinit light Aloxaf/fzf-tab

# Utilize Turbo and initialize the completion system
zinit wait pack atload=+"zicompinit; zicdreplay" for system-completions
#
# zinit light zinit-zsh/z-a-readurl
zinit wait lucid for zinit-zsh/zinit-console
# zinit for annexes zsh-users+fast zdharma
# Fast-syntax-highlighting & autosuggestions
# zinit wait lucid for \
#  atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
#     zdharma/fast-syntax-highlighting \
#  atload"!_zsh_autosuggest_start" \
#     zsh-users/zsh-autosuggestions \
#  blockf \
#     zsh-users/zsh-completions

# Option B – a load with Turbo-Mode being in use
# zplugin ice wait'0' lucid atload'zsh-startify'
# zplugin load zdharma/zsh-startify


# zinit ice wait'!0' 
# zinit light denysdovhan/spaceship-prompt
# zinit load reobin/typewritten

# prompt typewritten

# zinit ice wait'!0' 
# zinit load halfo/lambda-mod-zsh-theme
# zinit wait lucid for \
#         OMZL::git.zsh \
#   atload"unalias grv" \
#         OMZP::git
# zinit wait'!' lucid for \
#     OMZL::prompt_info_functions.zsh \
#     OMZT::gnzh
#
# Two regular plugins loaded without investigating.
# Fish-like auto suggestions
# zinit light zsh-users/zsh-autosuggestions
# zinit light zdharma/fast-syntax-highlighting

# Plugin history-search-multi-word loaded with investigating.
# zinit load zdharma/history-search-multi-word
# not needed due to fzf-tab handling search
# zinit load zsh-users/zsh-history-substring-search


# Extra zsh completions
# zinit light zsh-users/zsh-completions

# Optional: compile source files into bytecode to speed up init
# zinit ice pick'spacezsh.zsh' \
#   compile'{presets/^(*.zwc),lib/**/^(*.zwc),sections/^(*.zwc)}'
# zinit light laggardkernel/spacezsh-prompt
# zinit light rkoder/clarity.zsh

# ZSH_THEME="lighthaus.zsh-theme"
# zinit load agkozak/zsh-z
# . ~/.oh-my-zsh/plugins/z/z.sh

# Tab complete rakefile targets.
# zinit light unixorn/rake-completion.zshplugin

# Automatically run zgen update and zgen selfupdate every 7 days.
# zinit light unixorn/autoupdate-zgen

# Add my collection of miscellaneous utility functions.
# zinit light unixorn/jpb.zshplugin

# Colorize the things if you have grc installed. Well, some of the
# things, anyway.
# zinit light unixorn/warhol.plugin.zsh

# Warn you when you run a command that you've set an alias for without
# using the alias.
# redundant with plugin below that works with abbrev-alias plugin
# zinit light djui/alias-tips

# Add my collection of git helper scripts.
# zinit light unixorn/git-extra-commands

# Supercharge your history search with fzf
# zinit light unixorn/fzf-zsh-plugin

# Add my bitbucket git helpers plugin.
# zinit light unixorn/bitbucket-git-helpers.plugin.zsh

# A collection of scripts that might be useful to sysadmins.
# zinit light skx/sysadmin-util

# Adds aliases to open your current repo & branch on github.
# zinit light peterhurford/git-it-on.zsh

# Tom Limoncelli's tooling for storing private information (keys, etc)
# in a repository securely by encrypting them with gnupg.
# zinit light StackExchange/blackbox

# A set of shell functions to make it easy to install small apps and
# utilities distributed with pip.
zinit light sharat87/pip-app

zinit light chrissicool/zsh-256color

# Load more completion files for zsh from the zsh-lovers github repo.
# zinit light zsh-users/zsh-completions

# Docker completion
# zinit light srijanshetty/docker-zsh

# Very cool plugin that generates zsh completion functions for commands
# if they have getopt-style help text. It doesn't generate them on the fly,
# you'll have to explicitly generate a completion, but it's still quite cool.
zinit light RobSis/zsh-completion-generator

# Add Fish-like autosuggestions to your ZSH.
# zinit light zsh-users/zsh-autosuggestions

# k is a zsh script / plugin to make directory listings more readable,
# adding a bit of color and some git status information on files and
# directories.
zinit light supercrabtree/k

# find files in subtree:
# zinit ice as"command" from"gh-r" pick"fuzzy-fs"
# zinit ice as"program" pick"fuzzy-fs"
# zinit light "SleepyBag/fuzzy-fs"
# source /home/cba/.zinit/plugins/SleepyBag---fuzzy-fs/fuzzy-fs
zinit light 'wfxr/forgit'
zinit light 'kazhala/dotbare'
zinit light 'cal2195/q'
# zinit light "SleepyBag/zle-fzf"
# can't handle single quotes, parens, etc:
# zinit light 'jameshgrn/zshnotes'
zinit light 'aperezdc/zsh-notes'
# Ctrl-N: Open the notes selector.
bindkey '^[n' notes-edit-widget
# If unset, ~/Notes is used as default.
zstyle :notes home  'sync/pkb/inbox'

# When set, exits the notes widget after one use.
zstyle :notes:widget once no

# Choose the picker used by the widget. Supported values: fzf, skim, fzy.
zstyle :notes:widget picker fzf

# When using fzf or skim it's possible to show a side panel with a preview of the notes. The cat command is used by default, but any program that can render Markdown to ANSI terminal escapes should do (for example mdcat and lowdown are known to work well):

# Enable preview panel. Disabled by default.
zstyle :notes:widget:preview enabled yes

# The default is "cat", but can be any command that renders to ANSI escapes:
# zstyle :notes:widget:preview command lowdown -Tterm

# Alternative using mdcat:
zstyle :notes:widget:preview command mdcat -l
zle && { zle reset-prompt; zle -R }
# https://github.com/olets/zsh-abbr
zinit light 'MichaelAquilina/zsh-you-should-use'
zinit light "momo-lab/zsh-abbrev-alias"
# zinit light 'olets/zsh-abbr'
# "note sometext" notes go into /home/cba/Documents/zshnote
# zinit ice lucid wait"1" pick"fz.sh"
# zinit load halfo/lambda-mod-zsh-theme
# zinit load 'changyuheng/fz'
# zinit wait'1' lucid light-mode for pick"z.sh" "knu/z" 
# zinit light "rupa/z"
# zinit load "knu/z" 

# Add to .zshrc, before this plugin is loaded:
# Use Control-D instead of Escape to switch to NORMAL mode
# VIM_MODE_VICMD_KEY='^D'
# https://github.com/softmoth/zsh-vim-mode
zinit load 'softmoth/zsh-vim-mode'
# cursor configurations for zsh-vim-mode
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_VIINS="#20d08a blinking bar"
MODE_CURSOR_SEARCH="#ff00ff blinking underline"
###
#
# mode configuration for zsh-vim-mode, shown on the right (RPS1 stuff)
# MODE_INDICATOR_VIINS='%F{15}<%F{8}INSERT<%f'
# MODE_INDICATOR_VICMD='%F{10}<%F{2}NORMAL<%f'
# MODE_INDICATOR_REPLACE='%F{9}<%F{1}REPLACE<%f'
# MODE_INDICATOR_SEARCH='%F{13}<%F{5}SEARCH<%f'
# MODE_INDICATOR_VISUAL='%F{12}<%F{4}VISUAL<%f'
# MODE_INDICATOR_VLINE='%F{12}<%F{4}V-LINE<%f'

# Make it work with your existing RPS1 if it is set. Note the single quotes
# setopt PROMPT_SUBST
# RPS1='${MODE_INDICATOR_PROMPT} ${vcs_info_msg_0_}'
#bindkey -rpM viins '^[^['
zinit ice depth=1; zinit light romkatv/powerlevel10k

# zsh-startify, a vim-startify like plugin
# zinit wait"0b" lucid atload"zsh-startify" for zdharma/zsh-startify

# A simple zsh plugin that replaces Ctrl+R with an fzf-driven that includes date/times. 
# maybe redundant with hstr?
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

# set terminal window title with pwd and command name - uses history so new term windows have prior command...
zinit light mdarocha/zsh-windows-title

# zsh fuzzy marks - create lists of favorite files and directories and insert into commandline using fzf: ^o
# needs fzf key bindings else shows error (but works)
zinit light pabloariasal/zfm

### end of zinit loading and setup #######################################################
#
# Correct spelling for commands
setopt correct

# turn off the infernal correctall for filenames
unsetopt correctall
#
# Yes, these are a pain to customize. Fortunately, Geoff Greer made an online
# tool that makes it easy to customize your color scheme and keep them in sync
# across Linux and OS X/*BSD at http://geoff.greer.fm/lscolors/

export LSCOLORS='Exfxcxdxbxegedabagacad'
export LS_COLORS='di=1;34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'


# +------------+
# | NAVIGATION |
# +------------+

setopt AUTO_CD  # If a command is issued that can’t be executed as a normal command,
                # and the command is the name of a directory, perform the cd command
                # to that directory.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.

# autoload -Uz bd; bd

# bindkey '^[OA' history-substring-search-up
# bindkey '^[OB' history-substring-search-down
# +---------+
# | HISTORY |
# +---------+


# set some history options
setopt append_history
setopt hist_reduce_blanks
setopt INC_APPEND_HISTORY
unsetopt HIST_BEEP

#setopt noclobber

# Keep a ton of history. You can reset these without editing .zshrc by
# adding a file to ~/.zshrc.d.
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
#setopt pushd_silent

# Add some completions settings
setopt ALWAYS_TO_END     # Move cursor to the end of a completed word.
setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
setopt AUTO_MENU         # Show completion menu on a successive tab press.
setopt AUTO_PARAM_SLASH  # If completed parameter is a directory, add a trailing slash.
setopt COMPLETE_IN_WORD  # Complete from both ends of a word.
unsetopt MENU_COMPLETE   # Do not autoselect the first completion entry.

# Miscellaneous settings
setopt INTERACTIVE_COMMENTS  # Enable comments in interactive shell.

setopt extended_glob # Enable more powerful glob features
#
# Completion
# Speed up autocomplete, force prefix mapping
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

setopt menu_complete # Autoselect the first suggestion
setopt complete_in_word
setopt no_complete_aliases # Actually: completes aliases! (I guess that means "no ~separate functions~ for aliases")
unsetopt always_to_end
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' expand "yes"
zstyle ':completion:*' matcher-list "m:{a-zA-Z}={A-Za-z}" # ignore case
zstyle ':completion:*' list-colors ""
zstyle ':completion:*' menu select=2 _complete _ignored _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:prefix:*' add-space true
zstyle ':completion:*:descriptions' format "|| %{${fg[yellow]}%}%d%{${reset_color}%}"
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:*:*:processes' list-colors "=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01"
zstyle ':completion:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
# zstyle ':completion:*:*:*:*:hosts' list-colors "=*=$color[cyan];$color[bg-black]"
zstyle ':completion:*:functions' ignored-patterns "_*"
# zstyle ':completion:*:original' list-colors "=*=$color[red];$color[bold]"
# zstyle ':completion:*:parameters' list-colors "=[^a-zA-Z]*=$color[red]"
# zstyle ':completion:*:aliases' list-colors "=*=$color[green]"

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# Expand aliases inline - see http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
# globalias() {
#    if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
#      zle _expand_alias
#      zle expand-word
#    fi
#    zle self-insert
# }

# zle -N globalias

# bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches

# Customize to your needs...
# Stuff that works on bash or zsh
if [ -r ~/.sh_aliases ]; then
  source ~/.sh_aliases
fi

# Stuff only tested on zsh, or explicitly zsh-specific
if [ -r $ZDOTDIR/.zsh_aliases ]; then
  source $ZDOTDIR/.zsh_aliases
fi

# if [ -r ~/.zsh_functions ]; then
#   source ~/.zsh_functions
# fi

export LOCATE_PATH=/var/db/locate.database

# Load AWS credentials
if [ -f ~/.aws/aws_variables ]; then
  source ~/.aws/aws_variables
fi

# JAVA setup - needed for iam-* tools
if [ -d /Library/Java/Home ];then
  export JAVA_HOME=/Library/Java/Home
fi

# # deal with screen, if we're using it - courtesy MacOSXHints.com
# # Login greeting ------------------
# if [ "$TERM" = "screen" -a ! "$SHOWED_SCREEN_MESSAGE" = "true" ]; then
#   detached_screens=$(screen -list | grep Detached)
#   if [ ! -z "$detached_screens" ]; then
#     echo "+---------------------------------------+"
#     echo "| Detached screens are available:       |"
#     echo "$detached_screens"
#     echo "+---------------------------------------+"
#   fi
# fi

# if [ -f /usr/local/etc/grc.bashrc ]; then
#   source "$(brew --prefix)/etc/grc.bashrc"

#   function ping5(){
#     grc --color=auto ping -c 5 "$@"
#   }
# else
#   alias ping5='ping -c 5'
# fi

# Honor old .zshrc.local customizations, but print deprecation warning.
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
  echo '~/.zshrc.local is deprecated - use files in ~/.zshrc.d instead.'
  echo 'Future versions of zsh-quickstart-kits will no longer load ~/.zshrc.local'
fi

# Load zmv
if [[ ! -f ~/.zsh-quickstart-no-zmv ]]; then
  autoload -U zmv
fi

# Make it easy to append your own customizations that override the above by
# loading all files from the ~/.zshrc.d directory
# mkdir -p ~/.zshrc.d
# if [ -n "$(/bin/ls ~/.zshrc.d)" ]; then
#   for dotfile in ~/.zshrc.d/*
#   do
#     if [ -r "${dotfile}" ]; then
#       source "${dotfile}"
#     fi
#   done
# fi

# remove dupes from $PATH using a zsh builtin
# https://til.hashrocket.com/posts/7evpdebn7g-remove-duplicates-in-zsh-path
typeset -aU path;

# If desk is installed, load the Hook for desk activation
[[ -n "$DESK_ENV" ]] && source "$DESK_ENV"

# echo "line 243"
# Fix bracketed paste issue
# Closes #73
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)


# if [[ -z "$DONT_PRINT_SSH_KEY_LIST" ]]; then
#   echo
#   echo "Current SSH Keys:"
#   ssh-add -l
#   echo
# fi
# echo "line 263"

alias mm=moreman

# echo "line 299"
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
# export KEYTIMEOUT=1
# this value can not be too low, or it will break the surround object of
# plugin zsh-vim-mode, see https://github.com/zsh-users/zsh-autosuggestions/issues/254
export KEYTIMEOUT=30
# export MANPATH="/usr/local/man:$MANPATH"
# cursor_mode() {
#     # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
#     cursor_block='\e[2 q'
#     cursor_beam='\e[6 q'

#     function zle-keymap-select {
#         if [[ ${KEYMAP} == vicmd ]] ||
#             [[ $1 = 'block' ]]; then
#             echo -ne $cursor_block
#         elif [[ ${KEYMAP} == main ]] ||
#             [[ ${KEYMAP} == viins ]] ||
#             [[ ${KEYMAP} = '' ]] ||
#             [[ $1 = 'beam' ]]; then
#             echo -ne $cursor_beam
#         fi
#     }

#     zle-line-init() {
#         echo -ne $cursor_beam
#     }

#     zle -N zle-keymap-select
#     zle -N zle-line-init
# }

# cursor_mode

alias pkb="cd ~/sync/pkb/"
alias fd="fdfind --hidden"
alias fdd="fdfind --hidden -t d"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# echo "line 366"
# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)
# echo "line 373"
eval "$(zoxide init --cmd j --hook prompt zsh)"
# bindkey -s "\C-r" "\C-a hh -- \C-j"
# eval "$(zoxide init --no-aliases zsh)"
# eval "$(zoxide init zsh --hook prompt --no-aliases)"
# echo "line 375"

eval $(thefuck --alias)
source /home/cba/.config/broot/launcher/bash/br
# echo "line 378"

ZPLUG_SUDO_PASSWORD=
ZPLUG_PROTOCOL=ssh

# echo "line 383"
# autoload -U compinit && compinit
# _dotbare_completion_cmd

# echo "line 382"
# source $HOME/projects/fuzzy-fs/fuzzy-fs
alias skv="sk --ansi -i -c 'rg --color=always --line-number \"{}\"' --preview '``preview.sh {}' -d':' --bind 'enter:execute($EDITOR +{2} {1})+abort'"
alias skl="sk --ansi -i -c 'rg --color=always -l --count --hidden \"{}\"' --preview '``preview.sh {}' -d':' --bind 'enter:execute($EDITOR +{2} {1})+abort'"
# alias fzv="rg --color=always --line-number \"{}\"|fzf --preview '``preview.sh {}' -d':' --bind 'enter:execute($EDITOR +{2} {1})+abort'"
alias la='command ls -la'
alias ll='command ls -l'
alias lh='command ls -hAl'
alias l='command ls -l'
alias acs='apt-cache search'
alias acsh='apt-cache show'
alias sudo adg="apt-get dist-upgrade"
alias sudo ag="apt-get upgrade"
alias sudo agi="apt-get install"
alias sudo au="apt-get update"


autoload bashcompinit
bashcompinit
# source ~/.local/bin/gh_complete.sh
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
# (( ! ${+functions[p10k]} )) || p10k finalize
#
# Load any custom zsh completions we've installed
if [ -d ~/.zsh-completions ]; then
  for completion in ~/.zsh-completions/*
  do
    source "$completion"
  done
fi
# echo "line 414"

setopt prompt_subst
setopt promptsubst
autoload -U promptinit; promptinit
# Set keystrokes for substring searching
zmodload zsh/terminfo
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
# Load me last
GENCOMPL_FPATH=$HOME/.zsh/complete

abbrev-alias zzz='exit'
abbrev-alias ka='k -all '
abbrev-alias aba='abbrev-alias '

### vim mode in zsh
bindkey -v
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

alias ls='exa'                                                          # ls
alias l='exa -lbF --git'                                                # list, size, type, git
alias ll='exa -lbGF --git'                                             # long list
alias llm='exa -lbGd --git --sort=modified'                            # long list, modified date sort
alias la='exa -lbhHigUmuSa --time-style=long-iso --git --color-scale'  # all list
alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list

# specialty views
alias lS='exa -1'                                                              # one column, just names
alias lt='exa --tree --level=2'                                         # tree
aba k='k --all'
aba j='zfm'
aba ja='zfm add'
aba jl='zfm list'
aba js='zfm select' #Open selection menu and print selection to stdout
aba jq='zfm query ' #<pattern> 	Print bookmark matching pattern to stdout. Selection menu will open if match is ambiguous
# f <pattern> 	Jump to bookmark directory matching pattern, open selection if ambiguous

# Append this line to ~/.zshrc to enable fzf keybindings for Zsh:
source /usr/share/doc/fzf/examples/key-bindings.zsh
# Append this line to ~/.zshrc to enable fuzzy auto-completion for Zsh:
# source /usr/share/doc/fzf/examples/completion.zsh

