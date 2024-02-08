# ------------------aliases -----------------
echo -n "Adding aliases..."

# basic ls
alias ls="ls -aFG"

# list long format
alias ll="ls -alFG"

# List only directories
alias lsd="ls -lFG | grep --color=never '^d'"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Recursively delete `.DS_Store` files
alias rmds="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# Restart shell
alias restart='exec "$SHELL"'

# Handy history function
alias hpg='history | grep '

# Alias for my bare git repo setup
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles-repo --work-tree=$HOME'

# -----------------------------------------------------------------------------
# Git aliases - some borrowed from https://github.com/paulirish/dotfiles/blob/master/.gitconfig
# -----------------------------------------------------------------------------

alias gl='git log --color --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias grhh='git reset --hard head'
alias gs='git status'
alias gss='git status --short -b'
alias gaa='git add --all'
alias gcb='git checkout -b '
alias gp='git pull'
alias gco='git checkout'
alias gcm='git checkout master'
alias gcom='git commit -m '
alias gd='git diff --color --color-words --abbrev' # nice diff
alias gbl='git branch -alv --sort=-committerdate' # list branches, sorted by last commit date
alias gr='git remote -v'

echo "...done."

