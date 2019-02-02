#!/usr/bin/env bash

#
# [.bashrc]
#
# My bash shell startup file.
# Copyright (C) 2018-2019, Liam Schumm
#


#
# configuration
#

export PATH="$PATH:/Users/lschumm/research/lime"
export PS1="$ "
alias ls="ls -1" # always show ls entries on new lines


#
# aliases
#

alias l="lime"
alias ld="lime dshell"


#
# miscellaneous
#

# there's a lot of stuff that MacOS keeps in the home folder.
# i prefer Desktop, since it doesn't have that stuff and
# is also visible on the screen by default.
cd ~/Desktop
alias cd="HOME=/Users/lschumm/Desktop cd"
