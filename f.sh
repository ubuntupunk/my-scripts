#!/bin/bash

# Run command/application and choose paths/files with fzf.
# Always return control of the terminal to user (e.g. when opening GUIs).
# The full command that was used will appear in your history just like any
# other (N.B. to achieve this I write the shell's active history to
# ~/.bash_history)
#
# Usage:
# f cd [OPTION]... (hit enter, choose path)
# f cat [OPTION]... (hit enter, choose files)
# f vim [OPTION]... (hit enter, choose files)
# f vlc [OPTION]... (hit enter, choose files)

f() {
    # if no arguments passed, just lauch fzf
    if [ $# -eq 0 ]
    then
        fzf | sort
        return 0
    fi

