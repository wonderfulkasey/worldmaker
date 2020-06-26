stty -ixon

rvm_silence_path_mismatch_check_flag=1

bind "set completion-ignore-case on"

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function prompt {
  local   RED="\[\033[0;31m\]"
  local   CHAR="♥"
  local   BLUE="\[\e[0;49;34m\]"

  export PS1="\[\e]2;\u@\h\a[\e[37;44;1m\]\t\[\e[0m\]]$RED\$(parse_git_branch) \[\e[32m\]\W\[\e[0m\]\n\[\e[0;31m\]$BLUE//$RED $CHAR \[\e[0m\]"
  export PS2='> '
  export PS4='+ '
}

prompt

export PATH=/var/opt/rails/bin:/var/opt/httpserver/bin:/var/opt/atom/bin:/var/opt/shotgun/bin:/var/opt/rackup/bin:/var/opt/jekyll/bin:$PATH

export PROMPT_COMMAND='history -a'

PATH=$(echo "$PATH" | awk -v RS=':' -v ORS=":" '!a[$1]++{if (NR > 1) printf ORS; printf $a[$1]}')
source /etc/environment
