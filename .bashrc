#!/usr/bin/env bash

# ------------------ SSH nonsense -----------------

# start up ssh-agent, unless running on a mac (Darwin uname)
if [ ! "$(uname)" == "Darwin" ]; then

echo "Initializing ssh-agent..."
SSH_ENV="$HOME/.ssh/environment"

# spawn ssh-agent
ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
echo succeeded
chmod 600 "$SSH_ENV"
. "$SSH_ENV" > /dev/null
ssh-add

echo "ssh-agent setup complete."
else
echo "Skipping ssh-agent for OSX..."
fi

#-------------- colorizing setup ---------------

# nerickson's customization
# (much sourced from https://github.com/mathiasbynens/dotfiles)

# <-- colorizing/misc -->

# handy for fancy echoing
bold=$(tput bold)
normal=$(tput sgr0)
underline=$(tput sgr 0 1) 

# make it easier to use colors in ps1
if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 64);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

# some kind of weird default thing
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

# <-- completion -->

# more global option from http://davidalger.com/development/bash-completion-on-os-x-with-brew/
# what the bash_completion homebrew package says to do:
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# <-- Shell options -->

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# <-- Aliases -->

# Detect which `ls` flavor is in use - just using this for reference
# example: alias la="ls -laF ${colorflag}"
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

# ------------------aliases -----------------

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
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

# git alias automagic generation
# (preventing having to duplicate all of them between git aliases and bash aliases)
# (sourced from https://gist.github.com/mwhite/6887990)
echo "Prefixing git aliases:"

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
    . /usr/share/bash-completion/completions/git
fi

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

# note that `__git_aliases` stopped working on my newer machines, switched to the new list commands 
for al in `git --list-cmds=alias`; do
    alias g$al="git $al"
    echo "->" ${underline}$al${normal} aliased to ${bold}g$al${normal}
    complete_func=_git_$(__git_aliased_command $al)
    function_exists $complete_fnc && __git_complete g$al $complete_func
done



# <-- ps1 prompt setup -->
# note: default ps1 is “\h:\W \u\$”

# git prompt stuff
prompt_git() {
	local s='';
	local branchName='';

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+='+';
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+='!';
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+='?';
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+='$';
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" [${s}]";

		echo -e "${1}${branchName}${2}${s}";
	else
		return;
	fi;
}

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi;

# <-- prompt building -->

# original take --> PS1="\n[\t \d][\u@\H:\w]\n\$ "

PS1="\n" # start with a newline
PS1+="\[\e(0\]lu\[\e(B\]" # box drawing chars: http://vt100.net/docs/vt102-ug/table5-15.html
PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${reset}\]@";
PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${reset}\]"; # black font
PS1+="\[\e(0\]x\[\e(B\]" # box drawing
PS1+="\[${bold}\]\[${green}\]\w"; # working directory full path
PS1+="\$(prompt_git \"\[${reset}\] on \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
PS1+="\[${reset}\]"
PS1+="\[\e(0\]x\[\e(B\]" # box drawing vertical line
PS1+="\n" # second line
PS1+="\[\e(0\]mq\[\e(B\]" # box drawing
PS1+="> \[${reset}\]"; # final prompt char $/# (and reset color)
export PS1;

# PS1 todos: de-bold prompt char, add command number to 2nd line, adjust colors

# ps2 is a weird thing.
PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;

# <-- exports -->

# Make vim the default editor.
export EDITOR='vim';

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${orange}";

# fin
