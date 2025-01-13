#!/bin/bash

# Ubuntupunk's nifty gitmodule update script for use with·                       
# Ultimate Vimrc (Ubuntupunk Edition)                                            
# Copyright 2025 

#This version with globbing action for remove function

#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Prompt user for action
echo -e "${BLUE}Enter (a) for add, (r) for remove, or (u) for update:${NC}"
read -r action

case $action in
    a)
        # Prompt for submodule URL and name if the action is to add
        echo -e "${YELLOW}Please enter the submodule URL:${NC}"
        read -r submodule_url
        echo -e "${YELLOW}Please enter the name for the submodule:${NC}"
        read -r submodule_name
        echo -e "${GREEN}Adding submodule $submodule_name...${NC}"
        git submodule add "$submodule_url" "sources_non_forked/$submodule_name" || {
            echo -e "${RED}Failed to add submodule. Here's what you can do manually:${NC}"
            echo "git submodule add $submodule_url sources_non_forked/$submodule_name"
        }
        ;;
    r)
        # Prompt for submodule name pattern for remove
        echo -e "${YELLOW}Please enter a pattern to match the submodule name to remove (use * for wildcard):${NC}"
        read -r pattern
        # Find matching submodules in sources_non_forked directory
        matches=$(find sources_non_forked -maxdepth 1 -type d -name "$pattern" -printf "%f\n")

        if [ -z "$matches" ]; then
            echo -e "${RED}No submodules match the given pattern.${NC}"
        else
            echo -e "${GREEN}Found the following matching submodules:${NC}"
            echo "$matches"
            echo -e "${YELLOW}Enter the exact name of the submodule you want to remove (or press Enter to cancel):${NC}"
            read -r submodule_name

            if [ -n "$submodule_name" ] && echo "$matches" | grep -q "^$submodule_name$"; then
                echo -e "${GREEN}Removing submodule $submodule_name...${NC}"
                git submodule deinit -f "sources_non_forked/$submodule_name"
                git rm -f "sources_non_forked/$submodule_name"
                rm -rf .git/modules/"sources_non_forked/$submodule_name"
            else
                echo -e "${RED}Removal cancelled or submodule not found.${NC}"
            fi
        fi
        ;;
    u)
        # No prompts needed for update
        echo -e "${GREEN}Updating modules...${NC}"
        ;;
    *)
        echo -e "${RED}Invalid input. Please enter 'a' for add, 'r' for remove, or 'u' for update.${NC}"
        exit 1
        ;;
esac

# Update modules if the action is add, remove, or update
if [ "$action" = "a" ] || [ "$action" = "r" ] || [ "$action" = "u" ]; then
    echo -e "${GREEN}Updating all modules${NC}"
    git submodule update --init --recursive
fi
