#!/bin/bash
source ./utils/colors.sh # path is starting from the enumix.sh since its the starting point
#features to implement
# - Distribution
# - Kernel Version
# - Architecture
# - Hostname
# - Uptime
# - Current Shell
# - Init System
# - Virtual Machine Detection
# - Container Detection
# - CPU Information
# - Memory Information

echo -e "${B_BLUE}<------------------ System Info ------------------>${RESET}"

# finding system info
distribution=$(cat /etc/os-release | grep -i "^NAME" | cut -d'=' -f2-) # finds the os release info by extracting the line starting with "NAME" and then extracts everything after "=" . so "=" is the delimiter
kernel_version=$(uname -r) # find kernel vesion
arch=$(uname -m) # find architecture
hostname=$(hostnamectl status | grep -i "hostname" | cut -d':' -f2-) # find the static hostname of the current user
uptime=$(uptime) # shows the uptime of the os i.e. how long the os has been active since its last shutdown
current_shell=$(echo $SHELL) # print the current shell of the user
init_prog=$(cat /proc/1/comm) # init is the first program run by the os when its boots up
vm_detect=$(systemd-detect-virt) # find out whether os is running in virtualized platform or not
container_detect=$(cat /proc/1/cgroup) # find out whether os is running in a containerized platform
cpu_info=$(lscpu | grep -i "model name" | cut -d':' -f2- | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//') # finds cpu info and truncates leading and ending spaces
mem_info=$(cat /proc/meminfo | grep -i "^memtotal" | awk '{printf "%-20s %6.2f GB\n", $1, $2/1024/1024}' | cut -d':' -f2- | sed -e 's/^[[:space:]]*//' ) # find memory and use awk command to display info in bytes and then cut to display the memory part only and sed to truncate leading spaces


# displaying values
# first %b = for interpreting the color code
# second %b = for interpreteing the color reset code
# %-20s left aligned 20 character string space reserved
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Distribution" "$RESET" "$distribution"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Kernel" "$RESET" "$kernel_version"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Architecture" "$RESET" "$arch"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Hostname" "$RESET" "$hostname"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Uptime" "$RESET" "$uptime"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Current Shell" "$RESET" "$current_shell"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "INIT PROG" "$RESET" "$init_prog"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Virtualization" "$RESET" "$vm_detect"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Containerization" "$RESET" "$container_detect"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Cpu" "$RESET" "$cpu_info"
printf "%b\t%-20s%b : %s\n" "$B_CYAN" "Memory" "$RESET" "$mem_info"


printf "\n"



