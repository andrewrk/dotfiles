set fish_greeting
set -x EDITOR vim

function dev
  cd ~/dev/$argv
  nix-shell ~/env/$argv.nix
end

function gs
  git status
end

function gc
  git commit $argv
end

function gca
  git add -A; and git commit $argv
end

function gd
  git diff $argv
end

function gl
  git log $argv
end

function gp
  git pull $argv
end

function mkpass
  head -c 9 /dev/urandom | base64
end

function gvim
  vim -g $argv
end

function g
  grep -RI --color=auto --exclude=tags --exclude-dir=.git --exclude-dir=build $argv
end

function ccd
  mkdir -p "$argv"
  and cd "$argv"
end

function fish_user_key_bindings
  fzf_key_bindings
end
