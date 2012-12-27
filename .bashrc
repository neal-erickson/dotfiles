#eval `ssh-agent`
#ssh-add

SSH_ENV="$HOME/.ssh/environment"

# start the ssh-agent
echo "Initializing new SSH agent..."

# spawn ssh-agent
ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
echo succeeded
chmod 600 "$SSH_ENV"
. "$SSH_ENV" > /dev/null
ssh-add

# General aliases
alias ls='ls -aF --color --show-control-chars'
alias ll='ls -l'

# git shorthand
alias gl='git log'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git pull'
alias gpr='git pull --rebase'
#alias gpip='git stash save && gp && git stash pop'
#alias gpp='git pull && git push'
#alias gdp='git diff HEAD^ HEAD'
alias gb='git branch'

# Functions can accept command line parameters by location ($1)
#gbip()
#{
#	git stash save && git checkout -b $1 && git stash pop
#}