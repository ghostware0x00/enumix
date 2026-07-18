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

echo -e "${B_BLUE}<------------------ System Information ------------------>"


distribution=$(cat /etc/os-release | grep -i "^NAME" | cut -d'=' -f2-) # finds the os release info by extracting the line starting with "NAME" and then extracts everything after "=" . so "=" is the delimiter
kernel_version=$(uname -r) # find kernel vesion
arch=$(uname -m) # find architecture
hostname=$(hostnamectl status | grep -i "hostname" | cut -d':' -f2-) # find the static hostname of the current user
uptime=$(uptime) # shows the uptime of the os i.e. how long the os has been active since its last shutdown
current_shell=$(echo $SHELL) # print the current shell of the user
init_prog=$(cat /proc/1/comm) # init is the first program run by the os when its boots up

echo -e "${B_CYAN}\tDistribution : ${RESET}$distribution"
echo -e "${B_CYAN}\tKernel Version : ${RESET}$kernel_version"
echo -e "${B_CYAN}\tArchitecture : ${RESET}$arch"
echo -e "${B_CYAN}\tHostname : ${RESET}$hostname"
echo -e "${B_CYAN}\tUptime : ${RESET}$uptime"
echo -e "${B_CYAN}\tSHELL : ${RESET}$current_shell"
echo -e "${B_CYAN}\tINIT PROGRAM : ${RESET}$init_prog"

# detect whether the os is running in virtual machine or not
vm_detect=""
vm_val=$(systemd-detect-virt)
if [ -n "$vm_val" ]
then
	echo -e "${B_CYAN}\tVirtual Machine Detected : ${RESET}$vm_val"
fi


