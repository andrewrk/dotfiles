# git
alias gs='git status'
alias gc='git commit'
alias gca='git add -A && git commit'
alias gd='git diff'
alias gl='git log'
alias gp='git pull'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gf='git fetch'
alias gm='git merge'

# colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mkpass='head -c 9 /dev/urandom | base64'
alias gvim='vim -g'


alias zig='/home/andy/dev/zig/build/zig'
