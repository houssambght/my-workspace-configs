# Control how bash stores command history
# flags: ignorespace, ignoredups, ignoreboth
# ignorespace flag tells bash to ignore commands that start with spaces and ignoredups tells bash to ignore duplicates
# ignoreboth = ignorespace:ignoredups
export HISTCONTROL=ignoreboth
# export HISTSIZE=500
# Enable multiple session history
shopt -s histappend

## Tab Completions
set completion-ignore-case On
set show-all-if-ambiguous On # this allows you to automatically show completion without double tab-ing


# Macros
DEV_BRANCH=''
STREAM_PREFIX=''

# Aliases
#========

alias ..='cd ..'
alias ...='cd ../../'

#git
alias ga='git add --all'
alias gs='git status'
alias gl='git log --oneline'
alias glg='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias grh='git reset --hard'
alias gst='git stash'
alias gstc='git stash clear'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsta='git stash apply'
alias gf='git fetch'
alias gc='git clean -df'

# continue and abort alias
alias gmc='git merge --continue'
alias grc='git rebase --continue'
alias gcpc='git cherry-pick --continue'
alias gma='git merge --abort'
alias gra='git rebase --abort'
alias gcpa='git cherry-pick --abort'

# Functions
#==========
function grab() {
  git fetch
  git checkout $STREAM_PREFIX$1
}

function new(){
  git checkout -b $STREAM_PREFIX$1
}

function ck(){
  local id=$DEV_BRANCH
  if [ ! -z $1 ]
  then
    id=$STREAM_PREFIX$1
  fi
  git checkout $id
}

function gcp(){
  git cherry-pick $1
}

function grs(){
  git reset HEAD~$@
}

function gpl(){
  local dest=$(git symbolic-ref --short HEAD)
  git pull --rebase origin $dest $@
}

function gps(){
  local dest=$(git symbolic-ref --short HEAD)
  git push origin $dest $@
}

# clean repo
function gcr() {
  git reset --hard
  git checkout $DEV_BRANCH
  for branch in $(git branch); do
    if [[ $branch != *"master"* ]]; then
      git branch -D $branch
    fi
  done
  git gc
}