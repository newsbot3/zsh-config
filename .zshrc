# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/james.wells/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

POWERLEVEL9K_MODE="nerdfont-complete"

ZSH_THEME="powerlevel10k/powerlevel10k"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git battery zsh-syntax-highlighting)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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
function prompt_zsh_battery_level() {
    percentage=`pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';' | grep -oe '\([0-9.]*\)'`
    local color='%F{red}'
    local symbol="\uf00d"
if [ "$(bc <<< "scale=2 ; $percentage<25")" = '1' ]
    then symbol="\uf244" ; color='%F{red}' ;
        #Less than 25
        fi  
if [ "$(bc <<< "scale=2 ; $percentage>=25")" = '1' ] && [ "$(bc <<< "scale=2 ; $percentage<50")" = '1' ]
    then symbol='\uf243' ; color='%F{red}' ;
    #25%
    fi
if [ "$(bc <<< "scale=2 ; $percentage>=50")" = '1' ] && [ "$(bc <<< "scale=2 ; $percentage<75")" = '1' ]  
    then symbol="\uf242" ; color='%F{yellow}' ;
     #50%
     fi
if [ "$(bc <<< "scale=2 ; $percentage>=75")" = '1' ] && [ "$(bc <<< "scale=2 ; $percentage<100")" = '1' ]
    then symbol="\uf241" ; color='%F{blue}' ;
        #75%
        fi  
if [ "$(bc <<< "scale=2 ; $percentage>99")" = '1' ]
    then symbol="\uf240" ; color='%F{green}' ;
        #100%
        fi
pmset -g batt | grep "discharging" >& /dev/null
if [ $? -eq 0 ]; then
    true;
else ;
   color='%F{green}' ;
fi
echo -n "%{$color%}$symbol " 
}


POWERLEVEL9K_CUSTOM_AWSPROF_BACKGROUND="yellow"
function aws_prof {
  # aws_icon='\uf52c'
  # cloud_icon='\f52d'
  # if [[ "$AWS_PROFILE" == ""]] && [[ "${AWS_DEFAULT_PROFILE}" != ""]]; then
  #   export AWS_PROFILE=${AWS_DEFAULT_PROFILE}
  # fi
  if [[ ("$AWS_PROFILE" == "") && ("${AWS_DEFAULT_PROFILE}" != "") ]]; then
    export AWS_PROFILE=${AWS_DEFAULT_PROFILE}
  fi
  if [[ "${AWS_PROFILE}" != "" ]]; then
    if grep -q $AWS_PROFILE /Users/james.wells/.aws/credentials; then
      color='%F{black}'
    else
      color='%F{red}'
    fi
    echo -n "\uf52c %{$color%}${AWS_PROFILE} \uf52d"
  fi
}
POWERLEVEL9K_CUSTOM_AWSPROF="aws_prof"
POWERLEVEL9K_CUSTOM_AWSPROF_FOREGROUND="black"
# battery
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_DISCONNECTED='$DEFAULT_COLOR'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'
POWERLEVEL9K_BATTERY_ICON=`prompt_zsh_battery_level`
POWERLEVEL9K_BATTERY_VERBOSE='false'
POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(darkred orange4 yellow4 yellow4 chartreuse3 green3 green4 darkgreen)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_awsprof time date battery)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir virtualenv newline vcs)

export PATH="/Users/james.wells/go/bin/:/Users/james.wells/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export GOPATH=/usr/local/bin/go

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/james.wells/Projects/VWFS/mps-portal-api/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/james.wells/Projects/VWFS/mps-portal-api/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/james.wells/Projects/VWFS/mps-portal-api/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/james.wells/Projects/VWFS/mps-portal-api/node_modules/tabtab/.completions/sls.zsh

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/james.wells/Projects/VWFS/mps-portal-api/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/james.wells/Projects/VWFS/mps-portal-api/node_modules/tabtab/.completions/slss.zsh


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/james.wells/Projects/PDev/K8S/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/james.wells/Projects/PDev/K8S/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/james.wells/Projects/PDev/K8S/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/james.wells/Projects/PDev/K8S/google-cloud-sdk/completion.zsh.inc'; fi
