#!/bin/bash

# This is the configuration file location, you can change it to your liking
CONFIG_FILE="$HOME/.config/bashbar/bashbar.conf"

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "Config file not found at $CONFIG_FILE. Please create the config file to continue."
    exit 1
fi

hide_cursor() {
    echo -e "\033[?25l"
}

# Write your functions here



# Below are a few basic functions, feel free to use or delete them

# Default function to display CPU usage
cpu_usage() {
    awk -v FS=" " '/^cpu /{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}' /proc/stat
}

# Default function to display memory usage
mem_usage() {
    free -h | awk '/^Mem/ { print $3"/"$2 }'
}

# Default function to display current time
clock() {
    date '+%Y-%m-%d %H:%M:%S'
}

# Default function to display battery status
battery_status() {
    if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
        cat /sys/class/power_supply/BAT0/capacity
    else
        echo "N/A"
    fi
}

# Default function to display network status
network_status() {
    ip a | grep -w inet | awk '{print $2}' | head -n 1
}

# Nececessary code (do not change unless you know what you're doing)
update_title() {
    echo -ne "\033]0;$1\007"
}

apply_layout() {
    case "$layout_format_position" in
        "left")
            echo "$1"
            ;;
        "center")
            printf "%*s\n" $(( (${#1} + $(tput cols)) / 2 )) "$1"
            ;;
        "right")
            printf "%*s\n" $(tput cols) "$1"
            ;;
        *)
            echo "Invalid layout_format_position. Defaulting to 'left'."
            echo "$1"
            ;;
    esac
}

hide_cursor

while true; do
    OUTPUT="$layout_format"

    # Loop through each function name specified in the layout and replace it with its output
    for func in $layout_format; do
        if declare -F "$func" > /dev/null; then
            OUTPUT="${OUTPUT/$func/$($func)}"
        fi
    done

    clear

    apply_layout "$OUTPUT"

    update_title "$OUTPUT"

    sleep $update_interval
done
