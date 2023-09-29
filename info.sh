#!/bin/bash

# Function to print section headers
print_section() {
    echo "===================================="
    echo " $1"
    echo "===================================="
}

# Function to display openSUSE information
display_opensuse_info() {
    print_section "openSUSE Information"
    cat /etc/os-release
}

# Function to display Zypper information
display_zypper_info() {
    print_section "Zypper Information"
    sudo zypper -v -V
}

# Function to display current user information
display_user_info() {
    print_section "User Information"
    echo "Username: $USER"
    echo "Home Directory: $HOME"
}

# Function to display current desktop environment
display_desktop_env() {
    print_section "Desktop Environment"
    if [ -n "$XDG_CURRENT_DESKTOP" ]; then
        echo "Current Desktop Environment: $XDG_CURRENT_DESKTOP"
    else
        echo "Current Desktop Environment: Not available"
    fi
}

# Function to display system uptime
display_system_uptime() {
    print_section "System Uptime"
    uptime
}

# Function to display CPU information
display_cpu_info() {
    print_section "CPU Information"
    lscpu
}

# Function to display memory information
display_memory_info() {
    print_section "Memory Information"
    free -h
}

# Function to display disk usage information
display_disk_usage() {
    print_section "Disk Usage"
    df -h
}

# Main script
clear
echo "System Information Script"
echo "-------------------------"

display_opensuse_info
display_zypper_info
display_user_info
display_desktop_env
display_system_uptime
display_cpu_info
display_memory_info
display_disk_usage

exit 0
