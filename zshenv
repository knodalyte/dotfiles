autoload -Uz compinit
compinit
# skip_global_compinit=1
# XDG defaults {{{
: ${XDG_CONFIG_HOME:="$HOME/.config"}
: ${XDG_CACHE_HOME:="$HOME/.cache"}
: ${XDG_DATA_HOME:="$HOME/.local/share"}
: ${XDG_RUNTIME_DIR:="/tmp/$USER"}
: ${XDG_STATE_HOME:="$HOME/.local/state"}
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_RUNTIME_DIR XDG_STATE_HOME
# [[ ! -d $XDG_RUNTIME_DIR ]] && mkdir -p $XDG_RUNTIME_DIR && chmod 0700 $XDG_RUNTIME_DIR
# }}}
#
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file
export HSTR_CONFIG=hicolor,raw-history-view       # get more colors
export HISTTIMEFORMAT="[%F %T] "
# typeset -TUx PATH path
# path=('/usr/local/bin')
# path+=('/usr/bin')
# path+=('$HOME/.local/bin')
# path+=('$HOME/.cargo/bin')
# path+=('/usr/local/go/bin')
# path+=('$HOME/go/bin')
# path+=($path[@])
# export PATH
export NO_AT_BRIDGE=1
export TERMCMD="kitty"
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# Now fzf (w/o pipe) will use fd instead of find
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 90%'

export VISUAL="glrnvim --nofork"
# export VISUAL=nvim-qt
export EDITOR=nvim
export DE=lxqt
export PAGER=ov
# export PAGER=less                           # Set default pager
# -I = case insensitive search
# -R = display raw characters (git diff colored output, etc.)
# -F = don't use pager if only one screen worth of content (no unnecessary 'q')
# -X = no need to clear screen when less invoked
# -W = temporarily highlights the first new line after
#      any forward movement command larger than one line.
export LESS='-R -F -W -X -I'
export LANG="en_US.UTF-8"                   # I'm not sure who looks at this, but I know it's good to set in general
export LC_ALL="en_US.UTF-8"
# export MOST_SWITCHES="-s, -w"

if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else 
    export BROWSER=links
fi

# export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket"
# export NVIM_LISTEN_ADDRESS=/home/cba/nvimsocket
# export NVR_CMD="nvim --listen $NVIM_LISTEN_ADDRESS"
# export NVR_CMD="nvim --listen /tmp/nvimsocket"
# export NVR_CMD="nvim-qt"
# export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
# export NVIM_LISTEN_ADDRESS=/home/cba/nvimsocket
# export NVIM_LISTEN_ADDRESS="localhost:11111"

export FUZZY_FS_TERMINAL_COMMAND="alacritty"

export DOTBARE_DIR="$HOME/.dotfiles.git"
export XCOMPOSEFILE=/tmp/compose

export PERL5LIB="/home/cba/.cpan/build:$PERL5LIB"
# Uncomment following line if you want red dots to be displayed while waiting for completion
export COMPLETION_WAITING_DOTS="true"
export ZPFX="~/.zinit/polaris"
# export ZPFX="~/.zplugin/polaris"

# Base PATH
PATH="$PATH:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin"


# Conditional PATH additions
for path_candidate in /opt/local/sbin \
  /opt/local/bin \
  /usr/local/share/npm/bin \
  ~/.cabal/bin \
  ~/.cargo/bin \
  ~/.rbenv/bin \
  ~/bin \
  ~/go/bin \
  /usr/lib/cargo/bin \
  ~/src/gocode/bin \
  ~/.local/bin
do 
  if [ -d ${path_candidate} ]; then
    export PATH="${PATH}:${path_candidate}"
  fi
done

export CDPATH="."
# Conditional CDPATH additions
# for path_candidate in ~/sync \
#   ~/projects \
#   /etc
# do
#   if [ -d ${path_candidate} ]; then
#     export CDPATH="${CDPATH}:${path_candidate}"
#   fi
# done

# export RIPGREP_CONFIG_PATH='~/.config/ripgrep/.ripgreprc'
export LOCATE_PATH='/var/lib/plocate/plocate.db'
if [ -e /home/cba/.nix-profile/etc/profile.d/nix.sh ]; then . /home/cba/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"


# ==========================
# nnn configuration
# jarun/nnn: n³ The unorthodox terminal file manager. https://github.com/jarun/nnn
# ==========================

# context specific colors
# export NNN_COLORS="#4cd00403"
# Each context (aka tab) has different color: green, yellow, blue, purple
export NNN_COLORS="#02030405"

# export NNN_FCOLORS='c1e2272e006033f7c6d6abc4' # defaults
# directories are bright yellow
# executables are green (02, 76)
# symolik links are purple (05)
export NNN_FCOLORS='c1e20b02006005f7c6d6abc4'

# 'nnn' command line options
# -Q, disable confirmation on quit with multiple contexts active
# -r, show cp, mv progress
# -u, use selection if available, don't prompt to choose between selection and hovered entry
# -U, show user and group names in status bar
# -o,  open files only on Enter key
# -x, copy path to system clipboard on select
# -E, use $EDITOR for internal undetached edits
# -e, open text files in $VISUAL (else $EDITOR, fallback vi) [preferably CLI]
# -S, persistent session
export NNN_OPTS="QruUoxES"

# Use "rifle" (ranger's file opener) program to open files
export NNN_OPENER='/home/cba/.config/nnn/plugins/nuke'
# export NNN_OPENER=rifle

# temp fifo file that keeps currently highlighted file, needed for previews
# BTW, $NNN variable in a subshell refers to currently highlighted file
export NNN_FIFO='/tmp/nnn.fifo'

# plugins key map
# export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview'
export NNN_PLUG="/:finder;c:fzcd;j:autojump;d:dragdrop;f:fzopen;g:fzplug;k:kdeconnect;m:mimelist;n:nuke;o:openall;p:preview-tabbed r:renamer;s:suedit;t:togglex;C:fzcd_from_home;b:bookmarks;P:-_less -iR $nnn*"
# List of supported archives in 'nnn'
# default: bzip2, (g)zip, tar. Other formats are supported through 'atool'
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"

# Special shortcut reference to the config file that contains selection
# Use this to refer selected files when entering shell(!) or command prompt (])
export NSEL=${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.selection

# Specify directory with symlinks per each bookmark
export BOOKMARKS_DIR="$HOME/.bookmarks"

#mumbo jumbo to make qute-bitwarden work
keyctl link @u @s

export GITHUB_USERNAME="knodalyte"
