#!/usr/bin/env python

import os
import errno
import subprocess

def mkdirs(path):
    realpath = os.path.expanduser(path)
    try:
        os.makedirs(realpath)
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise

def symlink(link, dest):
    link_path = os.path.normpath(os.path.expanduser(link))
    dest_path = os.path.normpath(os.path.expanduser(dest))
    try:
        os.symlink(dest_path, link_path)
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise
        current_dest = os.readlink(link_path)
        if not os.path.samefile(current_dest, dest_path):
            raise

dotfiles_dir = os.path.dirname(os.path.realpath(__file__))

subprocess.call("git submodule update --init --recursive", shell=True, cwd=dotfiles_dir)

symlink("~/.oh-my-zsh", os.path.join(dotfiles_dir, "./oh-my-zsh"))
symlink("~/.zshrc", os.path.join(dotfiles_dir, "./zshrc"))

symlink("~/.vimrc", os.path.join(dotfiles_dir, "./vimrc"))
mkdirs("~/.vim/autoload")
symlink("~/.vim/autoload/plug.vim", os.path.join(dotfiles_dir, "./vim-plug/plug.vim"))

mkdirs("~/.config")
symlink("~/.config/nvim", "~/.vim")
symlink("~/.vim/init.vim", "~/.vimrc")

symlink("~/.tmux.conf", os.path.join(dotfiles_dir, "./tmux.conf"))

symlink("~/.gitconfig", os.path.join(dotfiles_dir, "./gitconfig"))

mkdirs("~/bin")
symlink("~/bin/ssh-ident", os.path.join(dotfiles_dir, "./ssh-ident/ssh-ident"))
symlink("~/.ssh-ident", os.path.join(dotfiles_dir, "./ssh-ident.conf"))

subprocess.call("vim +PlugInstall +qall", shell=True, cwd=dotfiles_dir)
