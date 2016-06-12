###############################################################################
# .bashrc
###############################################################################

# ALIASES
local_os=$(uname)
if [ "${local_os}" = 'Darwin' ]; then
  alias ls='ls -CFG'
  alias df='df -h'
  alias du='du -shc'
  alias g='/usr/local/bin/git'
  alias git='/usr/local/bin/git'
  export PATH="${PATH}:/usr/local/sbin"
elif [ "${local_os}" = 'Linux' ]; then
  alias ls='ls --color=auto'
  alias g='git'
fi
alias c='/usr/bin/clear'
alias please='eval "sudo $(history -p !!)"'
alias l.='ls -d .*'
alias ll='ls -l'
alias la='ls -a'
alias lal='ls -al'
alias lalt='ls -alt'
alias ve='virtualenv'
alias bi='bundle install'
alias be='bundle exec'
alias ni='npm install'
alias nr='npm run'

git_branch() {
  git branch --all 2> /dev/null | grep '^* ' | head -1 | sed 's/* //'
}

set_prompt () {
  local last_command=$?
  PS1='\[\e[01;37m\]$? ' # Exit Status
  if [ "${last_command}" = "0" ]; then
      PS1+='\[\e[01;32m\]\342\234\223 ' # Green Check-Mark
  else
      PS1+='\[\e[01;31m\]\342\234\227 ' # Red X
  fi
  if [ "${EUID}" = "0" ]; then
      PS1+='\[\e[01;31m\]\u@\h:' # Red USER/HOSTNAME
  else
      PS1+='\[\e[01;30m\]\u@\h:' # Dark USER/HOSTNAME
  fi
  local repo=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -z "${repo}" ]; then
      PS1+='\[\e[01;34m\]\w'
  else
      PS1+='\[\e[01;34m\]\w \[\e[00m\](\[\e[01;36m\]$(git_branch)\[\e[00m\])'
  fi
  PS1+='\[\e[00m\]\n$ '
}
PROMPT_COMMAND=set_prompt
export EDITOR='vim'

export HISTFILESIZE=5000
export HISTSIZE=5000

# PRESERVE ALL HISTORY
if [ ! -d "${HOME}/.bash_history_dir" ]; then
  mkdir "${HOME}/.bash_history_dir"
fi
export HISTFILE="${HOME}/.bash_history_dir/bash_history_$(date +%Y-%m-%d-%s)"

# SHELL OPTIONS
shopt -s cmdhist
set -o vi

# RVM
RVM_SCRIPT="${HOME}/.rvm/scripts/rvm"
[[ -s "${RVM_SCRIPT}" ]] && source "${RVM_SCRIPT}"

# NVM
export NVM_DIR="${HOME}/.nvm"
NVM_SCRIPT="${NVM_DIR}/nvm.sh"
[[ -s "${NVM_SCRIPT}" ]] && source "${NVM_SCRIPT}"

# SDKMAN
export SDKMAN_DIR="/Users/elliotweiser/.sdkman"
SDKMAN_SCRIPT="${SDKMAN_DIR}/bin/sdkman-init.sh"
[[ -s "${SDKMAN_SCRIPT}" ]] && source "${SDKMAN_SCRIPT}"
