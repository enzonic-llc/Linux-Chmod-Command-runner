#!/bin/bash

# Define the paths directly in the script
paths=(
    "/var/lib/pterodactyl"
    "/var/lib/pufferpanel"
    "/etc/pterodactyl"
)

while true; do
    for path in "${paths[@]}"; do
        chmod -R 777 "$path"
    done
    sleep 60
done
