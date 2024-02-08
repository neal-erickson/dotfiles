# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="aussiegeek"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" "aussiegeek" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
#COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(ssh-agent autojump)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# --------------------------------------------------------------------------------------------------------------
# ------- END ORIGINAL .ZSHRC FILE !!!!! -----------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------
:
# ---------------------------------------------------------------------
# PATH
# ---------------------------------------------------------------------

export PATH="/opt/homebrew/bin:$PATH"    

# ---------------------------------------------------------------------
# PyEnv
# ---------------------------------------------------------------------

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ---------------------------------------------------------------------
# Autojump
# ---------------------------------------------------------------------

# From autojump post install doco:
# [ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# ---------------------------------------------------------------------
# Source my common aliases
# ---------------------------------------------------------------------

echo "Sourcing aliases..."
source ${0:a:h}/.dotfiles-common/aliases.sh

# ---------------------------------------------------------------------
# Prompt building
# ---------------------------------------------------------------------

setopt prompt_subst # Allow zsh prompt substitution and expansion
# git prompt stuff
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
VCS_INFO_FORMAT=' on %F{5}[%F{093}%b%F{5}]%f'
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
#zstyle ':vcs_info:*' formats       \
#    ' on %F{5}[%F{093}%b%F{5}]%f'
zstyle ':vcs_info:*' formats $VCS_INFO_FORMAT
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
precmd() {
    vcs_info
}

# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html

# Virtualenv
function __virtualenv_ps1 {
	[[ -n "$VIRTUAL_ENV" ]] && echo "(venv:${VIRTUAL_ENV/})"
}

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="%B%F{red}";
else
	userStyle="%F{orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="%B%F{red}%f";
else
	hostStyle="";
fi;

NEWLINE=$'\n'
PS1="${NEWLINE}" # start with a newline
PS1+=$'\U250C' # upper left corner (see https://unicode-table.com/en/blocks/box-drawing/)
PS1+=$'\U2524' # heavy vertical and left
PS1+='${userStyle}%n%f%b'; # username in orange or bold red
PS1+='@${hostStyle}%m%b%f'; # @ and host in plain
PS1+=$'\U2502' # vertical line
PS1+='%B%F{048}%~%b%f'; # working directory full path
PS1+='${vcs_info_msg_0_}' # git message (already colored)
PS1+=$'\U2502' # vertical line
PS1+='%F{081}$(__virtualenv_ps1)%f' # venv info  
PS1+='${NEWLINE}' # break to second line
PS1+=$'\U2514' # bottom left corner
PS1+=$'\U2500' # straight line
PS1+=$'\U25B6 ' # right arrow 25BA is ok
export PS1;

# right prompt setup
export RPROMPT='(%h) %* %D'

# ---------------------------------------------------------------------
# Exports
# ---------------------------------------------------------------------

# Make vim the default editor.
export EDITOR='vim';

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;

# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='9999';

# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='9999';
export HISTFILESIZE="${HISTSIZE}";
export SAVEHIST=9999

# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Prefer US English and use UTF-8
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Make pip not install without using globalpip() function above
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PIP_REQUIRE_VIRTUALENV=true

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${orange}";

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# NVM stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# jest debug printing when assertions fail...
export DEBUG_PRINT_LIMIT=20000

# ---------------------------------------------------------------------
# Pyenv
# ---------------------------------------------------------------------

# pyenv usage: https://github.com/pyenv/pyenv#set-up-your-shell-environment-for-pyenv
#echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
#echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
#echo 'eval "$(pyenv init -)"' >> ~/.zshrc

#echo "\nProfile initialization complete."

#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
#export PYENV_ROOT="$HOME/.pyenv"
#command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"

# EOF
