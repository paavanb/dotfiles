alias vim='mvim -v'

function v() {
    $@ | vim -R -
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
