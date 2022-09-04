#!/bin/bash

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

BRANCH_COLOUR="\[\033[01;33m\]"
NO_COLOR="\[\033[00m\]"

PS1="[$NOCOLOR\u@\h$NO_COLOR: \W$BRANCH_COLOUR\$(git_branch)$NO_COLOR]\$ "
