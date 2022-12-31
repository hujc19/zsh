# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.config/zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="zhann"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )powerlevel10k/powerlevel10k

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
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
HIST_STAMPS="mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)
plugins=(
	git
	web-search
  zsh-vi-mode
	colorize
	command-not-found
	copyfile
	history
	extract
	pj
	z
	rand-quote
	themes
	tmux
  docker
  docker-compose
  git-open
  zsh-autosuggestions
)
function zvm_config() {
  ZVM_VI_EDITOR=nvim
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE


ZVM_VI_HIGHLIGHT_FOREGROUND=green             # Color name
# ZVM_VI_HIGHLIGHT_FOREGROUND=#008800           # Hex value
ZVM_VI_HIGHLIGHT_BACKGROUND=yellow               # Color name
# ZVM_VI_HIGHLIGHT_BACKGROUND=#ff0000           # Hex value
ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline    # bold and underline

  # Always starting with insert mode for each command line
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

function zvm_after_select_vi_mode() {
  case $ZVM_MODE in
    $ZVM_MODE_NORMAL)
      # Something you want to do...
    ;;
    $ZVM_MODE_INSERT)
      # Something you want to do...
    ;;
    $ZVM_MODE_VISUAL)
      # Something you want to do...
    ;;
    $ZVM_MODE_VISUAL_LINE)
      # Something you want to do...
    ;;
    $ZVM_MODE_REPLACE)
      # Something you want to do...
    ;;
  esac
}
}

source $ZSH/custom/plugins/zsh-vi-mode/zsh-vi-mode.zsh
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

#source ~/.oh-my-zsh/plugins/incr/incr*.zsh
[[ -s /home/$USER/.autojump/etc/profile.d/autojump.sh ]] && source /home/$USER/.autojump/etc/profile.d/autojump.sh

#prompt_context() {
#  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
#    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
#  fi
#}
DEFAULT_USER=$USER

prompt_dir(){
  prompt_segment blue black '%c'
}

source /opt/ros/noetic/setup.zsh

function upsearch()
{ 
  test "/" = "$PWD" && echo "upsearch fail: " "$1" && return || \
  test -e "$1" && UPSEARCH_RET="$PWD" && return || builtin cd .. && upsearch $1
}

function ros_workspace_run()
{
  dir_run="$PWD"
  upsearch devel
  if [ "$UPSEARCH_RET" != "/" ]; then
    echo "start from $UPSEARCH_RET"  
    builtin cd $UPSEARCH_RET
    $*
  else
    echo "start from current path"
    builtin cd $dir_run
    $*
  fi
  builtin cd $dir_run
}
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"

## system
alias ss="ros_workspace_run source ./devel/setup.zsh"
alias gz="gedit ~/.zshrc"
alias sz="source ~/.zshrc"
alias cb="ros_workspace_run catkin build"
alias cm="ros_workspace_run catkin_make"
alias cc="ros_workspace_run catkin clean -y"
alias ccb="ros_workspace_run catkin clean -y && catkin build"
alias ccm="ros_workspace_run catkin clean -y && catkin_make"
alias rg="ranger"
alias sudo="sudo "

## git
alias gs="git status"
alias gl="git log"
alias gd="git diff"

# local settings
# local settings

export QT_NO_FT_CACHE=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# added by pipx (https://github.com/pipxproject/pipx)
export PATH="/home/sti/.local/bin:$PATH"

# default editor
export EDITOR=/usr/bin/nvim

# docker completion
fpath=(~/.config/zsh/completion/ $fpath)
autoload -Uz compinit && compinit -i
# deno.land for nvim markdown
  export DENO_INSTALL="/home/sti/.deno"
  export PATH="$DENO_INSTALL/bin:$PATH"
