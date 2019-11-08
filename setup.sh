#!/bin/bash

DIRECTORY="$( cd "$(dirname "$0")" ; pwd -P )"

DOTFILES=( bash bash_logout bash_profile bashrc bin gitconfig gitignore inputrc pythonrc.py ssh tmux.conf vimrc )

for file in "${DOTFILES[@]}"; do
    if [ -e "$HOME/.$file" ]; then
        if [ "$HOME/.$file" -ef "$DIRECTORY/$file" ]; then
            echo "identical ~/.$file"
            continue
        fi
        echo -n "overwrite ~/.$file? [Ynq] "
        read prompt
        if [ -z "$prompt" ]; then
            prompt="y"
        fi
        case "$prompt" in
            y|Y)
                echo "replacing ~/.$file"
                rm -rf "$HOME/.$file"
                ln -s "$DIRECTORY/$file" "$HOME/.$file"
                ;;
            q|Q)
                exit
                ;;
            *)
                echo "skipping ~/.$file"
                ;;
        esac
    else
        echo "linking ~/.$file"
        ln -s "$DIRECTORY/$file" "$HOME/.$file"
    fi
done

mkdir -p ~/.state/vimbak
mkdir -p ~/.state/vimswp
mkdir -p ~/.state/vimund

pushd "$DIRECTORY" > /dev/null
git submodule update --init
git submodule update
popd > /dev/null

chmod -R go-rwx "$DIRECTORY/ssh"

echo "successfully installed"
