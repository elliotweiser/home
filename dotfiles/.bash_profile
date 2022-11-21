###############################################################################
# .bash_profile
###############################################################################

# TODO: Set up GPG Agent once, and auto-detect it if running.
# Kill if stale, yada yada...
# Setup gpg-agent
#if [ ! -z $(which gpg-agent 2> /dev/null) ]; then
#  GPG_AGENT_INFO_PATH="${HOME}/.gpg-agent-info"
#  res=$(eval $(gpg-agent --daemon --write-env-file "${GPG_AGENT_INFO_PATH}" 2> /dev/null))
#
#  [ -z ${res} ] && eval $(gpg-
#fi

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
