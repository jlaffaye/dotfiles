# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="risto"

DISABLE_AUTO_UPDATE="true"

COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git pass)

# User configuration

export PATH="${PATH}:${HOME}/bin"

export PAGER="less"
export EDITOR="vim"
export LC_ALL="en_US.UTF-8"

export GOPATH="${HOME}"
export GO15VENDOREXPERIMENT=1

# Ctrl-R
bindkey '^R' history-incremental-search-backward

function reload_zsh {
    source ~/.zshrc
    rehash
}

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

source $ZSH/oh-my-zsh.sh

# Don't share history
setopt append_history no_inc_append_history no_share_history
