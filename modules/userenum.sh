#!/bin/bash

# features to implement
# - Current User
# - User ID
# - Group Membership
# - Login Shell
# - Home Directory
# - All Users
# - Service Accounts
# - Logged-in Users
# - User Sessions
# - User-owned Processes

echo -e "${B_BLUE}<------------------ User Enumeration Info ------------------>${RESET}"


# finding user information
current_user=$(whoami) # find current user
userid=$(id -u) # find current userid
groupInfo=$(id | sed 's/[0-9()]//g' | grep -oP "groups=\K.*" | tr ',' '\n') # find groups then use sed to remove integers and () symbols from output and then split string based on commas to a newlineusing tr
current_shell=$(cat /etc/passwd | grep -i $current_user | cut -d: -f7) # display the current active shell of the current user
home_dir=$(echo $HOME) # display current user home directory
all_users=$(cat /etc/passwd | cut -d: -f1) # extract all users from passwd file and extract the field 1 only



# displaying values
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Current User" "$RESET" "$current_user"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Hostname" "$RESET" "$userid"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Current Shell" "$RESET" "$current_shell"
printf "%b\t%-20s%b : \n" "$B_CYAN" "Groups" "$RESET"
for group in $groupInfo; do
	printf "\t%-22s%s\n" "" "$group"
done