#!/bin/bash
source ./utils/colors.sh
# entry point of my linux enum script

echo -e "${B_GREEN}%%%%%%%%%%%%%%%%%%%%%%%%% Starting enumix \$hell script %%%%%%%%%%%%%%%%%%%%%%%%%\n${RESET}"

source ./modules/sysinfo.sh
source ./modules/userenum.sh