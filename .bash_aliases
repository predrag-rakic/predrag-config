# Enable completion for `g` alias
source /usr/share/bash-completion/completions/git
complete -o bashdefault -o default -o nospace -F _git g

# Dir aliases
alias plu="cd ~/w/plumber"

# Git aliases
alias g="git"
alias gst="git status"
alias gco="git checkout"
alias gbr="git branch"
alias artc="cd ~/w/artifact-client/"
alias arts="cd ~/w/artifact-server/"

# K8s
alias k="kubectl"
alias kx="kubectx"
alias kn="kubens"
alias heapster='export GRAFANA=$(k -n kube-system get po -l "k8s-app=grafana" -o jsonpath="{.items[0].metadata.name}"); \
                k -n kube-system port-forward $GRAFANA 12345:3000'

# Docker
alias d="docker"

# Inframan
alias infra="BUNDLE_GEMFILE=/home/psr/w/inframan/Gemfile bundle exec inframan"
alias ecs="BUNDLE_GEMFILE=/home/psr/w/inframan/Gemfile bundle exec inframan ecs"
alias cluster="ecs cluster"

# Tmux
alias tm="tmux new -s \`basename \$(pwd)\` \; \
               send-keys ll C-m \; \
               split-w  \; \
               send-keys 'g --no-pager ll -5' C-m C-m C-m 'g st' C-m\; \
               neww \; select-window -t 1 \; select-pane -t 1"

# exa
alias lll="exa -la --git"

# Env vars
export EDITOR=vim

# bash prompt
if [ -f ~/.bash_prompt ]; then
. ~/.bash_prompt
fi
