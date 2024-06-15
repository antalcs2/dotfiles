# If id command returns zero, you got root access.
if [ $(id -u) -eq 0 ];
then # you are root, set red colour prompt
  # PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w #\\[$(tput sgr0)\\]"
  # PS1='\[\e[38;5;34m\][\[\e[91;1m\]\u\[\e[0;38;5;34m\]@\h]:\[\e[38;5;220m\]\w\[\e[0m\] \[\e[91m\]\$\[\e[0m\] '
PS1="\[\033[m\]|\[\033[1;35m\]\t\[\033[m\]|\[\e[1;31m\]\u\[\e[1;36m\]\[\033[m\]@\[\e[1;36m\]\h\[\033[m\]:\[\e[0m\]\[\e[1;32m\][\W]> \[\e[0m\]"
else # normal
  PS1='\[\e[38;5;34m\][\u@\h]:\[\e[38;5;220m\]\w\[\e[0m\] \[\e[38;5;34m\]>\[\e[0m\] '
fi

# Got the long sausage from: https://bash-prompt-generator.org/
