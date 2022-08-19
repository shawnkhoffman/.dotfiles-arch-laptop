#!/bin/bash

echo; echo "Checking for dependencies..."
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
echo "Dependencies found. Continuing..."

clear

PS3="Enter a number: "

echo "Obi Shawn Kenobi's"; echo "Arch Linux laptop dotfiles"
echo "https://github.com/shawnkhoffman"
echo "================================="
echo $(basename "$0")
echo "This script will initialize the dotfiles repo."; echo

if [ ! -d "home/wallpapers-4k" ]; then
    echo "Would you like to install the 4K wallpapers?"
    select choice in "Yes" "No"; do
        if [ "$choice" == "Yes" ]; then
            if [ ! -d "home/wallpapers-4k" ]; then
                echo "Installing 4K wallpapers..."; echo
                # git submodule add git@github.com:shawnkhoffman/wallpapers-4k.git home/wallpapers-4k
            else
                echo "4K wallpapers already installed!"; echo
            fi
            break
        elif [ "$choice" == "No" ]; then
            echo "Skipping 4K wallpapers..."; echo
            break
        else
            echo "Invalid selection."; echo
        fi
    done
fi

echo "Initializing repo..."
if [ -z "$(git submodule update --init --recursive)" ]; then
    echo "Repo already initialized!"; echo
else
    git submodule update --init --recursive
    echo "Repo initialized!"; echo
fi


echo "Would you like to proceed with installing dotfiles?"
select choice in "Yes, automatically run the installer." "No, I will run it manually. (Quit)"; do
    if [ "$choice" == "Yes, automatically run the installer." ]; then
        echo "Running installer.sh..."
        ./installer.sh
        break
    elif [ "$choice" == "No, I will run it manually. (Quit)" ]; then
        echo; echo "OK. When you're ready, run installer.sh in the root of this repo!"
        echo "Quitting..."; echo
        break
    else
        echo "Invalid selection."; echo
    fi
done