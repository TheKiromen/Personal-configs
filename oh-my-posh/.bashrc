# Initialize Oh My Posh and set the theme
eval "$(oh-my-posh init bash --config ~/BashThemes/powerlevel10k_rainbow.omp.json)"

# Append history after each command
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# Aliases
alias ls='lsd -la'
alias h='history'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias tf='terraform'

alias cls='clear'
alias q='exit'
alias ex='exit'