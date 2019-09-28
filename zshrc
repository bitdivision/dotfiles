# Load Antigen plugin manager
source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle docker
antigen bundle zsh-users/zsh-autosuggestions

antigen theme steeef

antigen apply

alias diff='colordiff'              # requires colordiff package
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 5'
alias ..='cd ..'
alias ls='ls -hF --color'
alias ants='~/code/aichallenge/ants'
alias compDown='/media/BackupDrive/Downloads/Complete'
alias thesis='cd /home/bitdivision/work/year_4/Thesis'
alias thesisCode='cd /home/bitdivision/work/year_4/Thesis/Code' 
alias ssh-x='ssh -c arcfour,blowfish-cbc -XC'
alias ls=exa
alias la='exa -lhAF'
alias ll='exa -lh'
alias lh='exa -hAl'
alias l='exa -lhF'

alias '..'='cd ..'

# The -g makes them global aliases, so they're expaned even inside commands
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Aliases '-' to 'cd -'
alias -- -='cd -'

alias cp='nocorrect cp'         # no spelling correction on cp
alias mkdir='nocorrect mkdir'   # no spelling correction on mkdir
alias mv='nocorrect mv'         # no spelling correction on mv
alias rm='nocorrect rm'         # no spelling correction on rm

# Execute rmdir
alias rd='rmdir'
# Execute rmdir
alias md='mkdir -p'
alias cdcode='cd ~/Dropbox/code'

alias vim="nvim"

eval $(dircolors -b)

#########################
#Environment Vars
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/share/java/apache-ant/bin:/opt/drbl/bin:/opt/drbl/sbin:/usr/bin/core_perl:/home/bitdivision/inPath:/home/bitdivision/.gem/ruby/2.2.0/bin:/home/bitdivision/.cargo/bin:/opt/resolve/bin:/home/bitdivision/scripts
export TRAVIS_BRANCH="v3"
export EDITOR="nvim"
export PATH="$PATH:$HOME/go/bin"
export GOPATH="/home/bitdivision/go"

##########################
#Following is copied from github.com/cypher/dotfiles
##########################

autoload -U zstyle+

## General completion technique
## complete as much as you can ..
zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix
## determine in which order the names (files) should be
## listed and completed when using menu completion.
zstyle ':completion:*' file-sort name

## case-insensitive,partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## completion caching
zstyle ':completion:*' use-cache 1
# zstyle ':completion:*' cache-path ~/.zcompcache/$HOST

## add colors to completions
zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}

_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1 # Because we didn't really complete anything
}

zstyle ':completion:::::' completer _force_rehash _complete _approximate


zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

zstyle ':completion:*:kill:*:processes' command "ps x"

# Auto-completion for ssh hosts
zstyle -e ':completion::*:hosts' hosts 'reply=($(sed -e "/^#/d" -e "s/ .*\$//" -e "s/,/ /g" /etc/ssh_known_hosts(N) ~/.ssh/known_hosts(N) 2>/dev/null | xargs) $(grep \^Host ~/.ssh/config(N) | cut -f2 -d\  2>/dev/null | xargs))'

#########################################################################################
# Some options

# history:
setopt append_history       # append history list to the history file (important for multiple parallel zsh sessions!)
setopt SHARE_HISTORY        # import new commands from the history file also in other zsh-session
setopt extended_history     # save each command's beginning timestamp and the duration to the history file
setopt hist_ignore_all_dups # If  a  new  command  line being added to the history
                            # list duplicates an older one, the older command is removed from the list
setopt hist_ignore_space    # remove command lines from the history list when
                            # the first character on the line is a space

HISTFILE=$HOME/.zsh_history
HISTSIZE=2000
SAVEHIST=1000000              # useful for setopt append_history


setopt auto_cd              # if a command is issued that can't be executed as a normal command,
                            # and the command is the name of a directory, perform the cd command to that directory

setopt extended_glob        # in order to use #, ~ and ^ for filename generation
                            # grep word *~(*.gz|*.bz|*.bz2|*.zip|*.Z) ->
                            # -> searches for word not in compressed files
                            # don't forget to quote '^', '~' and '#'!

setopt longlistjobs         # display PID when suspending processes as well

setopt notify               # report the status of backgrounds jobs immediately

setopt hash_list_all        # Whenever a command completion is attempted, make sure
                            # the entire command path is hashed first.

# setopt completeinword       # not just at the end

setopt nohup                # and don't kill them, either

# setopt auto_pushd         # make cd push the old directory onto the directory stack.

setopt nonomatch            # try to avoid the 'zsh: no matches found...'

setopt nobeep               # avoid "beep"ing

setopt pushd_ignore_dups    # don't push the same dir twice.

setopt noglobdots           # * shouldn't match dotfiles. ever.

setopt long_list_jobs       # List jobs in long format

#########################################################################################

# do we have GNU ls with color-support?
#alias ls='ls -bh -CF'

# Grep in history
function greph () { history 0 | grep -i $1 }

# mkdir, cd into it (via http://onethingwell.org/post/586977440/mkcd-improved)
function mkcd () {
    mkdir -p "$*"
    cd "$*"
}

function precmd () {
    title "zsh" "$USER@%m" "%55<...<%~"
}

# preexec is called just before any command line is executed
function preexec () {
    title "$1" "$USER@%m" "%35<...<%~"
}

# nvm removed due to slow startup. Can load on demand
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
source ~/scripts/znvm/znvm.sh

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

######## HMRC Specific ##########
export TF_PLUGIN_CACHE_DIR=~/.tfcache/

#################################
