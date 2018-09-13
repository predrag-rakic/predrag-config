# Enable completion for `g` alias
source /usr/share/bash-completion/completions/git
complete -o bashdefault -o default -o nospace -F _git g

if [ -f ~/.aliases ]; then
. ~/.aliases
fi

# bash prompt
if [ -f ~/.bash_prompt ]; then
. ~/.bash_prompt
fi
