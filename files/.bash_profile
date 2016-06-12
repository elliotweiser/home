###############################################################################
# .bash_profile
###############################################################################

# Setup gpg-agent
if [ ! -z $(which gpg-agent 2> /dev/null) ]; then
  eval $(gpg-agent --daemon --log-file "${HOME}/.gnupg/gpglog" --write-env-file "${HOME}/.gpg-agent-info")
  if [ -f "${HOME}/.gpg-agent-info" ]; then
    source "${HOME}/.gpg-agent-info"
  fi
  # Save gpg-agent PID
  export GPG_AGENT_PID=$(env | grep GPG_AGENT_INFO | cut -f 2 -d ':')
  function gpg_agent_kill {
    kill "${GPG_AGENT_PID}"
  }
  trap gpg_agent_kill EXIT
fi

# SOURCE ALL TEH THINGS!

# Bash stuff
[[ -f "${HOME}/.bashrc" ]] && source "${HOME}/.bashrc"
[[ -f "${HOME}/.profile" ]] && source "${HOME}/.profile"

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
