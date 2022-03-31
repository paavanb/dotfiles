. ~/.bash_aliases
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# Set history size
export HISTSIZE=10000
export HISTFILESIZE=10000

# Wonderful little function. Allows you to easily pipe output into vim.
# Ex:
# Instead of "git diff | vim -R -", you just need "v git diff"
function v() {
    $@ | vim -R -
}

# fzf branch - checkout git branch, sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Use neovim as the manpager (use gO to see outline)
export MANPAGER='nvim +Man!'
