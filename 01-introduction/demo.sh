#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 01: Introduction (5 min)"

print_step 1 "Check Git version"
execute_command "git --version"
wait_user

print_step 2 "Create a test directory"
execute_command "mkdir -p module01-test && cd module01-test"
echo "Current directory: $(pwd)"
wait_user

print_step 3 "Initialize Git repository"
execute_command "git init"
wait_user

print_step 4 "Verify .git directory"
execute_command "ls -la"
echo -e "\n${GRN}Module 01 completed!${RST}"
