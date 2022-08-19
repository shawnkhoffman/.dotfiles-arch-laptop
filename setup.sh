#!/bin/bash
clear

PS3="Enter a number: "

echo "Checking for dependencies..."
echo "Checking for stow..."
if ! command -v stow &> /dev/null; then
    echo "Stow not found! Please install it and try again."
    exit 1
fi
echo "Checking for git..."
if ! command -v git &> /dev/null; then
    echo "Git not found! Please install it and try again."
    exit 1
fi
echo "Checking for submodules..."
if [ ! "$(ls -A zsh/powerlevel10k)" ]; then
    echo; echo "The submodules in this repo need to be initialized before you can proceed."
    echo "Initialize the submodules?"
    select choice in "Yes" "No (Quit)"; do
        if [ "$choice" == "Yes" ]; then
            echo "Updating submodules..."; echo
            git submodule update --init --recursive
            break
        elif [ "$choice" == "No (Quit)" ]; then
            echo "Quitting..."
            exit 1
        else
            echo "Invalid selection."; echo
        fi
    done
fi
clear

echo "Obi Shawn Kenobi's"; echo "Arch Linux laptop dotfiles"
echo "https://github.com/shawnkhoffman"
echo "================================="
echo $(basename "$0")
echo "This script will initialize the dotfiles repo."; echo

echo "Repo initialized!"; echo

if [ ! -d "home/wallpapers-4k" ]; then
    echo "Would you like to install the 4K wallpapers?"
    select choice in "Yes" "No" "Quit"; do
        if [ "$choice" == "Yes" ]; then
            if [ ! -d "home/wallpapers-4k" ]; then
                echo "Installing 4K wallpapers..."; echo
                git submodule add git@github.com:shawnkhoffman/wallpapers-4k.git home/wallpapers-4k
                echo
            else
                echo "4K wallpapers already installed!"; echo
            fi
            break
        elif [ "$choice" == "No" ]; then
            echo "Skipping 4K wallpapers..."; echo
            break
        elif [ "$choice" == "Quit" ]; then
            echo "Quitting..."
            exit 1
        else
            echo "Invalid selection."; echo
        fi
    done
fi

echo "Would you like to proceed with installing dotfiles?"
select choice in "Yes, start the installer." "No, I will start it manually. (Quit)"; do
    if [ "$choice" == "Yes, start the installer." ]; then
        echo "Running installer.sh..."
        ./installer.sh
        break
    elif [ "$choice" == "No, I will start it manually. (Quit)" ]; then
        echo; echo "OK. When you're ready, run installer.sh in the root of this repo!"
        echo "Quitting..."
        exit 1
    else
        echo "Invalid selection."; echo
    fi
done