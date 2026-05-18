#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 02: Configuration (5 min)"

print_step 1 "Set your identity"
echo -e "${YLW}Enter your name:${RST}"
read -r git_name
execute_command "git config --global user.name \"$git_name\""

echo -e "\n${YLW}Enter your email:${RST}"
read -r git_email
execute_command "git config --global user.email \"$git_email\""
wait_user

print_step 2 "Add useful aliases"
student_command "git config --global alias.st status"
student_command "git config --global alias.lg \"log --graph --oneline --all\""
echo "Aliases 'st' and 'lg' added."
wait_user

print_step 3 "List current configuration"
student_command "git config --list | head -n 10"
echo -e "\n${GRN}Module 02 completed!${RST}"
