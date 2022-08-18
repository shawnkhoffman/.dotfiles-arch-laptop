#!/bin/bash

PS3="Enter a number: "
echo; echo "What do you want to do?"
select choice in "Install" "Uninstall" "Quit"; do
    if [ $choice == "Install" ]; then
        operation="install"
        break
    elif [ $choice == "Uninstall" ]; then
        operation="uninstall"
        break
    elif [ "$choice" == "Quit" ]; then
        echo "Quitting..."
        break
    else
        echo "Invalid selection."
    fi
done

if [ $choice != "Quit" ]; then
    configs=$(ls -d */ | grep -v "packages" | sed 's/^\///;s/\///g')

    msg_notify() {
        echo $(echo "${1^}ed $(echo $2 | awk '{print tolower($0)}') configs!" | sed 's/^\///;s/\///g')
    }

    apply() {
        if [ "$1" == "install" ]; then
            stow $2
            msg_notify $1 $2
        elif [ "$1" == "uninstall" ]; then
            stow -D $2 2>&1 | grep -v "BUG in find_stowed_path"
            msg_notify $1 $2
        fi
    }

    echo; echo "Which configs do you want to $operation?"
    select config in "*All configs*" $configs "Quit"; do
        if [ "$config" == "*All configs*" ]; then
            for config in $configs; do
                apply $operation $config
            done
            break
        elif [ "$config" != "Quit" ] && [ "$config" != "All" ] && [ -n "$config" ]; then
            apply $operation $config; echo
            echo "If you want to ${operation} another config, please enter it below."
            echo "Otherwise, select Quit."; echo
        elif [ "$config" == "Quit" ]; then
            echo "Quitting..."
            break
        else
            echo "Invalid selection."
        fi
    done
fi