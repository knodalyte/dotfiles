#!/bin/env sh
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

PATH="/usr/local/bin:/usr/bin"
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
PATH=$PATH:$HOME/.cargo/bin
PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
# echo "$PATH"

export TERMCMD="kitty"
export PATH

XDG_CONFIG_HOME="$HOME/.config"

# source /usr/share/autojump/autojump.bash

# fix bogus error message in logs about gtk-critical issues
export NO_AT_BRIDGE=1
# unalias z 2> /dev/null
# eval "$(lua ~/.local/bin/z.lua --init bash enhanced once echo fzf)"
# source ~/projects/czmod/czmod.bash
# export RANGER_ZLUA="~/.local/bin/z.lua"
# if [ -e /home/cba/.nix-profile/etc/profile.d/nix.sh ]; then . /home/cba/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"
