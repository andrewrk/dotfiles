# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# force ignoredups and ignorespace
HISTCONTROL=ignoreboth
# these commands in conjunction make history work across terminals
shopt -s histappend
PROMPT_COMMAND="history -a"
# keep a lot of bash history
HISTSIZE=50000
HISTFILESIZE=10000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# settings
EDITOR=vim

# cd to a possibly nonexisting directory, creating if necessary
ccd() { mkdir -p "$@" && cd "$@"; }

# add ~/bin to PATH
export PATH="~/bin:$PATH"

export DEBFULLNAME="Andrew Kelley"
export DEBEMAIL="superjoe30@gmail.com"

# source bash aliases
. ~/.bash_aliases

# source computer-specific ~/.bash_profile
if [ -f ~/.bash_profile ]; then
  . ~/.bash_profile
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
