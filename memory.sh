#!/bin/bash

# Function to display the top N largest files
display_largest_files() {
    echo "Top $1 Largest Files:"
    find / -type f -exec du -h {} + 2>/dev/null | sort -rh | head -$1
}

# Function to display the top N largest directories
display_largest_directories() {
    echo "Top $1 Largest Directories:"
    du -h --max-depth=1 / 2>/dev/null | sort -rh | head -$1
}

# Function to delete a portion of the largest files
delete_portion_of_files() {
    read -p "Enter the percentage of each file to delete (0-100): " percentage
    if [[ $percentage =~ ^[0-9]+$ && $percentage -ge 0 && $percentage -le 100 ]]; then
        find / -type f -exec sh -c "dd if=/dev/zero of={} bs=$((($(stat -c %s "{}") * $percentage / 100))) count=1 conv=notrunc" \;
        echo "Deleted $percentage% of the largest files."
    else
        echo "Invalid input. Please enter a percentage between 0 and 100."
    fi
}

# Function to delete a portion of the largest directories
delete_portion_of_directories() {
    read -p "Enter the percentage of each directory to delete (0-100): " percentage
    if [[ $percentage =~ ^[0-9]+$ && $percentage -ge 0 && $percentage -le 100 ]]; then
        du -h --max-depth=1 / 2>/dev/null | sort -rh | head -5 | awk -v perc=$percentage '{print $2}' | xargs -I {} find {} -type f -exec sh -c "dd if=/dev/zero of={} bs=$((($(stat -c %s "{}") * perc / 100))) count=1 conv=notrunc" \;
        echo "Deleted $percentage% of the largest directories."
    else
        echo "Invalid input. Please enter a percentage between 0 and 100."
    fi
}

# Main script
clear
echo "File and Directory Management Script"
echo "-----------------------------------"

# Display the largest files and directories
display_largest_files 5
echo
display_largest_directories 5
echo

# Prompt the user for action
while true; do
    read -p "Do you want to delete (f)iles, (d)irectories, or a (p)ortion? (f/d/p/quit): " choice
    case $choice in
        [Ff]* ) delete_portion_of_files; break;;
        [Dd]* ) delete_portion_of_directories; break;;
        [Pp]* ) echo "Exiting..."; exit 0;;
        [Qq]* ) echo "Exiting..."; exit 0;;
        * ) echo "Please enter 'f', 'd', 'p', or 'quit'.";;
    esac
done

exit 0
