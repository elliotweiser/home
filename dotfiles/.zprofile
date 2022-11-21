# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add coreutils to PATH, if needed
# export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:${PATH}"

# For using zlib Homebrew formula
# For compilers to find zlib you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"

# For pkg-config to find zlib you may need to set:
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"
export PATH="$(pyenv root)/shims:$PATH"
