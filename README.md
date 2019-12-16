# Dotfiles

These are a simple set of dotfiles that strive to strike the right balance between usefulness and simplicity. They are designed to function on both macOS and Linux.

## Configured programs

* bash
* zsh
* git
* ssh
* tmux
* vim

## Requirements

Depending on your system, you may need to manually install or upgrade to the following packages:

* vim 8.0+
* openssh 7.3p1+
* bash 4.1+
* bash-completion (for bash 4.1+)
* zsh 5.7+

## Install

Run the following commands in your terminal. It will prompt you before it does anything destructive. Check out the setup script to see exactly what it does.

```bash
git clone https://github.com/anaoum/dotfiles.git ~/repos/dotfiles
~/repos/dotfiles/setup.sh
```

After installing, open a new terminal window to see the effects.

## Uninstall

To remove the dotfile configs, run the following commands:

```bash
unlink ~/.aliases
unlink ~/.bashrc
unlink ~/.bin
unlink ~/.gitconfig
unlink ~/.gitignore
unlink ~/.gitprompt
unlink ~/.profile
unlink ~/.ssh
unlink ~/.tmux.conf
unlink ~/.vimrc
unlink ~/.zshrc
rm -rf ~/repos/dotfiles
```
