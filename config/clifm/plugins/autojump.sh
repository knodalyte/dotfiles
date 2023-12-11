#!/bin/sh

# Description: Jump to visited directories using external directory jumpers
# Author: L. Abramovich
# License: GPL3
#
# Dependencies: zoxide

if type zoxide >/dev/null 2>&1; then
	if type fzf >/dev/null 2>&1; then
		dir="$(zoxide query -i -- "$@")"
	else
		dir="$(zoxide query -- "$@")"
	fi
	[ -n "$dir" ] && echo "$dir" >"$CLIFM_BUS"
fi

exit 0
