#!/bin/bash

CONFIG_DIR="$HOME/.config/bashbar"
CONFIG_FILE="$CONFIG_DIR/bashbar.conf"

if [ ! -d "$CONFIG_DIR" ]; then
    mkdir -p "$CONFIG_DIR"
fi

if [ ! -f "$CONFIG_FILE" ]; then
    cat > "$CONFIG_FILE" <<EOL
# ~/.config/bashbar/bashbar.conf

# Update interval in seconds (you can set this to be slower/faster depending on your needs)
update_interval=1

# Specify the functions you want to include in the layout, separated by spaces
layout_format="cpu_usage mem_usage network_status battery_status clock"

# Choose 'left', 'center', or 'right'
layout_format_position="center"
EOL
fi


# Launch the terminal of choice (change 'kitty' to your terminal) with bashbar.sh
kitty --title "bashbar" bash -i -c '/home/arx/Playspace/Code/sh/Bashbar/bashbar.sh'
