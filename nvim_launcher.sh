if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

PATH="$PATH:/usr/local/go/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.npm-global/bin"
PATH="$PATH:$HOME/go/bin"
# PATH="$PATH:$HOME/.cargo/bin"
# PATH="$PATH:$HOME/.emacs.d/bin"
PATH="$PATH:$HOME/Downloads/flutter/bin"
# PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PATH
nvim
