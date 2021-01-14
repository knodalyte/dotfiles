# XDG defaults {{{
: ${XDG_CONFIG_HOME:="$HOME/.config"}
: ${XDG_CACHE_HOME:="$HOME/.cache"}
: ${XDG_DATA_HOME:="$HOME/.local/share"}
: ${XDG_RUNTIME_DIR:="/tmp/$USER"}
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_RUNTIME_DIR
[[ ! -d $XDG_RUNTIME_DIR ]] && mkdir -p $XDG_RUNTIME_DIR && chmod 0700 $XDG_RUNTIME_DIR
# }}}
#
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file
export HSTR_CONFIG=hicolor       # get more colors
typeset -U PATH path
path=("/usr/local/bin" "/usr/bin" "$HOME/.local/bin" "$HOME/.cargo/bin" "/usr/local/go/bin" "$HOME/go/bin" "$path[@]")
export PATH
export NO_AT_BRIDGE=1
export TERMCMD="kitty"
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# Now fzf (w/o pipe) will use fd instead of find
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export VISUAL=nvim-qt
export EDITOR=nvim
export DE="gnome"
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
export NVR_CMD="nvim-qt"
# export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
# export NVIM_LISTEN_ADDRESS=/home/cba/nvimsocket
export NVIM_LISTEN_ADDRESS="localhost:12345"

export FUZZY_FS_TERMINAL_COMMAND="kitty"

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
  /usr/lib/cargo/bin \
  ~/src/gocode/bin
do
  if [ -d ${path_candidate} ]; then
    export PATH="${PATH}:${path_candidate}"
  fi
done

export RIPGREP_CONFIG_PATH='~/.config/ripgrep/.ripgreprc'
