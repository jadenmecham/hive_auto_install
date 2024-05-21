#!/bin/sh

# Function to check if a line exists in a file
line_exists() {
    grep -qF "$1" "$2"
}

# Lines to add
lines_to_add="
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
"

# File to modify
sysctl_conf="/etc/sysctl.conf"

# Check if each line exists, and if not, add it
printf "%s\n" "$lines_to_add" | while IFS= read -r line; do
    if ! line_exists "$line" "$sysctl_conf"; then
        echo "$line" | sudo tee -a "$sysctl_conf" >/dev/null
    fi
done

# Apply changes
sudo sysctl -p