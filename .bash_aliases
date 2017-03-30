# Enable completion for `g` alias
source /usr/share/bash-completion/completions/git
complete -o bashdefault -o default -o nospace -F _git g

# Git aliases
alias g="git"
alias gst="git status"
alias gco="git checkout"
alias gbr="git branch"
alias artc="cd ~/w/artifact-client/"
alias arts="cd ~/w/artifact-server/"

# Inframan
alias infra="BUNDLE_GEMFILE=/home/pec/w/inframan/Gemfile bundle exec inframan"
alias ecs="BUNDLE_GEMFILE=/home/pec/w/inframan/Gemfile bundle exec inframan ecs"
alias cluster="ecs cluster"

# Tmux
alias tm="tmux new \; neww \; select-w -t 1 "

. ~/.bash_prompt
