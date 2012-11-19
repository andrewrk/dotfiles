. /etc/bash.bashrc
. ~/.bash_aliases

# force ignoredups and ignorespace
HISTCONTROL=ignoreboth
# these commands in conjunction make history work across terminals
shopt -s histappend
PROMPT_COMMAND="history -a"
# keep a lot of bash history
HISTSIZE=50000
HISTFILESIZE=10000000

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

EDITOR=vim

if [ -f ~/.bash_profile ]; then
  . ~/.bash_profile
fi
