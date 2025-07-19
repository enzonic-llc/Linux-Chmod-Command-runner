#!/bin/bash

# Load paths from the configuration file
CONFIG_FILE="../config/paths.conf"

while true; do
    while IFS= read -r path; do
        chmod -R 777 "$path"
    done < "$CONFIG_FILE"
    sleep 60
done