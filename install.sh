#!/bin/sh

symlink () {
    /bin/ln -s $2 $1
}

mkdirp () {
    /bin/mkdir -p $1
}

SCRIPT_REALPATH=`readlink -f $0`
DOTFILES_DIR=`dirname ${SCRIPT_REALPATH}`

#git submodule update --init --recursive

symlink "${HOME}/.oh-my-zsh" "${DOTFILES_DIR}/oh-my-zsh"
symlink "${HOME}/.zshrc" "${DOTFILES_DIR}/zshrc"

symlink "${HOME}/.vimrc" "${DOTFILES_DIR}/vimrc"
mkdirp "${HOME}/.vim/autoload"
symlink "${HOME}/.vim/autoload/plug.vim" "${DOTFILES_DIR}/vim-plug/plug.vim"

mkdirp "${HOME}/.config"
symlink "${HOME}/.config/nvim" "${HOME}/.vim"
symlink "${HOME}/.vim/init.vim" "${HOME}/.vimrc"

symlink "${HOME}/.tmux.conf" "${DOTFILES_DIR}/tmux.conf"
