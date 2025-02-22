#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    if [ $# -eq 1 ] && id "$1" &>/dev/null; then
        home=$(getent passwd "$1" | cut -d: -f6)

        if [ -n "$home" ] && cd "$home" &>/dev/null; then
            if [ -f docker-compose.yml ]; then
                export USER_ID=$(id -u "$1")
                export GROUP_ID=$(id -g "$1")

                if /usr/bin/docker compose ps -q &>/dev/null; then
                    /usr/bin/docker compose down
                fi

                /usr/bin/docker compose up -d --build

                exit 0
            else
                echo "Error: docker-compose.yml not found in $home"
            fi
        else
            echo "Error: Failed to access $1's home"
        fi
    else
        echo "Usage: $0 USER"
    fi
else
    echo "Error: Permission denied"
fi

exit 1
