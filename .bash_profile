echo "bash_profile 1"
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

PS1_COLOR_BEGIN="\[\e[1;31m\]"
PS1_COLOR_END="\[\e[m\]"
PS1_HOST_NAME="MyUbuntu"

export LS_COLORS='di=01;35'

source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
export PS1='\[\033[01;32m\]\u@\h\[\033[01;33m\] \w$(__git_ps1) \n\[\033[01;34m\]\$\[\033[00m\] '

