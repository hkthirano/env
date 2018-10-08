export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

PS1_COLOR_BEGIN="\[\e[1;31m\]"
PS1_COLOR_END="\[\e[m\]"
PS1_HOST_NAME="MyUbuntu"
export PS1="${PS1_COLOR_BEGIN}[\u@\${PS1_HOST_NAME} \W]${PS1_COLOR_END}\\$ "

export LS_COLORS='di=01;35'

