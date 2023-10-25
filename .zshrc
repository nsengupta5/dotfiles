HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt autocd extendedglob nomatch menucomplete appendhistory
setopt interactive_comments
zle_highlight=(paste:none)

export HISTCONTROL=ignoreboth
export EDITOR='nvim'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export LD_LIBRARY_PATH=/usr/local/clang_9.0.0/lib:$LD_LIBRARY_PATH
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export CHROME_EXECUTABLE=/usr/bin/brave-browser
export LIBBY_OUTPUT_DIR="$HOME/Documents/Books"
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi

PATH="$PATH:/usr/local/go/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.npm-global/bin"
PATH="$PATH:$HOME/go/bin"
# PATH="$PATH:$HOME/.cargo/bin"
# PATH="$PATH:$HOME/.emacs.d/bin"
# PATH="$PATH:$HOME/Downloads/flutter/bin"
# PATH="$PATH:$HOME/Android/cmdline-tools/tools/bin"
# PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export PATH
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export CLICOLOR=1
export EXA_COLORS="$(vivid generate catppuccin-mocha)"

# # Basic auto-completion
autoload -U compinit; 
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

source "$ZDOTDIR/zsh_functions"
source /usr/share/fzf/shell/key-bindings.zsh
source ~/.bash_aliases

zsh_add_file "zsh_vim_mode"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "zsh-users/zsh-autosuggestions"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

eval "$(fasd --init auto)"
eval "$(starship init zsh)"
eval "$(mcfly init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/nsengupta5/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/nsengupta5/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/nsengupta5/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/nsengupta5/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
