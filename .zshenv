typeset -U PATH path
path=("/usr/local/bin" "/usr/bin" "$HOME/.local/bin" "$HOME/.cargo/bin" "/usr/local/go/bin" "$HOME/go/bin" "$path[@]")
export PATH
export NO_AT_BRIDGE=1
export TERMCMD="kitty"
export XDG_CONFIG_HOME="$HOME/.config"
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# Now fzf (w/o pipe) will use fd instead of find
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

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
export NVR_CMD="nvim-qt"
# export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export NVIM_LISTEN_ADDRESS="localhost:12345"

export FUZZY_FS_TERMINAL_COMMAND="kitty"
