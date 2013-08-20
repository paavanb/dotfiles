
# Wonderful little function. Allows you to easily pipe output into vim.
# Ex:
# Instead of "git diff | vim -R -", you just need "v git diff"
function v() {
    $@ | vim -R -
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
