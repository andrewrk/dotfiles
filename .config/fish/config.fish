set fish_greeting
set -x EDITOR vim
set -x FZF_DEFAULT_OPTS --exact

function dev
  cd ~/dev/$argv
  nix-shell ~/env/$argv.nix
end

function gf
  git fetch --all --prune --tags
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

function gb
  git push origin (git commit-tree -m "" (git mktree </dev/null) </dev/null):refs/heads/$argv[1]
  git checkout -b $argv[1]
  git push --set-upstream --force-with-lease origin $argv[1]
end

function mkpass
  head -c 12 /dev/urandom | base64
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

function clbin
  curl -F 'clbin=<-' https://clbin.com
end
